import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- DATEN-MODELL ---
class Knoten {
  final String name;
  final String beschreibung;
  final String anleitung;
  final String kategorie;
  final String schwierigkeit; // Schwierigkeitsgrad für die Übersicht

  Knoten({
    required this.name,
    required this.beschreibung,
    required this.anleitung,
    required this.kategorie,
    required this.schwierigkeit,
  });
}

// --- DEINE KNOTEN-DATENBANK ---
final List<Knoten> alleKnoten = [
  Knoten(
    name: 'Sibirischer Knoten',
    kategorie: 'Zelt',
    schwierigkeit: 'Einfach',
    beschreibung: 'Der ultimative Knoten für die Ridgeline (Firstschnur).',
    anleitung:
        '1. Seil um den Baum legen.\n2. Schlaufe um die Hand drehen.\n3. Kurzes Ende durchziehen und auf Slip setzen.',
  ),
  Knoten(
    name: 'Rundtörn mit zwei Schlägen',
    kategorie: 'Hängematte',
    schwierigkeit: 'Mittel',
    beschreibung:
        'Hält bombenfest und lässt sich auch unter Last leicht lösen.',
    anleitung:
        '1. Seil zweimal um den Baum wickeln.\n2. Zwei einfache Knoten um das stehende Seilende machen.',
  ),
  Knoten(
    name: 'Schotstek',
    kategorie: 'Verbindung',
    schwierigkeit: 'Einfach',
    beschreibung: 'Verbindet zwei Seile (auch ungleich dick).',
    anleitung:
        '1. Bucht mit dem dicken Seil legen.\n2. Dünnes Seil durchführen und unter sich selbst festklemmen.',
  ),
  Knoten(
    name: 'Achterknoten',
    kategorie: 'Sicherung',
    schwierigkeit: 'Einfach',
    beschreibung: 'Der Standard-Stoppknoten gegen Ausrauschen.',
    anleitung:
        '1. Lege eine Schlaufe.\n2. Einmal unten rum.\n3. Von oben durch das Auge stecken.',
  ),
  Knoten(
    name: 'Prusik',
    kategorie: 'Verbindung',
    schwierigkeit: 'Mittel',
    beschreibung: 'Gleit- und Klemmknoten für Tarps an der Ridgeline.',
    anleitung:
        '1. Reepschnur-Schlaufe um das Hauptseil legen.\n2. Dreimal durch sich selbst wickeln.',
  ),
];

// --- HAUPTSEITE ---
class KnotenListenSeite extends StatefulWidget {
  const KnotenListenSeite({super.key});

  @override
  State<KnotenListenSeite> createState() => _KnotenListenSeiteState();
}

class _KnotenListenSeiteState extends State<KnotenListenSeite> {
  String _ausgewaehlteKategorie = 'Alle';

  // Zuordnung von Kategorien zu Icons (für Filter und Liste)
  final Map<String, IconData> _kategorieIcons = {
    'Alle': Icons.reorder,
    'Zelt': Icons.night_shelter_sharp,
    'Hängematte': Icons.airline_seat_flat_angled,
    'Verbindung': Icons.link,
    'Sicherung': Icons.security,
  };

  @override
  Widget build(BuildContext context) {
    final kategorien = _kategorieIcons.keys.toList();

    final gefilterteKnoten = _ausgewaehlteKategorie == 'Alle'
        ? alleKnoten
        : alleKnoten
              .where((k) => k.kategorie == _ausgewaehlteKategorie)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KNOTEN-ÜBERSICHT',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          // Filter-Bar oben
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: kategorien.map((kat) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    avatar: Icon(
                      _kategorieIcons[kat],
                      size: 18,
                      color: _ausgewaehlteKategorie == kat
                          ? Colors.white
                          : const Color(0xFF4A6F54),
                    ),
                    label: Text(kat),
                    selected: _ausgewaehlteKategorie == kat,
                    selectedColor: const Color(0xFF4A6F54),
                    onSelected: (selected) {
                      setState(() {
                        _ausgewaehlteKategorie = kat;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // Die verbesserte Liste
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: gefilterteKnoten.length,
              itemBuilder: (context, index) {
                return _buildKnotenCard(context, gefilterteKnoten[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKnotenCard(BuildContext context, Knoten knoten) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        // Kategorie-Icon links in einem Kreis
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF4A6F54).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _kategorieIcons[knoten.kategorie],
            color: const Color(0xFF4A6F54),
            size: 26,
          ),
        ),
        // Name: Gross und Markant
        title: Text(
          knoten.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF141C16),
          ),
        ),
        // Kategorie & Schwierigkeit
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Text(
                knoten.kategorie,
                style: const TextStyle(
                  color: Color(0xFF4A6F54),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text("  •  "),
              Text(
                knoten.schwierigkeit,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => KnotenDetailSeite(knoten: knoten),
            ),
          );
        },
      ),
    );
  }
}

// --- DETAILSEITE ---
class KnotenDetailSeite extends StatelessWidget {
  final Knoten knoten;
  const KnotenDetailSeite({super.key, required this.knoten});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(knoten.name, style: GoogleFonts.specialElite(fontSize: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5D0),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC9A66B), width: 2),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_search, size: 50, color: Color(0xFF4A6F54)),
                  SizedBox(height: 10),
                  Text(
                    'GIF-Animation folgt',
                    style: TextStyle(color: Color(0xFF333333)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'ANWENDUNG',
            style: GoogleFonts.specialElite(
              fontSize: 18,
              color: const Color(0xFF4A6F54),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            knoten.beschreibung,
            style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 25),
          Text(
            'ANLEITUNG',
            style: GoogleFonts.specialElite(
              fontSize: 18,
              color: const Color(0xFF4A6F54),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5D0).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              knoten.anleitung,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ),
        ],
      ),
    );
  }
}
