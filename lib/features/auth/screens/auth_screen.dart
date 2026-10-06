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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Seek7Colors.gold,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Seek7Colors.navy,
                    ),
                  ),
                  const SizedBox(width: 11),
                  const Text(
                    'SEEK7',
                    style: TextStyle(
                      color: Seek7Colors.navy,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 54),
              Text(
                login ? 'BEM-VINDO AO SEEK7' : 'BEM-VINDO AO SEEK7',
                style: const TextStyle(
                  color: Seek7Colors.navy,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                login
                    ? 'Entre na sua conta e continue de onde parou.'
                    : 'Uma conta. Várias possibilidades. Encontre, ganhe ou divulgue.',
                style: const TextStyle(
                  color: Seek7Colors.muted,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),
              if (login) ...[
                _field('E-mail', Icons.email_outlined),
                const SizedBox(height: 13),
                _field('Senha', Icons.lock_outline, obscure: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/forgot-password'),
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                const SizedBox(height: 14),
                GoldButton(
                  label: 'ENTRAR',
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/home'),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => login = false),
                    child: const Text('Criar minha conta'),
                  ),
                ),
              ] else ...[
                GoldButton(
                  label: 'CRIAR MINHA CONTA',
                  onPressed: () => setState(() => login = true),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () => setState(() => login = true),
                    child: const Text('Já tenho uma conta  →  Entrar'),
                  ),
                ),
                const SizedBox(height: 36),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Seek7Colors.blueLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.bolt_rounded,
                        color: Seek7Colors.gold,
                        size: 28,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'UMA CONTA. MUITAS POSSIBILIDADES.',
                        style: TextStyle(
                          color: Seek7Colors.navy,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .6,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        'Encontre oportunidades, ganhe recompensas ou divulgue o que quiser. Você escolhe como usar o SEEK7.',
                        style: TextStyle(
                          color: Seek7Colors.navy,
                          fontSize: 13,
                          height: 1.45,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(String label, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Seek7Colors.navy),
        filled: true,
        fillColor: Seek7Colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Seek7Colors.blueLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Seek7Colors.blueLight),
        ),
      ),
    );
  }
}
