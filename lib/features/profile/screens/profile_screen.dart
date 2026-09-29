import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Seek7Colors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Seek7Colors.gold.withOpacity(.14)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Seek7Colors.gold,
                  child: Icon(Icons.person, color: Colors.black, size: 30),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('SEEK7 User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      SizedBox(height: 4),
                      Text('user@seek7.app', style: TextStyle(color: Seek7Colors.muted)),
                    ],
                  ),
                ),
                Icon(Icons.verified, color: Seek7Colors.success),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _section('ACCOUNT'),
          _item(Icons.verified_user_outlined, 'Verification', 'Account verified'),
          _item(Icons.account_balance_outlined, 'Withdrawal profile', 'Set up your payment details'),
          _item(Icons.lock_outline, 'Security', 'Password and device security'),
          const SizedBox(height: 22),
          _section('APP'),
          _item(Icons.notifications_none, 'Notifications', 'Manage SEEK7 alerts'),
          _item(Icons.help_outline, 'Help & support', 'Get help with SEEK7'),
          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => false),
            icon: const Icon(Icons.logout),
            label: const Text('LOG OUT'),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(title, style: const TextStyle(letterSpacing: 2, fontSize: 11, color: Seek7Colors.muted)),
  );

  Widget _item(IconData icon, String title, String subtitle) => Card(
    color: Seek7Colors.surface,
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      leading: Icon(icon, color: Seek7Colors.gold),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: const TextStyle(color: Seek7Colors.muted)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  );
}
