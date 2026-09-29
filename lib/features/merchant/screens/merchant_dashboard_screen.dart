import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class MerchantDashboardScreen extends StatelessWidget {
  const MerchantDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SEEK7 FOR BUSINESS')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text('CAMPAIGN CONTROL', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Turn nearby people into verified opportunities.', style: TextStyle(color: Seek7Colors.muted)),
          const SizedBox(height: 22),
          Row(children: [
            Expanded(child: _metric('BUDGET', '€500')),
            const SizedBox(width: 10),
            Expanded(child: _metric('VIEWS', '2,481')),
            const SizedBox(width: 10),
            Expanded(child: _metric('VISITS', '317')),
          ]),
          const SizedBox(height: 24),
          GoldButton(label: 'CREATE CAMPAIGN', onPressed: () {}),
          const SizedBox(height: 18),
          const Text('ACTIVE CAMPAIGNS', style: TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
          const SizedBox(height: 10),
          _campaign('Coffee Lab — Madrid', '€0.15 per verified completion'),
          _campaign('Urban Market — Centro', '€0.30 per verified completion'),
        ],
      ),
    );
  }

  Widget _metric(String title, String value) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Seek7Colors.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 9, color: Seek7Colors.muted)),
      const SizedBox(height: 6),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
    ]),
  );

  Widget _campaign(String title, String subtitle) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.campaign_outlined, color: Seek7Colors.gold),
    title: Text(title),
    subtitle: Text(subtitle, style: const TextStyle(color: Seek7Colors.muted)),
    trailing: const Icon(Icons.chevron_right),
  );
}
