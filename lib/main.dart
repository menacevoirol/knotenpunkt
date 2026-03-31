import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart'; // Importiert deinen neuen Home-Screen

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
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1B261E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6F54),
          brightness: Brightness.dark,
          primary: const Color(0xFFC9A66B),
          secondary: const Color(0xFF6B8E23),
        ),
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
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141C16),
          foregroundColor: Color(0xFFE0E0E0),
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFFF0E5D0),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
