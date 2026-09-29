import 'mining_models.dart';

enum OpportunityStatus { available, claimed, watching, completed, expired, cancelled }

/// One campaign budget is split into many independently claimable opportunities.
/// A user can consume an opportunity only once; reopening the same campaign
/// does not resurrect a completed reward.
class MiningOpportunity {
  final String id;
  final String campaignId;
  final String userId;
  final int rewardCents;
  final OpportunityStatus status;
  final DateTime expiresAt;

  const MiningOpportunity({
    required this.id,
    required this.campaignId,
    required this.userId,
    required this.rewardCents,
    required this.status,
    required this.expiresAt,
  });
}

class CampaignLifecycle {
  const CampaignLifecycle();

  /// Reserves one reward slot before the experience starts.
  /// The server must perform this atomically so two users cannot spend
  /// the same last funded slot.
  MiningOpportunity? claim({
    required String opportunityId,
    required String campaignId,
    required String userId,
    required Campaign campaign,
    required bool userIsEligible,
    required DateTime now,
  }) {
    if (!userIsEligible) return null;
    if (campaign.status != CampaignStatus.active) return null;
    if (campaign.miningPoolCents < campaign.rewardCents) return null;

    return MiningOpportunity(
      id: opportunityId,
      campaignId: campaignId,
      userId: userId,
      rewardCents: campaign.rewardCents,
      status: OpportunityStatus.claimed,
      expiresAt: now.add(const Duration(minutes: 2)),
    );
  }

  OpportunityStatus finish({
    required MiningOpportunity opportunity,
    required bool videoCompleted,
    required bool dwellVerified,
    required bool locationVerified,
    required DateTime now,
  }) {
    if (opportunity.status != OpportunityStatus.claimed &&
        opportunity.status != OpportunityStatus.watching) {
      return opportunity.status;
    }

    if (now.isAfter(opportunity.expiresAt)) {
      return OpportunityStatus.expired;
    }

    if (!videoCompleted || !dwellVerified || !locationVerified) {
      return OpportunityStatus.cancelled;
    }

    return OpportunityStatus.completed;
  }

  bool canReopen(MiningOpportunity opportunity) =>
      opportunity.status == OpportunityStatus.available;
}
