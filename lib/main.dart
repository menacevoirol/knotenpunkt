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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Merkt sich, welcher Tab gerade offen ist

  // Die verschiedenen Seiten (Views), die unten in der Leiste liegen
  final List<Widget> _seiten = [
    const KnotenListenSeite(), // 0: Dein Knoten-Kurs (wird direkt beim Start angezeigt)
    const PlaceholderSeite(
      titel: 'Bushcraft Basics',
      icon: Icons.handyman,
    ), // 1: Bushcraft
    const PlaceholderSeite(
      titel: 'Rechtslage Schweiz',
      icon: Icons.gavel,
    ), // 2: Schweizer Wald-Recht
    const PlaceholderSeite(
      titel: 'Survival Tricks',
      icon: Icons.nature_people,
    ), // 3: Survival
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Die generelle AppBar oben fliegt raus, da jede Unterseite nun ihre eigene
      // AppBar mit passendem Titel mitbringt.

      // Der Body wechselt den Inhalt, je nachdem worauf du unten tippst
      body: _seiten[_currentIndex],

      // Die rustikale, untere Navigationsleiste
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index; // Wechselt den aktiven Tab
          });
        },
        backgroundColor: const Color(0xFF141C16), // Sehr dunkles AppBar-Grün
        indicatorColor: const Color(
          0xFF4A6F54,
        ), // Waldgrüne Hervorhebung für den aktiven Tab
        destinations: const [
          NavigationDestination(icon: Icon(Icons.gesture), label: 'Knoten'),
          NavigationDestination(icon: Icon(Icons.handyman), label: 'Bushcraft'),
          NavigationDestination(icon: Icon(Icons.gavel), label: 'Recht'),
          NavigationDestination(
            icon: Icon(Icons.nature_people),
            label: 'Survival',
          ),
        ],
      ),
    );
  }
}

// Eine kleine Hilfsklasse für die noch nicht fertigen Seiten,
// damit die App beim Klicken nicht abstürzt.
class PlaceholderSeite extends StatelessWidget {
  final String titel;
  final IconData icon;

  const PlaceholderSeite({super.key, required this.titel, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titel.toUpperCase(),
          style: GoogleFonts.specialElite(
            fontSize: 22,
            color: const Color(0xFFE0E0E0),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: const Color(0xFF4A6F54)),
            const SizedBox(height: 20),
            Text(
              '$titel folgt in Kürze!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
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
