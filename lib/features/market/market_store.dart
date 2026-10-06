import 'dart:math' as math;

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

  final Set<String> _completedByCurrentUser = {};

  // Lightweight local prototype of the SEEK7 Interest Engine.
  // Production must calculate this server-side and use explicit consent.
  final Map<String, double> _interestScore = {
    'Ferramentas': 0.90,
    'Automóveis': 0.80,
    'Tecnologia': 0.75,
    'Restaurante': 0.65,
    'Mercado': 0.55,
    'Fitness': 0.45,
    'Moda': 0.18,
    'Beleza': 0.05,
  };

  double _distanceKm(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371.0;
    final dLat = (lat2 - lat1) * math.pi / 180;
    final dLon = (lon2 - lon1) * math.pi / 180;
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * math.pi / 180) *
            math.cos(lat2 * math.pi / 180) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    return earthRadius * 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  }

  double relevanceFor(GoldOpportunity opportunity, double userLat, double userLon) {
    final distance = _distanceKm(
      userLat,
      userLon,
      opportunity.latitude,
      opportunity.longitude,
    );

    final interest = _interestScore[opportunity.category] ?? 0.25;
    final distanceScore = (1 - (distance / 5)).clamp(0.0, 1.0);
    final availabilityScore =
        (opportunity.completionsRemaining / 100).clamp(0.0, 1.0);

    return (interest * 0.55) +
        (distanceScore * 0.30) +
        (availabilityScore * 0.15);
  }

  List<GoldOpportunity> nearbyOpportunities({
    required double userLat,
    required double userLon,
  }) {
    final available = _opportunities.where((opportunity) {
      final distance = _distanceKm(
        userLat,
        userLon,
        opportunity.latitude,
        opportunity.longitude,
      );
      return distance <= 5 && canComplete(opportunity);
    }).toList();

    available.sort((a, b) {
      return relevanceFor(b, userLat, userLon)
          .compareTo(relevanceFor(a, userLat, userLon));
    });

    return available;
  }

  void registerInteraction(String category) {
    final current = _interestScore[category] ?? 0.25;
    _interestScore[category] = (current + 0.08).clamp(0.0, 1.0).toDouble();
    notifyListeners();
  }

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

  bool canComplete(GoldOpportunity opportunity) {
    return opportunity.completionsRemaining > 0 &&
        !_completedByCurrentUser.contains(opportunity.id);
  }

  void consume(String id) {
    if (_completedByCurrentUser.contains(id)) return;

    final index = _opportunities.indexWhere((item) => item.id == id);
    if (index < 0) return;

    _completedByCurrentUser.add(id);

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
