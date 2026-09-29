import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/seek7_theme.dart';
import '../widgets/seek7_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 12.40;
  int spots = 5;
  Timer? timer;
  int seconds = 0;
  bool running = false;

  void startRun() {
    setState(() { running = true; seconds = 20 * 60; });
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (seconds <= 1) {
        timer?.cancel();
        setState(() { seconds = 0; running = false; });
      } else {
        setState(() => seconds--);
      }
    });
  }

  String get clock => (seconds ~/ 60).toString().padLeft(2, '0') + ':' + (seconds % 60).toString().padLeft(2, '0');

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEEK7', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded))],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Seek7Colors.surface,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet_outlined), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined), label: 'Rewards'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 28),
          children: [
            GoldBalance(balance: balance),
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
                if (running) Positioned(
                  right: 18, top: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(color: Seek7Colors.gold, borderRadius: BorderRadius.circular(20)),
                    child: Text(clock, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 16),
            GoldButton(
              label: running ? 'SEEK RUN ACTIVE • ' + clock : 'START 20 MIN SEEK RUN',
              onPressed: running ? () {} : startRun,
            ),
            const SizedBox(height: 24),
            const Text('TODAY', style: TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _stat('GOLD SPOTS', spots.toString())),
              const SizedBox(width: 10),
              Expanded(child: _stat('EARNED', '€' + balance.toStringAsFixed(2))),
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
    leading: Container(width: 46, height: 46, decoration: BoxDecoration(color: Seek7Colors.gold.withOpacity(.12), borderRadius: BorderRadius.circular(14)), child: const Icon(Icons.location_on, color: Seek7Colors.gold)),
    title: Text(name, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(detail, style: const TextStyle(color: Seek7Colors.muted)),
    trailing: Text(reward, style: const TextStyle(color: Seek7Colors.goldBright, fontWeight: FontWeight.w800)),
  );
}
