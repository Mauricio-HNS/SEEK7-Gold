import 'package:flutter/material.dart';
import '../theme/seek7_theme.dart';

class GoldBalance extends StatelessWidget {
  final double balance;
  const GoldBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Seek7Colors.navy, Seek7Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 14, offset: Offset(0, 6)),
        ],
      ),
      child: Row(children: [
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(color: Seek7Colors.gold, shape: BoxShape.circle),
          child: const Icon(Icons.account_balance_wallet_rounded, color: Seek7Colors.navy),
        ),
        const SizedBox(width: 14),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('SEEK7 WALLET', style: TextStyle(
            color: Seek7Colors.blueLight, fontSize: 10, letterSpacing: 1.8, fontWeight: FontWeight.w800,
          )),
          const SizedBox(height: 5),
          Text(
            '€' + balance.toStringAsFixed(2),
            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ]),
      ]),
    );
  }
}

class GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const GoldButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Seek7Colors.gold,
          foregroundColor: Seek7Colors.navy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: .4)),
      ),
    );
  }
}
