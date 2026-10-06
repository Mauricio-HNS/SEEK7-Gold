class MapControlConfig {
  const MapControlConfig({
    this.baseRadiusKm = 2.0,
    this.maxRadiusKm = 5.0,
    this.emptyMarketRadiusKm = 10.0,
    this.interestWeight = 0.40,
    this.distanceWeight = 0.25,
    this.availabilityWeight = 0.15,
    this.intentWeight = 0.10,
    this.competitionWeight = 0.10,
    this.reservationSeconds = 15,
    this.minimumEngagementSeconds = 5,
  });

  final double baseRadiusKm;
  final double maxRadiusKm;
  final double emptyMarketRadiusKm;

  final double interestWeight;
  final double distanceWeight;
  final double availabilityWeight;
  final double intentWeight;
  final double competitionWeight;

  final int reservationSeconds;
  final int minimumEngagementSeconds;
}
