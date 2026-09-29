import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(login ? 'WELCOME BACK' : 'JOIN SEEK7',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Text(login ? 'Continue your search.' : 'Create your account and start earning.',
              style: const TextStyle(color: Seek7Colors.muted)),
          const SizedBox(height: 34),
          if (!login) TextField(decoration: _decoration('Full name', Icons.person_outline)),
          if (!login) const SizedBox(height: 14),
          TextField(decoration: _decoration('Email', Icons.email_outlined)),
          const SizedBox(height: 14),
          TextField(obscureText: true, decoration: _decoration('Password', Icons.lock_outline)),
          if (login)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                child: const Text('Forgot password?'),
              ),
            ),
          const SizedBox(height: 18),
          GoldButton(label: login ? 'LOGIN' : 'CREATE ACCOUNT', onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          const SizedBox(height: 18),
          Center(child: TextButton(
            onPressed: () => setState(() => login = !login),
            child: Text(login ? 'Create a new account' : 'I already have an account'),
          )),
          const SizedBox(height: 8),
          Center(child: TextButton(
            onPressed: () => Navigator.pushNamed(context, '/merchant'),
            child: const Text('I am a business'),
          )),
        ]),
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Seek7Colors.surface,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
  );
}
