enum CampaignStatus { draft, active, paused, exhausted, completed }

enum RewardStatus { pending, earned, locked, withdrawable, reversed }

class Money {
  const Money._();

  static int eurToCents(double value) => (value * 100).round();
  static double centsToValue(int cents) => cents / 100.0;
}

class Campaign {
  final String id;
  final String advertiserId;
  final int budgetCents;
  final int miningPoolBps;
  final int rewardCents;
  final double latitude;
  final double longitude;
  final double radiusKm;
  final int maxCompletions;
  final int maxImpressions;
  final int frequencyCapPerUser;
  final CampaignStatus status;

  const Campaign({
    required this.id,
    required this.advertiserId,
    required this.budgetCents,
    required this.miningPoolBps,
    required this.rewardCents,
    required this.latitude,
    required this.longitude,
    required this.radiusKm,
    required this.maxCompletions,
    required this.maxImpressions,
    required this.frequencyCapPerUser,
    required this.status,
  });

  int get miningPoolCents => (budgetCents * miningPoolBps) ~/ 10000;
  int get platformCents => budgetCents - miningPoolCents;
}

class UserMiningProfile {
  final String userId;
  final bool locationPermissionGranted;
  final bool trustedDevice;
  final bool accountVerified;
  final int activeRunSeconds;
  final int completedToday;
  final Map<String, int> campaignCompletions;

  const UserMiningProfile({
    required this.userId,
    required this.locationPermissionGranted,
    required this.trustedDevice,
    required this.accountVerified,
    required this.activeRunSeconds,
    required this.completedToday,
    required this.campaignCompletions,
  });
}

class MiningCandidate {
  final Campaign campaign;
  final double distanceKm;
  final double score;

  const MiningCandidate({
    required this.campaign,
    required this.distanceKm,
    required this.score,
  });
}

class RewardTransaction {
  final String id;
  final String userId;
  final String campaignId;
  final int amountCents;
  final RewardStatus status;
  final DateTime createdAt;

  const RewardTransaction({
    required this.id,
    required this.userId,
    required this.campaignId,
    required this.amountCents,
    required this.status,
    required this.createdAt,
  });
}
