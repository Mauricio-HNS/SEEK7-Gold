import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const GoldBalance(balance: 12.40),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _action(Icons.arrow_upward, 'Transfer')),
            const SizedBox(width: 10),
            Expanded(child: _action(Icons.add, 'Add money')),
            const SizedBox(width: 10),
            Expanded(child: _action(Icons.history, 'History')),
          ]),
          const SizedBox(height: 28),
          const Text('RECENT ACTIVITY', style: TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
          const SizedBox(height: 10),
          _transaction('Coffee Lab', '+€0.15', 'Gold Spot completed'),
          _transaction('Urban Market', '+€0.30', 'Gold Spot completed'),
          _transaction('Move Studio', '+€0.20', 'Gold Spot completed'),
        ],
      ),
    );
  }

  Widget _action(IconData icon, String label) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(color: Seek7Colors.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(children: [Icon(icon, color: Seek7Colors.gold), const SizedBox(height: 8), Text(label, style: const TextStyle(fontSize: 11))]),
  );

  Widget _transaction(String title, String amount, String detail) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const CircleAvatar(backgroundColor: Color(0xFF29251A), child: Icon(Icons.location_on, color: Seek7Colors.gold)),
    title: Text(title),
    subtitle: Text(detail, style: const TextStyle(color: Seek7Colors.muted)),
    trailing: Text(amount, style: const TextStyle(color: Seek7Colors.success, fontWeight: FontWeight.w800)),
  );
}
