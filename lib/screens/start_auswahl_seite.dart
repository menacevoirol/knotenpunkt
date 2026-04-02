import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class StartAuswahlSeite extends StatelessWidget {
  const StartAuswahlSeite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B261E), Color(0xFF2E4432)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WER BIST DU?',
              style: GoogleFonts.specialElite(
                fontSize: 32,
                color: const Color(0xFFC9A66B),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),

            // Auswahl für Kinder
            _ChoiceCard(
              title: 'KLEINER ENTDECKER',
              subtitle: 'Spielen & Lernen',
              icon: Icons.child_care,
              color: const Color(0xFF6B8E23),
              onTap: () => _startApp(context, true),
            ),

            const SizedBox(height: 25),

            // Auswahl für Erwachsene
            _ChoiceCard(
              title: 'WALDLÄUFER',
              subtitle: 'Wissen & Abenteuer',
              icon: Icons.terrain_rounded,
              color: const Color(0xFF4A6F54),
              onTap: () => _startApp(context, false),
            ),
          ],
        ),
      ),
    );
  }

  void _startApp(BuildContext context, bool isChild) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen(isChildMode: isChild)),
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFFC9A66B), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 45, color: Colors.white),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.specialElite(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
