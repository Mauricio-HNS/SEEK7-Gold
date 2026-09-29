import 'package:flutter/material.dart';
import '../theme/seek7_theme.dart';

class GoldBalance extends StatelessWidget {
  final double balance;
  const GoldBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D1A13), Color(0xFF11151A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Seek7Colors.gold.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SEEK7 WALLET', style: TextStyle(color: Seek7Colors.muted, fontSize: 11, letterSpacing: 2)),
          const SizedBox(height: 8),
          Text('€' + balance.toStringAsFixed(2), style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          const Text('Available balance', style: TextStyle(color: Seek7Colors.muted)),
        ],
      ),
    );
  }
}

class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const GoldButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Seek7Colors.gold,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .8)),
      ),
    );
  }
}
