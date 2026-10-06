import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  static const items = [
    ('MAPA', '/home', Icons.map_rounded),
    ('CARTEIRA', '/wallet', Icons.account_balance_wallet_rounded),
    ('NEGÓCIOS', '/merchant', Icons.storefront_rounded),
    ('PERFIL', '/profile', Icons.person_rounded),
    ('SEEK RUN', '/run', Icons.directions_run_rounded),
    ('LIVE MINING', '/live-run', Icons.location_searching_rounded),
    ('LOGIN', '/auth', Icons.login_rounded),
    ('ONBOARDING', '/onboarding', Icons.slideshow_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MODO DESENVOLVEDOR')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Seek7Colors.blueLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Acesso rápido para testar todas as telas do protótipo sem cadastro.',
              style: TextStyle(color: Seek7Colors.navy, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 18),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  tileColor: Seek7Colors.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  leading: CircleAvatar(
                    backgroundColor: Seek7Colors.gold,
                    child: Icon(item.$3, color: Seek7Colors.navy),
                  ),
                  title: Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w800)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.pushNamed(context, item.$2),
                ),
              )),
        ],
      ),
    );
  }
}
