import 'package:flutter_test/flutter_test.dart';
import 'package:seek7_gold/core/mining/campaign_allocator.dart';
import 'package:seek7_gold/core/mining/mining_engine.dart';
import 'package:seek7_gold/core/mining/mining_models.dart';

void main() {
  const allocator = CampaignAllocator();
  const engine = MiningEngine();

  test('splits campaign budget between platform and Mining Pool', () {
    final result = allocator.allocate(
      budgetCents: 2700,
      miningPoolBps: 7000,
    );

    expect(result.totalCents, 2700);
    expect(result.miningPoolCents, 1890);
    expect(result.platformCents, 810);
    expect(result.fundedCompletions(20), 94);
  });

  test('only nearby eligible campaigns become Gold Spot candidates', () {
    final user = UserMiningProfile(
      userId: 'user-1',
      locationPermissionGranted: true,
      trustedDevice: true,
      accountVerified: true,
      activeRunSeconds: 1200,
      completedToday: 0,
      campaignCompletions: const {},
    );

    final campaigns = [
      const Campaign(
        id: 'near', advertiserId: 'merchant-1', budgetCents: 2700,
        miningPoolBps: 7000, rewardCents: 20,
        latitude: 40.4168, longitude: -3.7038, radiusKm: 2,
        maxCompletions: 94, maxImpressions: 40000,
        frequencyCapPerUser: 1, status: CampaignStatus.active,
      ),
      const Campaign(
        id: 'far', advertiserId: 'merchant-2', budgetCents: 2700,
        miningPoolBps: 7000, rewardCents: 20,
        latitude: 41.3874, longitude: 2.1686, radiusKm: 2,
        maxCompletions: 94, maxImpressions: 40000,
        frequencyCapPerUser: 1, status: CampaignStatus.active,
      ),
    ];

    final candidates = engine.discover(
      userLatitude: 40.4168,
      userLongitude: -3.7038,
      user: user,
      campaigns: campaigns,
    );

    expect(candidates.length, 1);
    expect(candidates.single.campaign.id, 'near');
  });

  test('completion only creates a funded reward after verification', () {
    final campaign = const Campaign(
      id: 'camp-1', advertiserId: 'merchant-1', budgetCents: 2700,
      miningPoolBps: 7000, rewardCents: 20,
      latitude: 40.4168, longitude: -3.7038, radiusKm: 2,
      maxCompletions: 94, maxImpressions: 40000,
      frequencyCapPerUser: 1, status: CampaignStatus.active,
    );

    final user = UserMiningProfile(
      userId: 'user-1',
      locationPermissionGranted: true,
      trustedDevice: true,
      accountVerified: true,
      activeRunSeconds: 1200,
      completedToday: 0,
      campaignCompletions: const {},
    );

    final reward = engine.completeGoldSpot(
      transactionId: 'tx-1',
      user: user,
      campaign: campaign,
      userLatitude: 40.4168,
      userLongitude: -3.7038,
      videoCompleted: true,
      dwellVerified: true,
      locationVerified: true,
    );

    expect(reward, isNotNull);
    expect(reward!.amountCents, 20);
    expect(reward.status, RewardStatus.earned);
  });
}
