class GoldOpportunity {
  final String id;
  final String merchant;
  final String title;
  final double reward;
  final double latitude;
  final double longitude;
  final String category;
  final int budgetCents;
  final int completionsRemaining;

  const GoldOpportunity({
    required this.id,
    required this.merchant,
    required this.title,
    required this.reward,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.budgetCents,
    required this.completionsRemaining,
  });

  GoldOpportunity copyWith({int? completionsRemaining}) {
    return GoldOpportunity(
      id: id,
      merchant: merchant,
      title: title,
      reward: reward,
      latitude: latitude,
      longitude: longitude,
      category: category,
      budgetCents: budgetCents,
      completionsRemaining: completionsRemaining ?? this.completionsRemaining,
    );
  }
}
