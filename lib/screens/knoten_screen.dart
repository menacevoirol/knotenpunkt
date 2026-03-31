import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KnotenListenSeite extends StatelessWidget {
  const KnotenListenSeite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KNOTEN-ÜBERSICHT',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildKnotenItem(
            context,
            'Achterknoten',
            'Der wichtigste Stoppknoten',
          ),
          const Divider(color: Color(0xFF333333), height: 30),
          _buildKnotenItem(
            context,
            'Mastwurf',
            'Seil an einem Baum befestigen',
          ),
          const Divider(color: Color(0xFF333333), height: 30),
          _buildKnotenItem(context, 'Kreuzknoten', 'Zwei Seile verbinden'),
        ],
      ),
    );
  }

  Widget _buildKnotenItem(
    BuildContext context,
    String name,
    String beschreibung,
  ) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.waves, color: Color(0xFF4A6F54), size: 30),
        title: Text(
          name,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: const Color(0xFF333333)),
        ),
        subtitle: Text(
          beschreibung,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF666666)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF4A6F54),
          size: 16,
        ),
        onTap: () {
          if (name == 'Achterknoten') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnotenDetailSeite(
                  titel: 'Achterknoten',
                  beschreibung:
                      '1. Lege eine Bucht (Schlaufe).\n2. Führe das lose Ende einmal komplett um das feste Ende herum.\n3. Stecke das lose Ende von oben durch die Schlaufe.\n4. Ziehe den Knoten fest.',
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Detailseite für $name folgt noch!'),
                backgroundColor: const Color(0xFF243027),
              ),
            );
          }
        },
      ),
    );
  }
}

class KnotenDetailSeite extends StatelessWidget {
  final String titel;
  final String beschreibung;

  const KnotenDetailSeite({
    super.key,
    required this.titel,
    required this.beschreibung,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titel, style: GoogleFonts.specialElite(fontSize: 22)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5D0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'Hier kommt später das GIF hin',
                style: TextStyle(color: Color(0xFF333333)),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text('Anleitung', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 15),
          Text(
            beschreibung,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
