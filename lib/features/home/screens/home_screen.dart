import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEEK7', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3)),
        actions: [IconButton(onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Notifications'),
            content: const Text('You are all caught up.'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
          ),
        ), icon: const Icon(Icons.notifications_none_rounded))],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Seek7Colors.surface,
        selectedIndex: 0,
        onDestinationSelected: (index) {
          if (index == 1) Navigator.pushNamed(context, '/wallet');
          if (index == 2) Navigator.pushNamed(context, '/run');
          if (index == 3) Navigator.pushNamed(context, '/profile');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Rewards'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
        children: [
          const GoldBalance(balance: 12.40),
          const SizedBox(height: 18),
          Container(
            height: 280,
            decoration: BoxDecoration(
              color: Seek7Colors.surface,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Seek7Colors.gold.withOpacity(.12)),
            ),
            child: Stack(children: [
              const Center(child: Icon(Icons.map_rounded, size: 100, color: Color(0xFF252B31))),
              Positioned(top: 52, left: 52, child: _spot('€0.15')),
              Positioned(top: 118, right: 70, child: _spot('€0.30')),
              Positioned(bottom: 50, left: 150, child: _spot('€0.20')),
              const Positioned(top: 16, left: 18, child: Text('MADRID • NEARBY', style: TextStyle(fontSize: 10, letterSpacing: 1.5, color: Seek7Colors.muted))),
            ]),
          ),
          const SizedBox(height: 16),
          GoldButton(
            label: 'START 20 MIN SEEK RUN',
            onPressed: () => Navigator.pushNamed(context, '/run'),
          ),
          const SizedBox(height: 24),
          const Text('TODAY', style: TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _stat('GOLD SPOTS', '5')),
            const SizedBox(width: 10),
            Expanded(child: _stat('EARNED', '€12.40')),
            const SizedBox(width: 10),
            Expanded(child: _stat('RUNS', '3')),
          ]),
          const SizedBox(height: 24),
          const Text('ACTIVE OPPORTUNITIES', style: TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
          const SizedBox(height: 12),
          _opportunity('Coffee Lab', '5 sec experience', '€0.15'),
          _opportunity('Urban Market', '5 sec experience', '€0.30'),
          _opportunity('Move Studio', '5 sec experience', '€0.20'),
        ],
      ),
    );
  }

  Widget _spot(String value) => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(color: Seek7Colors.gold, shape: BoxShape.circle),
    child: Text(value, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w900)),
  );

  Widget _stat(String title, String value) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Seek7Colors.surface, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 9, color: Seek7Colors.muted)),
      const SizedBox(height: 5),
      Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),
    ]),
  );

  Widget _opportunity(String name, String detail, String reward) => ListTile(
    contentPadding: const EdgeInsets.symmetric(vertical: 4),
    leading: Container(
      width: 46, height: 46,
      decoration: BoxDecoration(color: Seek7Colors.gold.withOpacity(.12), borderRadius: BorderRadius.circular(14)),
      child: const Icon(Icons.location_on, color: Seek7Colors.gold),
    ),
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(detail, style: const TextStyle(color: Seek7Colors.muted)),
    trailing: Text(reward, style: const TextStyle(color: Seek7Colors.goldBright, fontWeight: FontWeight.w800)),
  );
}
