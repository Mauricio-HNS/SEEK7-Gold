import 'dart:math' as math;

import '../market/models/gold_opportunity.dart';
import 'map_control_config.dart';

class MapOpportunityDecision {
  const MapOpportunityDecision({
    required this.opportunity,
    required this.distanceKm,
    required this.score,
    required this.radiusKm,
  });

  final GoldOpportunity opportunity;
  final double distanceKm;
  final double score;
  final double radiusKm;
}

class MapControlEngine {
  MapControlEngine._();

  static final MapControlEngine instance = MapControlEngine._();

  MapControlConfig config = const MapControlConfig();

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

  List<MapOpportunityDecision> decide({
    required Iterable<GoldOpportunity> opportunities,
    required double userLat,
    required double userLon,
    required bool Function(GoldOpportunity) isEligible,
  }) {
    final eligible = opportunities.where(isEligible).toList();
    final radius = _effectiveRadius(eligible, userLat, userLon);

    final decisions = eligible
        .map((opportunity) {
          final distance = _distanceKm(
            userLat,
            userLon,
            opportunity.latitude,
            opportunity.longitude,
          );

          if (distance > radius) return null;

          return MapOpportunityDecision(
            opportunity: opportunity,
            distanceKm: distance,
            radiusKm: radius,
            score: _score(opportunity, distance),
          );
        })
        .whereType<MapOpportunityDecision>()
        .toList();

    decisions.sort((a, b) => b.score.compareTo(a.score));
    return decisions;
  }

  void registerInteraction(String category) {
    final current = _interestScore[category] ?? 0.25;
    _interestScore[category] = (current + 0.08).clamp(0.0, 1.0).toDouble();
  }

  double interestFor(String category) => _interestScore[category] ?? 0.25;

  double _score(GoldOpportunity opportunity, double distanceKm) {
    final interest = interestFor(opportunity.category);
    final distanceScore =
        (1 - (distanceKm / config.maxRadiusKm)).clamp(0.0, 1.0);
    final availabilityScore =
        (opportunity.completionsRemaining / 100).clamp(0.0, 1.0);

    // Intent and competition are placeholders until real behavioral
    // signals and reservation state are connected to the backend.
    const intentScore = 0.5;
    final competitionScore =
        (1 - (opportunity.completionsRemaining / 250)).clamp(0.0, 1.0);

    return (interest * config.interestWeight) +
        (distanceScore * config.distanceWeight) +
        (availabilityScore * config.availabilityWeight) +
        (intentScore * config.intentWeight) +
        (competitionScore * config.competitionWeight);
  }

  double _effectiveRadius(
    List<GoldOpportunity> opportunities,
    double userLat,
    double userLon,
  ) {
    if (opportunities.isEmpty) return config.emptyMarketRadiusKm;

    var nearest = double.infinity;
    for (final opportunity in opportunities) {
      final distance = _distanceKm(
        userLat,
        userLon,
        opportunity.latitude,
        opportunity.longitude,
      );
      if (distance < nearest) nearest = distance;
    }

    if (nearest <= config.baseRadiusKm) return config.baseRadiusKm;

    return config.maxRadiusKm;
  }

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
}
