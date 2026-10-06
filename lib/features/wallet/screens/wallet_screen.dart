import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';
import '../wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = Seek7WalletController.instance;

    return AnimatedBuilder(
      animation: wallet,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Carteira')),
          body: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              GoldBalance(balance: wallet.balance),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Seek7Colors.blueLight,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Seek7Colors.navy),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'O saldo abaixo é do protótipo. Saques reais serão ligados a um provedor de pagamentos na próxima etapa.',
                        style: TextStyle(
                          color: Seek7Colors.navy,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              GoldButton(
                label: 'SOLICITAR SAQUE',
                onPressed: wallet.balance <= 0
                    ? () {}
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saques reais ainda não estão conectados.'),
                          ),
                        );
                      },
              ),
              const SizedBox(height: 28),
              const Text(
                'ATIVIDADES RECENTES',
                style: TextStyle(
                  letterSpacing: 1.8,
                  fontSize: 11,
                  color: Seek7Colors.muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              if (wallet.transactions.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Center(
                    child: Text(
                      'Ainda não há recompensas. Procure um pin dourado no mapa.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Seek7Colors.muted),
                    ),
                  ),
                )
              else
                ...wallet.transactions.map(
                  (transaction) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(
                      backgroundColor: Seek7Colors.blueLight,
                      child: Icon(
                        Icons.location_on,
                        color: Seek7Colors.navy,
                      ),
                    ),
                    title: Text(
                      transaction.merchant,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text(
                      'Anúncio concluído',
                      style: TextStyle(color: Seek7Colors.muted),
                    ),
                    trailing: Text(
                      '+€' + transaction.amount.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Seek7Colors.success,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
