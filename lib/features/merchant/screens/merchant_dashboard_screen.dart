import 'package:flutter/material.dart';
import '../../../core/theme/seek7_theme.dart';
import '../../../shared/widgets/seek7_widgets.dart';
import '../../market/market_store.dart';

class MerchantDashboardScreen extends StatefulWidget {
  const MerchantDashboardScreen({super.key});

  @override
  State<MerchantDashboardScreen> createState() => _MerchantDashboardScreenState();
}

class _MerchantDashboardScreenState extends State<MerchantDashboardScreen> {
  final merchantController = TextEditingController();
  final titleController = TextEditingController();
  final rewardController = TextEditingController(text: '0.50');
  final budgetController = TextEditingController(text: '100');

  String category = 'Restaurante';

  final market = Seek7MarketStore.instance;

  @override
  void dispose() {
    merchantController.dispose();
    titleController.dispose();
    rewardController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  void publish() {
    final merchant = merchantController.text.trim();
    final title = titleController.text.trim();
    final reward = double.tryParse(rewardController.text.replaceAll(',', '.'));
    final budget = double.tryParse(budgetController.text.replaceAll(',', '.'));

    if (merchant.isEmpty || title.isEmpty || reward == null || budget == null ||
        reward <= 0 || budget <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha os dados da campanha.')),
      );
      return;
    }

    market.publish(
      merchant: merchant,
      title: title,
      reward: reward,
      budgetCents: (budget * 100).round(),
      category: category,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Campanha publicada no mapa.')),
    );

    merchantController.clear();
    titleController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEEK7 PARA NEGÓCIOS'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'PUBLIQUE E PAGUE POR ATENÇÃO',
            style: TextStyle(
              color: Seek7Colors.navy,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Coloque seu comércio no mapa. Você define quanto cada pessoa recebe.',
            style: TextStyle(color: Seek7Colors.muted, fontSize: 15),
          ),
          const SizedBox(height: 22),
          _field('Nome do comércio', merchantController, Icons.storefront),
          const SizedBox(height: 12),
          _field('O que você quer anunciar?', titleController, Icons.campaign),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: category,
            decoration: _decoration('Categoria', Icons.category_outlined),
            items: const [
              'Restaurante',
              'Mercado',
              'Loja',
              'Serviço',
              'Fitness',
              'Outro',
            ].map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
            onChanged: (value) => setState(() => category = value ?? category),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _field('Recompensa por pessoa (€)', rewardController, Icons.euro)),
              const SizedBox(width: 10),
              Expanded(child: _field('Orçamento total (€)', budgetController, Icons.account_balance_wallet)),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Seek7Colors.blueLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Seek7Colors.navy),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Localização do protótipo: Madrid Centro. O próximo passo será escolher o ponto diretamente no mapa.',
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
            label: 'PUBLICAR NO MAPA',
            onPressed: publish,
          ),
          const SizedBox(height: 28),
          const Text(
            'OPORTUNIDADES ATIVAS',
            style: TextStyle(
              color: Seek7Colors.muted,
              letterSpacing: 1.8,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedBuilder(
            animation: market,
            builder: (context, _) => Column(
              children: market.opportunities.map(
                (item) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.location_on,
                    color: Seek7Colors.goldDark,
                  ),
                  title: Text(
                    item.merchant,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    '€' + item.reward.toStringAsFixed(2) + ' por conclusão • ' +
                    item.completionsRemaining.toString() + ' restantes',
                    style: const TextStyle(color: Seek7Colors.muted),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(String label, IconData icon) {
    return InputDecoration(
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
    );
  }

  Widget _field(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: _decoration(label, icon),
      keyboardType: label.contains('€')
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
    );
  }
}
