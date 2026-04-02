import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- DATEN-MODELL ---
class Knoten {
  final String name;
  final String anwendung;
  final String beschreibung;
  final String anleitung;
  final List<String> einsatzzweck;
  final String schwierigkeit;

  Knoten({
    required this.name,
    required this.anwendung,
    required this.beschreibung,
    required this.anleitung,
    required this.einsatzzweck,
    required this.schwierigkeit,
  });
}

// --- ERWEITERTE DATENBANK  ---
final List<Knoten> alleKnoten = [
  Knoten(
    name: 'Sibirischer Knoten',
    anwendung: 'FIRSTSCHNUR FIXIEREN',
    einsatzzweck: ['Schlafplatz'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Fixiert die Firstschnur schnell am Baum.',
    anleitung:
        '1. Seil um Baum legen.\n2. Schlaufe drehen.\n3. Ende durchziehen.',
  ),
  Knoten(
    name: 'Kreuzbund',
    anwendung: 'GERÜST / DREIBEIN BAUEN',
    einsatzzweck: ['Lagerbau', 'Kochstelle'],
    schwierigkeit: 'Mittel',
    beschreibung: 'Verbindet zwei Äste im rechten Winkel.',
    anleitung:
        '1. Webeleinstek am Stamm.\n2. Drei Windungen um beide Hoelzer.\n3. Drei Wuerge-Windungen.',
  ),
  Knoten(
    name: 'Schotstek',
    anwendung: 'SEILE VERLÄNGERN',
    einsatzzweck: ['Verbindungen'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Verbindet zwei Seile sicher.',
    anleitung: '1. Bucht legen.\n2. Anderes Seil durch und rundum fuehren.',
  ),
  Knoten(
    name: 'Topf-Knoten',
    anwendung: 'KOCHTOPF AUFHÄNGEN',
    einsatzzweck: ['Kochstelle'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Haelt einen Topf sicher ueber dem Feuer.',
    anleitung:
        '1. Schlaufe um den Topfgriff.\n2. Mit halben Schlaegen sichern.',
  ),
  Knoten(
    name: 'Prusik',
    anwendung: 'TARP-SPANNUNG JUSTIEREN',
    einsatzzweck: ['Schlafplatz', 'Notfall'],
    schwierigkeit: 'Mittel',
    beschreibung: 'Klemmknoten fuer verstellbare Tarp-Spannung.',
    anleitung: '1. Drei Wicklungen um das Hauptseil.',
  ),

  Knoten(
    name: 'Kreuzbund',
    anwendung: 'QUERHOLZ FIXIEREN',
    einsatzzweck: [
      'Lagerbau',
      'Verbindungen',
    ], // Erscheint nun in beiden Rubriken
    schwierigkeit: 'Mittel',
    beschreibung:
        'Verbindet zwei Äste im rechten Winkel. Unverzichtbar für Tische, Bänke oder Gestelle.',
    anleitung:
        '1. Starte mit einem Webeleinstek am senkrechten Stamm.\n'
        '2. Führe das Seil abwechselnd über und unter die Hölzer (3-4 Runden).\n'
        '3. Mache 2-3 Würgeschläge (Frapping) zwischen den Hölzern, um alles extrem zu spannen.\n'
        '4. Schliesse mit einem Webeleinstek am Querholz ab.',
  ),
];

class KnotenListenSeite extends StatefulWidget {
  const KnotenListenSeite({super.key});

  @override
  State<KnotenListenSeite> createState() => _KnotenListenSeiteState();
}

class _KnotenListenSeiteState extends State<KnotenListenSeite>
    with SingleTickerProviderStateMixin {
  String? _gewaehlterEinsatz;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Die Animation laeuft 10 Sekunden lang hin und her (sehr langsam!)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Definition der Auswahlmoeglichkeiten (Keine Sonderzeichen in den Keys)
  final Map<String, IconData> _einsatzOptionen = {
    'Schlafplatz': Icons.bed, // Tarp & Hängematte
    'Kochstelle': Icons.local_fire_department, // Töpfe & Dreibein
    'Lagerbau': Icons.handyman, // Querhölzer & Möbel
    'Verbindungen': Icons.link, // Seile verknüpfen
    'Notfall': Icons.warning_amber, // Sicherung
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KNOTEN-ÜBERSICHT', // Titel darf Umlaute haben
          style: GoogleFonts.specialElite(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: _gewaehlterEinsatz != null
            ? [
                IconButton(
                  icon: const Icon(Icons.close, size: 30),
                  onPressed: () => setState(() => _gewaehlterEinsatz = null),
                ),
              ]
            : null,
      ),
      body: Stack(
        children: [
          // Hintergrund-Animation
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: AmbientBackgroundPainter(_controller.value),
                );
              },
            ),
          ),
          // Dein eigentlicher Content
          SafeArea(
            child: _gewaehlterEinsatz == null
                ? _buildInteraktiveAuswahl()
                : _buildErgebnisListe(),
          ),
        ],
      ),
    );
  }

  // SCHRITT 1: Die interaktive Abfrage (Riesige Buttons fuer Lesbarkeit)
  Widget _buildInteraktiveAuswahl() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ICH MÖCHTE...',
            style: GoogleFonts.specialElite(
              fontSize: 32,
              color: const Color(0xFF4A6F54),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount:
                  1, // Nur 1 Spalte für maximale Breite und Lesbarkeit
              childAspectRatio: 3.5, // Flache, breite Buttons
              mainAxisSpacing: 15,
              children: _einsatzOptionen.entries.map((entry) {
                return InkWell(
                  onTap: () => setState(() => _gewaehlterEinsatz = entry.key),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF4A6F54,
                      ), // Dunkler Hintergrund fuer weissen Text (Kontrast!)
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Icon(
                          entry.value,
                          size: 40,
                          color: const Color(0xFFC9A66B),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            entry.key.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // SCHRITT 2: Die gefilterten Ergebnisse
  Widget _buildErgebnisListe() {
    final gefilterteKnoten = alleKnoten
        .where((k) => k.einsatzzweck.contains(_gewaehlterEinsatz))
        .toList();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: const Color(0xFF141C16),
          child: Text(
            'LÖSUNG: ${_gewaehlterEinsatz?.toUpperCase()}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC9A66B),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: gefilterteKnoten.length,
            itemBuilder: (context, index) =>
                _buildKnotenCard(context, gefilterteKnoten[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildKnotenCard(BuildContext context, Knoten knoten) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 20),
      color: const Color(0xFFF0E5D0), // Helle Karte
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        // Der Titel wird nun eine Column, um das Aktions-Label (Anwendung) anzuzeigen
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // DAS AKTIONS-LABEL (z.B. "FIRSTSCHNUR FIXIEREN")
            Text(
              knoten.anwendung.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Color(0xFF4A6F54), // Waldgrün
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            // DER NAME DES KNOTENS
            Text(
              knoten.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'LEVEL: ${knoten.schwierigkeit.toUpperCase()}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A6F54),
            ),
          ),
        ),
        trailing: const Icon(
          Icons.play_circle_fill,
          size: 50,
          color: Color(0xFF4A6F54),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (c) => KnotenDetailSeite(knoten: knoten)),
        ),
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
        title: Text(
          knoten.name.toUpperCase(),
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Icon(Icons.play_arrow, size: 80, color: Colors.white),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'ANLEITUNG',
            style: GoogleFonts.specialElite(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A6F54),
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5D0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              knoten.anleitung,
              style: const TextStyle(
                fontSize: 20,
                height: 1.5,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AmbientBackgroundPainter extends CustomPainter {
  final double animationValue;
  AmbientBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC9A66B)
          .withValues(alpha: 0.1) // Goldton, sehr blass
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        30,
      ); // Weiche Ränder

    // Wir zeichnen 3 grosse, weiche Lichtpunkte, die "schweben"
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * (0.3 + 0.1 * animationValue)),
      100,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * (0.6 - 0.1 * animationValue)),
      150,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * (0.8 + 0.05 * animationValue)),
      120,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
