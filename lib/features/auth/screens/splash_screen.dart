import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1600), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('SEEK7', style: TextStyle(fontSize: 46, fontWeight: FontWeight.w900, letterSpacing: 8, color: Seek7Colors.goldBright)),
        SizedBox(height: 12),
        Text('DISCOVER THE CITY. EARN FROM IT.', style: TextStyle(fontSize: 10, letterSpacing: 2, color: Seek7Colors.muted)),
      ]),
    ),
  );
}
