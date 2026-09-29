import 'dart:math' as math;

import 'mining_models.dart';

/// Core SEEK7 allocation engine.
///
/// Money is represented in cents to avoid floating-point accounting errors.
/// The engine only creates a reward when a real campaign has remaining mining
/// budget and the user passes eligibility/frequency checks.
class MiningEngine {
  const MiningEngine();

  List<MiningCandidate> discover({
    required double userLatitude,
    required double userLongitude,
    required UserMiningProfile user,
    required List<Campaign> campaigns,
  }) {
    if (!user.locationPermissionGranted ||
        !user.trustedDevice ||
        !user.accountVerified ||
        user.activeRunSeconds <= 0) {
      return const [];
    }

    final candidates = <MiningCandidate>[];

    for (final campaign in campaigns) {
      if (campaign.status != CampaignStatus.active ||
          campaign.budgetCents <= 0 ||
          campaign.rewardCents <= 0 ||
          campaign.maxCompletions <= 0) {
        continue;
      }

      final distance = _distanceKm(
        userLatitude,
        userLongitude,
        campaign.latitude,
        campaign.longitude,
      );

      if (distance > campaign.radiusKm) continue;

      final usedByUser = user.campaignCompletions[campaign.id] ?? 0;
      if (usedByUser >= campaign.frequencyCapPerUser) continue;

      final proximityScore = 1 - (distance / campaign.radiusKm).clamp(0.0, 1.0);
      final frequencyScore =
          1 - (usedByUser / campaign.frequencyCapPerUser).clamp(0.0, 1.0);
      final budgetScore = math.min(
        1.0,
        campaign.miningPoolCents /
            math.max(campaign.rewardCents * 10, 1),
      );

      // Proximity is deliberately the strongest factor: nearby opportunities
      // should dominate the map while budget/frequency prevent one campaign
      // from monopolising the user experience.
      final score =
          (proximityScore * 0.55) +
          (budgetScore * 0.25) +
          (frequencyScore * 0.20);

      candidates.add(MiningCandidate(
        campaign: campaign,
        distanceKm: distance,
        score: score,
      ));
    }

    candidates.sort((a, b) => b.score.compareTo(a.score));
    return candidates;
  }

  RewardTransaction? completeGoldSpot({
    required String transactionId,
    required UserMiningProfile user,
    required Campaign campaign,
    required double userLatitude,
    required double userLongitude,
    required bool videoCompleted,
    required bool dwellVerified,
    required bool locationVerified,
    DateTime? now,
  }) {
    if (!videoCompleted || !dwellVerified || !locationVerified) return null;
    if (!user.locationPermissionGranted || !user.trustedDevice || !user.accountVerified) {
      return null;
    }
    if (user.activeRunSeconds <= 0) return null;
    if (campaign.status != CampaignStatus.active) return null;

    final distance = _distanceKm(
      userLatitude,
      userLongitude,
      campaign.latitude,
      campaign.longitude,
    );
    if (distance > campaign.radiusKm) return null;

    final usedByUser = user.campaignCompletions[campaign.id] ?? 0;
    if (usedByUser >= campaign.frequencyCapPerUser) return null;

    final pool = campaign.miningPoolCents;
    if (pool < campaign.rewardCents) return null;

    return RewardTransaction(
      id: transactionId,
      userId: user.userId,
      campaignId: campaign.id,
      amountCents: campaign.rewardCents,
      status: RewardStatus.earned,
      createdAt: now ?? DateTime.now().toUtc(),
    );
  }

  int maxFundedCompletions(Campaign campaign) {
    if (campaign.rewardCents <= 0) return 0;
    return math.min(
      campaign.maxCompletions,
      campaign.miningPoolCents ~/ campaign.rewardCents,
    );
  }

  double _distanceKm(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadiusKm = 6371.0;
    final dLat = _radians(lat2 - lat1);
    final dLon = _radians(lon2 - lon1);
    final a = math.pow(math.sin(dLat / 2), 2) +
        math.cos(_radians(lat1)) *
            math.cos(_radians(lat2)) *
            math.pow(math.sin(dLon / 2), 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _radians(double degrees) => degrees * math.pi / 180.0;
}
