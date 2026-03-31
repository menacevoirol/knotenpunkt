import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BushcraftSeite extends StatelessWidget {
  const BushcraftSeite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BUSHCRAFT BASICS',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.handyman, size: 80, color: Color(0xFF4A6F54)),
            const SizedBox(height: 20),
            Text(
              'Bushcraft Basics folgt in Kürze!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
