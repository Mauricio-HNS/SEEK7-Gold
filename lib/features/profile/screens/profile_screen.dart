import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Seek7Colors.navy, Seek7Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(children: [
              const CircleAvatar(
                radius: 31,
                backgroundColor: Seek7Colors.gold,
                child: Icon(Icons.person, color: Seek7Colors.navy, size: 31),
              ),
              const SizedBox(width: 15),
              const Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SEEK7 User', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w900)),
                  SizedBox(height: 4),
                  Text('user@seek7.app', style: TextStyle(color: Seek7Colors.blueLight)),
                ],
              )),
              const Icon(Icons.verified_rounded, color: Seek7Colors.gold),
            ]),
          ),
          const SizedBox(height: 26),
          _section('CONTA'),
          _item(Icons.verified_user_outlined, 'Verificação', 'Conta verificada'),
          _item(Icons.account_balance_wallet_outlined, 'Saques', 'Configure seus dados de pagamento'),
          _item(Icons.lock_outline, 'Segurança', 'Senha e segurança do dispositivo'),
          const SizedBox(height: 24),
          _section('SEEK7'),
          _item(Icons.notifications_none_rounded, 'Notificações', 'Alertas e oportunidades'),
          _item(Icons.help_outline_rounded, 'Ajuda', 'Perguntas e suporte'),
          const SizedBox(height: 25),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Seek7Colors.navy,
              side: const BorderSide(color: Seek7Colors.blueLight),
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('SAIR', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Text(title, style: const TextStyle(
      letterSpacing: 1.8, fontSize: 11, color: Seek7Colors.muted, fontWeight: FontWeight.w800,
    )),
  );

  Widget _item(IconData icon, String title, String subtitle) => Container(
    margin: const EdgeInsets.only(bottom: 9),
    decoration: BoxDecoration(
      color: Seek7Colors.surface,
      borderRadius: BorderRadius.circular(17),
      border: Border.all(color: Seek7Colors.blueLight),
    ),
    child: ListTile(
      leading: Container(
        width: 42, height: 42,
        decoration: const BoxDecoration(color: Seek7Colors.blueLight, shape: BoxShape.circle),
        child: Icon(icon, color: Seek7Colors.navy),
      ),
      title: Text(title, style: const TextStyle(color: Seek7Colors.navy, fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle, style: const TextStyle(color: Seek7Colors.muted, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded, color: Seek7Colors.muted),
      onTap: () {},
    ),
  );
}
