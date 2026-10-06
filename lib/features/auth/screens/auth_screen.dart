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
              Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: Seek7Colors.gold,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.location_on_rounded, color: Seek7Colors.navy),
                ),
                const SizedBox(width: 11),
                const Text('SEEK7', style: TextStyle(
                  color: Seek7Colors.navy, fontSize: 25, fontWeight: FontWeight.w900, letterSpacing: 2,
                )),
              ]),
              const SizedBox(height: 54),
              Text(
                login ? 'BEM-VINDO DE VOLTA' : 'ENTRE NO SEEK7',
                style: const TextStyle(
                  color: Seek7Colors.navy, fontSize: 30, fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                login ? 'Continue procurando oportunidades perto de você.' : 'Crie sua conta e comece a procurar dinheiro no mapa.',
                style: const TextStyle(color: Seek7Colors.muted, fontSize: 15, height: 1.4),
              ),
              const SizedBox(height: 30),
              if (!login) ...[
                _field('Nome completo', Icons.person_outline),
                const SizedBox(height: 13),
              ],
              _field('E-mail', Icons.email_outlined),
              const SizedBox(height: 13),
              _field('Senha', Icons.lock_outline, obscure: true),
              if (login)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
              const SizedBox(height: 14),
              GoldButton(
                label: login ? 'ENTRAR' : 'CRIAR CONTA',
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => setState(() => login = !login),
                  child: Text(login ? 'Criar uma nova conta' : 'Já tenho uma conta'),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Seek7Colors.blueLight,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Row(children: const [
                  Icon(Icons.storefront_outlined, color: Seek7Colors.navy),
                  SizedBox(width: 10),
                  Expanded(child: Text(
                    'Você tem um comércio? Publique uma oportunidade e pague pessoas pela atenção.',
                    style: TextStyle(color: Seek7Colors.navy, fontSize: 12, fontWeight: FontWeight.w600),
                  )),
                ]),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/merchant'),
                  child: const Text('ENTRAR COMO COMÉRCIO'),
                ),
              ),
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
