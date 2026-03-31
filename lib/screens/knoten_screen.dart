import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- DATEN-MODELL ---
class Knoten {
  final String name;
  final String beschreibung;
  final String anleitung;
  final List<String> einsatzzweck; // NEU: Liste von Einsatzgebieten
  final String schwierigkeit;

  Knoten({
    required this.name,
    required this.beschreibung,
    required this.anleitung,
    required this.einsatzzweck,
    required this.schwierigkeit,
  });
}

// --- ERWEITERTE DATENBANK (ae, oe, ue in den Strings fuer die Logik) ---
final List<Knoten> alleKnoten = [
  Knoten(
    name: 'Sibirischer Knoten',
    einsatzzweck: ['Tarp befestigen', 'Schlaufe bilden'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Fixiert die Firstschnur schnell am Baum.',
    anleitung:
        '1. Seil um Baum legen.\n2. Schlaufe drehen.\n3. Ende durchziehen.',
  ),
  Knoten(
    name: 'Kreuzbund',
    einsatzzweck: ['Querholz befestigen', 'Konstruieren'],
    schwierigkeit: 'Mittel',
    beschreibung: 'Verbindet zwei Äste im rechten Winkel.',
    anleitung:
        '1. Webeleinstek am Stamm.\n2. Drei Windungen um beide Hoelzer.\n3. Drei Wuerge-Windungen.',
  ),
  Knoten(
    name: 'Schotstek',
    einsatzzweck: ['Verbindung'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Verbindet zwei Seile sicher.',
    anleitung: '1. Bucht legen.\n2. Anderes Seil durch und rundum fuehren.',
  ),
  Knoten(
    name: 'Topf-Knoten',
    einsatzzweck: ['Kochutensil befestigen'],
    schwierigkeit: 'Einfach',
    beschreibung: 'Haelt einen Topf sicher ueber dem Feuer.',
    anleitung:
        '1. Schlaufe um den Topfgriff.\n2. Mit halben Schlaegen sichern.',
  ),
  Knoten(
    name: 'Prusik',
    einsatzzweck: ['Tarp befestigen', 'Sicherung'],
    schwierigkeit: 'Mittel',
    beschreibung: 'Klemmknoten fuer verstellbare Tarp-Spannung.',
    anleitung: '1. Drei Wicklungen um das Hauptseil.',
  ),
];

class KnotenListenSeite extends StatefulWidget {
  const KnotenListenSeite({super.key});

  @override
  State<KnotenListenSeite> createState() => _KnotenListenSeiteState();
}

class _KnotenListenSeiteState extends State<KnotenListenSeite> {
  String? _gewaehlterEinsatz; // Speichert, was der User machen will

  // Definition der Auswahlmoeglichkeiten (Keine Sonderzeichen in den Keys)
  final Map<String, IconData> _einsatzOptionen = {
    'Tarp befestigen': Icons.night_shelter,
    'Verbindung': Icons.link,
    'Querholz befestigen': Icons.architecture,
    'Kochutensil befestigen': Icons.soup_kitchen,
    'Sicherung': Icons.security,
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
      body: _gewaehlterEinsatz == null
          ? _buildInteraktiveAuswahl()
          : _buildErgebnisListe(),
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
        title: Text(
          knoten.name.toUpperCase(),
          // SCHRIFTDICKE: Muss ein Wert aus der w-Liste sein (w100 bis w900)
          // FARBE MIT DURCHSICHTIGKEIT: Hier kommt die 0.8 zum Einsatz
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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

// --- DETAILSEITE (AUCH OPTIMIERT) ---
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
                fontSize: 20, // RIESIGE SCHRIFT
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
