class RewardService {
  const RewardService();

  double calculateReward({
    required double advertisedReward,
    required bool completed,
    required bool verified,
  }) {
    if (!completed || !verified) return 0;
    return advertisedReward;
  }
}
