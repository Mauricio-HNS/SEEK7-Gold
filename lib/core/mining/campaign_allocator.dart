import 'mining_models.dart';

/// Converts an advertiser budget into platform revenue and a funded Mining Pool.
/// bps = basis points, so 7000 = 70%.
class CampaignAllocator {
  const CampaignAllocator();

  CampaignAllocation allocate({
    required int budgetCents,
    required int miningPoolBps,
  }) {
    if (budgetCents < 0) {
      throw ArgumentError.value(budgetCents, 'budgetCents');
    }
    if (miningPoolBps < 0 || miningPoolBps > 10000) {
      throw ArgumentError.value(miningPoolBps, 'miningPoolBps');
    }

    final miningPoolCents = (budgetCents * miningPoolBps) ~/ 10000;
    return CampaignAllocation(
      totalCents: budgetCents,
      miningPoolCents: miningPoolCents,
      platformCents: budgetCents - miningPoolCents,
    );
  }
}

class CampaignAllocation {
  final int totalCents;
  final int miningPoolCents;
  final int platformCents;

  const CampaignAllocation({
    required this.totalCents,
    required this.miningPoolCents,
    required this.platformCents,
  });

  int fundedCompletions(int rewardCents) {
    if (rewardCents <= 0) return 0;
    return miningPoolCents ~/ rewardCents;
  }
}
