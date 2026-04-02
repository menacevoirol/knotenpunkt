import 'package:flutter/material.dart';
import 'knoten_screen.dart';
import 'rechtslage_screen.dart';
import 'bushcraft_screen.dart';
import 'survival_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool isChildMode; // NEU
  const HomeScreen({super.key, required this.isChildMode});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Hier entscheiden wir, welche Tabs angezeigt werden
    final seiten = [
      const KnotenListenSeite(),
      const BushcraftSeite(),
      if (!widget.isChildMode) const RechtslageSeite(), // Nur für Erwachsene
      const SurvivalSeite(),
    ];

    final destinations = [
      const NavigationDestination(icon: Icon(Icons.gesture), label: 'Knoten'),
      const NavigationDestination(
        icon: Icon(Icons.handyman),
        label: 'Bushcraft',
      ),
      if (!widget.isChildMode)
        const NavigationDestination(icon: Icon(Icons.gavel), label: 'Recht'),
      const NavigationDestination(
        icon: Icon(Icons.nature_people),
        label: 'Survival',
      ),
    ];

    return Scaffold(
      body: seiten[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: const Color(0xFF141C16),
        indicatorColor: const Color(0xFF4A6F54),
        destinations: destinations,
      ),
    );
  }
}
