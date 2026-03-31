import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RechtslageSeite extends StatelessWidget {
  const RechtslageSeite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RECHTSLAGE SCHWEIZ',
          style: GoogleFonts.specialElite(fontSize: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'ZGB 699: Wald und Weide sind für alle da. Aber Vorsicht beim Lagern und Feuern!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _buildKantonCard(
            context,
            'Freiburg (FR)',
            'Zelt- und Feuer-Regeln im Wald (inkl. Plaffeien)',
          ),
          _buildKantonCard(
            context,
            'Bern (BE)',
            'Lokale Bestimmungen im Nachbarkanton',
          ),
          _buildKantonCard(
            context,
            'Wallis (VS)',
            'Strikte Feuerverbote beachten',
          ),
        ],
      ),
    );
  }

  Widget _buildKantonCard(BuildContext context, String kanton, String info) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.account_balance, color: Color(0xFF4A6F54)),
        title: Text(
          kanton,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(color: const Color(0xFF333333)),
        ),
        subtitle: Text(
          info,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF666666)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFF4A6F54),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Details für $kanton kommen bald!'),
              backgroundColor: const Color(0xFF243027),
            ),
          );
        },
      ),
    );
  }
}
