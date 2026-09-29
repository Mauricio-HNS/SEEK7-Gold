import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class RunScreen extends StatefulWidget {
  const RunScreen({super.key});
  @override
  State<RunScreen> createState() => _RunScreenState();
}

class _RunScreenState extends State<RunScreen> {
  Timer? timer;
  int seconds = 1200;
  int ads = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (seconds <= 1) {
        timer?.cancel();
        setState(() => seconds = 0);
      } else {
        setState(() => seconds--);
      }
    });
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  String get clock => (seconds ~/ 60).toString().padLeft(2, '0') + ':' + (seconds % 60).toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SEEK RUN'), actions: [
        Padding(padding: const EdgeInsets.only(right: 18), child: Center(child: Text(clock, style: const TextStyle(color: Seek7Colors.goldBright, fontWeight: FontWeight.w800))))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Seek7Colors.surface, borderRadius: BorderRadius.circular(26)),
              child: Stack(children: [
                const Center(child: Icon(Icons.map_rounded, size: 130, color: Color(0xFF252B31))),
                Positioned(top: 80, left: 70, child: _spot('€0.15')),
                Positioned(top: 160, right: 55, child: _spot('€0.30')),
                Positioned(bottom: 80, left: 150, child: _spot('€0.20')),
                Positioned(left: 18, top: 18, child: Text('GOLD SPOTS  ${ads}/5', style: const TextStyle(color: Seek7Colors.muted, fontSize: 11, letterSpacing: 1.5))),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Walk naturally. The next Gold Spot may be nearby.', style: TextStyle(color: Seek7Colors.muted)),
          const SizedBox(height: 14),
          GoldButton(label: 'SIMULATE GOLD SPOT', onPressed: ads >= 5 || seconds == 0 ? () {} : () {
            setState(() => ads++);
            showModalBottomSheet(
              context: context,
              backgroundColor: Seek7Colors.surface,
              builder: (_) => const _ExperienceSheet(),
            );
          }),
        ]),
      ),
    );
  }

  Widget _spot(String value) => Container(
    padding: const EdgeInsets.all(11),
    decoration: const BoxDecoration(color: Seek7Colors.gold, shape: BoxShape.circle),
    child: Text(value, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w900)),
  );
}

class _ExperienceSheet extends StatelessWidget {
  const _ExperienceSheet();

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('GOLD SPOT', style: TextStyle(color: Seek7Colors.goldBright, letterSpacing: 2, fontSize: 11)),
        const SizedBox(height: 12),
        const Text('Sponsored experience', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        const Text('Complete the 5-second experience to unlock your reward.', textAlign: TextAlign.center, style: TextStyle(color: Seek7Colors.muted)),
        const SizedBox(height: 22),
        Container(
          height: 150,
          decoration: BoxDecoration(color: const Color(0xFF22272D), borderRadius: BorderRadius.circular(20)),
          child: const Center(child: Icon(Icons.play_circle_fill_rounded, size: 64, color: Seek7Colors.gold)),
        ),
        const SizedBox(height: 18),
        GoldButton(label: 'COMPLETE 5 SEC • +€0.15', onPressed: () => Navigator.pop(context)),
      ]),
    ),
  );
}
