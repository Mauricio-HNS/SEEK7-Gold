import 'package:flutter/material.dart';
import '../theme/seek7_theme.dart';
import '../widgets/seek7_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('RESET PASSWORD', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          const Text('Enter your email and we will send you a secure reset link.',
              style: TextStyle(color: Seek7Colors.muted, height: 1.5)),
          const SizedBox(height: 30),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              filled: true,
              fillColor: Seek7Colors.surface,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 22),
          GoldButton(label: 'SEND RESET LINK', onPressed: () => Navigator.pop(context)),
        ]),
      ),
    );
  }
}
