import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // WICHTIG: Siehe Schritt 2!

void main() {
  runApp(const KnotenpunktApp());
}

class KnotenpunktApp extends StatelessWidget {
  const KnotenpunktApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Knotenpunkt',
      theme: ThemeData(
        // RUSTIKALES OUTDOOR-THEME 2.0
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(
          0xFF1B261E,
        ), // Ganz dunkles Waldgrün (Basis)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6F54),
          brightness: Brightness.dark,
          primary: const Color(0xFFC9A66B), // Sand/Beige für Akzente
          secondary: const Color(0xFF6B8E23),
        ),
        // Eine coolere Schriftart (wie eine Schreibmaschine)
        textTheme: GoogleFonts.notoSerifTextTheme(
          const TextTheme(
            headlineLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE0E0E0),
              letterSpacing: 1.2,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE0E0E0),
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xFFB0B0B0),
              height: 1.5,
            ), // Mehr Zeilenabstand für bessere Lesbarkeit
          ),
        ),
        // Schickeres AppBar-Design (fast schwarz)
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141C16),
          foregroundColor: Color(0xFFE0E0E0),
          elevation: 0,
          centerTitle: true,
        ),
        // Schickeres Card-Design (mit einem Pergament-Touch)
        cardTheme: CardThemeData(
          color: const Color(0xFFF0E5D0), // Ein ganz helles Pergament/Beige
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ), // Runder, organischer
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KNOTENPUNKT',
          style: GoogleFonts.specialElite(
            fontSize: 24, // Grösser und rustikaler
            color: const Color(0xFFE0E0E0),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 🌲 HINTERGRUNDBILD (Siehe Schritt 3!)
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/waldboden.jpg', // Der Pfad zu deinem Bild
          //     fit: BoxFit.cover,
          //     opacity: const AlwaysStoppedAnimation(0.2), // Ganz dezent im Hintergrund
          //   ),
          // ),

          // Der eigentliche Inhalt
          Container(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              children: [
                Text(
                  'Willkommen im Wald!',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),
                _buildMenuCard(
                  context,
                  Icons.gesture,
                  '🪢 Knoten-Kurs',
                  'Meistere die wichtigsten Schlingen',
                ),
                _buildMenuCard(
                  context,
                  Icons.handyman,
                  '🪓 Bushcraft Basics',
                  'Schnitzen, Feuer & Lagerbau',
                ),
                _buildMenuCard(
                  context,
                  Icons.gavel,
                  '⚖️ Rechtslage Wald',
                  'Wo darf ich zelten & feuern?',
                ),
                _buildMenuCard(
                  context,
                  Icons.nature_people,
                  '🌱 Survival Tricks',
                  'Tipps & Tricks für draussen',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    IconData icon,
    String title,
    String sub,
  ) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 25,
      ), // Mehr Abstand zwischen den Karten
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        leading: Icon(
          icon,
          color: const Color(0xFF4A6F54),
          size: 35,
        ), // Waldgrüne Icons auf Pergament
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF333333), // Dunklerer Text auf Pergament
          ),
        ),
        subtitle: Text(
          sub,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF666666), // Dunklerer Text auf Pergament
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF4A6F54),
          size: 20,
        ),
        onTap: () {
          if (title.contains('Knoten')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const KnotenListenSeite(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Der Bereich $title kommt bald!'),
                backgroundColor: const Color(0xFF243027),
              ),
            );
          }
        },
      ),
    );
  }
}

// Auch die Unterseite kriegt das Theme ab
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
        leading: Icon(Icons.waves, color: const Color(0xFF4A6F54), size: 30),
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
          Icons.animation,
          color: Colors.blueAccent,
          size: 20,
        ), // Hier kommt die Animation hin
        onTap: () {
          // Später: Detailseite mit Lottie-Animation
        },
      ),
    );
  }
}
