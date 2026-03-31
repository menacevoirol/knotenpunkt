import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurvivalSeite extends StatelessWidget {
  const SurvivalSeite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SURVIVAL TRICKS',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.nature_people, size: 80, color: Color(0xFF4A6F54)),
            const SizedBox(height: 20),
            Text(
              'Survival Tricks folgt in Kürze!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
