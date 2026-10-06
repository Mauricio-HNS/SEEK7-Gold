import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded, color: Seek7Colors.navy),
              ),
              const SizedBox(height: 35),
              Container(
                width: 70, height: 70,
                decoration: BoxDecoration(
                  color: Seek7Colors.blueLight,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(Icons.lock_reset_rounded, color: Seek7Colors.navy, size: 36),
              ),
              const SizedBox(height: 25),
              const Text('RECUPERAR ACESSO', style: TextStyle(
                color: Seek7Colors.navy, fontSize: 29, fontWeight: FontWeight.w900,
              )),
              const SizedBox(height: 10),
              const Text(
                'Digite seu e-mail e enviaremos um link para redefinir sua senha.',
                style: TextStyle(color: Seek7Colors.muted, fontSize: 15, height: 1.45),
              ),
              const SizedBox(height: 30),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined, color: Seek7Colors.navy),
                  filled: true,
                  fillColor: Seek7Colors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    borderSide: BorderSide(color: Seek7Colors.blueLight),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GoldButton(
                label: 'ENVIAR LINK',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
