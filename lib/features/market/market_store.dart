import 'package:flutter/foundation.dart';
import 'models/gold_opportunity.dart';

class Seek7MarketStore extends ChangeNotifier {
  Seek7MarketStore._();

  static final Seek7MarketStore instance = Seek7MarketStore._();

  final List<GoldOpportunity> _opportunities = [
    const GoldOpportunity(
      id: 'pizzeria-bella',
      merchant: 'Pizzeria Bella Napoli',
      title: 'Assista ao anúncio por 5 segundos',
      reward: 0.50,
      latitude: 40.4176,
      longitude: -3.7031,
      category: 'Restaurante',
      budgetCents: 10000,
      completionsRemaining: 200,
    ),
    const GoldOpportunity(
      id: 'urban-market',
      merchant: 'Urban Market',
      title: 'Conheça a oferta de hoje',
      reward: 0.30,
      latitude: 40.4157,
      longitude: -3.7050,
      category: 'Mercado',
      budgetCents: 7500,
      completionsRemaining: 250,
    ),
    const GoldOpportunity(
      id: 'move-studio',
      merchant: 'Move Studio',
      title: 'Veja a experiência patrocinada',
      reward: 0.20,
      latitude: 40.4182,
      longitude: -3.7009,
      category: 'Fitness',
      budgetCents: 5000,
      completionsRemaining: 250,
    ),
  ];

  List<GoldOpportunity> get opportunities => List.unmodifiable(_opportunities);

  void publish({
    required String merchant,
    required String title,
    required double reward,
    required int budgetCents,
    required String category,
  }) {
    final id = DateTime.now().millisecondsSinceEpoch.toString() + '-' + merchant;
    final count = (budgetCents / (reward * 100)).floor();

    _opportunities.add(
      GoldOpportunity(
        id: id,
        merchant: merchant,
        title: title,
        reward: reward,
        latitude: 40.4168,
        longitude: -3.7038,
        category: category,
        budgetCents: budgetCents,
        completionsRemaining: count,
      ),
    );
    notifyListeners();
  }

  bool canComplete(GoldOpportunity opportunity) =>
      opportunity.completionsRemaining > 0;

  void consume(String id) {
    final index = _opportunities.indexWhere((item) => item.id == id);
    if (index < 0) return;

    final item = _opportunities[index];
    if (item.completionsRemaining <= 1) {
      _opportunities.removeAt(index);
    } else {
      _opportunities[index] =
          item.copyWith(completionsRemaining: item.completionsRemaining - 1);
    }
    notifyListeners();
  }
}
