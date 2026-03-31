import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/kantone_data.dart';

class RechtslageSeite extends StatefulWidget {
  const RechtslageSeite({super.key});

  @override
  State<RechtslageSeite> createState() => _RechtslageSeiteState();
}

class _RechtslageSeiteState extends State<RechtslageSeite> {
  bool _zeigeKarte = false;
  LatLng? _aktuellerStandort;
  final MapController _mapController = MapController();
  bool _laedt = false;
  String _zonenInfo =
      "Tippe auf das GPS-Icon oder auf einen Ort auf der Karte.";

  // Funktion: GPS-Standort abrufen
  Future<void> _standortUndZonenCheck() async {
    setState(() {
      _laedt = true;
      _zonenInfo = "Suche Standort...";
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 15),
      );
      LatLng punkt = LatLng(position.latitude, position.longitude);

      setState(() => _aktuellerStandort = punkt);
      _mapController.move(punkt, 14.0);
      await _abfrageBund(punkt);
    } catch (e) {
      _zeigeFehler("GPS-Fehler: Bitte aktiviere dein Standort-Signal.");
    } finally {
      setState(() => _laedt = false);
    }
  }

  // Abfrage der Schutzzonen und Besonderheiten beim Bund
  Future<void> _abfrageBund(LatLng punkt) async {
    final layers = [
      'ch.bafu.wildruhezonen-jagdrechtlich',
      'ch.bafu.waldreservate',
      'ch.bafu.naturdenkmaeler-landschaften',
      'ch.bafu.bundesinventar-auengebiete',
      'ch.bafu.geotope',
      'ch.bafu.schutzgebiete-paerke_nationaler_bedeutung',
    ].join(',');

    final url = Uri.parse(
      'https://api3.geo.admin.ch/rest/services/all/MapServer/identify?'
      'geometryType=esriGeometryPoint'
      '&geometry=${punkt.longitude},${punkt.latitude}'
      '&imageDisplay=100,100,96'
      '&mapExtent=0,0,0,0'
      '&tolerance=30'
      '&layers=all:$layers'
      '&sr=4326'
      '&returnGeometry=false',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        if (results.isEmpty) {
          setState(
            () => _zonenInfo = "✅ Keine speziellen Schutzzonen gefunden.",
          );
        } else {
          final List<String> funde = results
              .map<String>((r) {
                final Map<String, dynamic> attributes = r['attributes'] ?? {};
                return (attributes['label'] ??
                        attributes['name'] ??
                        attributes['objektname'] ??
                        "Interessanter Ort")
                    .toString();
              })
              .toSet()
              .toList();

          setState(() {
            _zonenInfo =
                "🔎 ENTDECKT: ${funde.join(', ')}.\nBitte Hinweisschilder vor Ort beachten!";
          });
        }
      }
    } catch (e) {
      setState(
        () => _zonenInfo = "Zonen-Check fehlgeschlagen (Internet prüfen).",
      );
    }
  }

  void _zeigeFehler(String text) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(text), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECHTSLAGE SCHWEIZ',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _zeigeKarte ? Icons.list : Icons.map,
              color: const Color(0xFFC9A66B),
            ),
            onPressed: () => setState(() => _zeigeKarte = !_zeigeKarte),
          ),
        ],
      ),
      body: _zeigeKarte ? _buildKartenAnsicht() : _buildListenAnsicht(),
      floatingActionButton: _zeigeKarte
          ? FloatingActionButton(
              backgroundColor: const Color(0xFF4A6F54),
              onPressed: _standortUndZonenCheck,
              child: _laedt
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.my_location, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildKartenAnsicht() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(46.8182, 8.2275),
              initialZoom: 8.0,
              onTap: (tapPosition, point) {
                setState(() {
                  _aktuellerStandort = point;
                  _laedt = true;
                });
                _abfrageBund(point).then((_) => setState(() => _laedt = false));
              },
            ),
            children: [
              // 1. Basiskarte (Bleibt gleich)
              TileLayer(
                urlTemplate:
                    'https://wmts.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg',
                userAgentPackageName: 'com.example.knotenpunkt_app',
              ),

              // 2. Wildruhezonen (Korrekt über wmsOptions)
              Opacity(
                opacity: 0.4,
                child: TileLayer(
                  wmsOptions: WMSTileLayerOptions(
                    baseUrl: 'https://wms.geo.admin.ch/',
                    layers: ['ch.bafu.wildruhezonen-jagdrechtlich'],
                    format: 'image/png',
                    transparent: true,
                  ),
                ),
              ),

              // 3. Waldreservate (Korrekt über wmsOptions)
              Opacity(
                opacity: 0.4,
                child: TileLayer(
                  wmsOptions: WMSTileLayerOptions(
                    baseUrl: 'https://wms.geo.admin.ch/',
                    layers: ['ch.bafu.waldreservate'],
                    format: 'image/png',
                    transparent: true,
                  ),
                ),
              ),

              if (_aktuellerStandort != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _aktuellerStandort!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        // Die Info-Box (unverändert)
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF141C16),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ZONEN-CHECK",
                style: GoogleFonts.specialElite(
                  color: const Color(0xFFC9A66B),
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              if (_laedt)
                const LinearProgressIndicator(
                  color: Color(0xFFC9A66B),
                  backgroundColor: Colors.transparent,
                )
              else
                Text(
                  _zonenInfo,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListenAnsicht() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF243027),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFC9A66B).withValues(alpha: 0.5),
            ),
          ),
          child: const Text(
            'Im Wald ist das Betreten frei (ZGB 699). Zelten und Feuern wird jedoch kantonal geregelt.',
            style: TextStyle(
              color: Color(0xFFE0E0E0),
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(height: 25),
        ...schweizerKantone.map((k) => _buildKantonCard(context, k)),
      ],
    );
  }

  Widget _buildKantonCard(BuildContext context, KantonRegel kanton) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Image.asset(
          kanton.wappenPfad,
          width: 35,
          errorBuilder: (c, e, s) => const Icon(Icons.shield),
        ),
        title: Text(
          '${kanton.name} (${kanton.kuerzel})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(kanton.zusammenfassung),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => KantonDetailSeite(kanton: kanton)),
        ),
      ),
    );
  }
}

class KantonDetailSeite extends StatelessWidget {
  final KantonRegel kanton;
  const KantonDetailSeite({super.key, required this.kanton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'REGELN: ${kanton.kuerzel}',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Image.asset(
              kanton.wappenPfad,
              height: 100,
              errorBuilder: (c, e, s) => const Icon(Icons.shield, size: 100),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            kanton.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5D0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(kanton.details, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
