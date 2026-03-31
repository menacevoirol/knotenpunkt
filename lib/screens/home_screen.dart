import 'package:flutter/material.dart';
import 'knoten_screen.dart';
import 'rechtslage_screen.dart';
import 'bushcraft_screen.dart';
import 'survival_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _seiten = [
    const KnotenListenSeite(),
    const BushcraftSeite(),
    const RechtslageSeite(),
    const SurvivalSeite(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _seiten[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: const Color(0xFF141C16),
        indicatorColor: const Color(0xFF4A6F54),
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
