class OpportunityReservation {
  const OpportunityReservation({
    required this.opportunityId,
    required this.expiresAt,
  });

  final String opportunityId;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class OpportunityReservationStore {
  OpportunityReservationStore._();

  static final OpportunityReservationStore instance =
      OpportunityReservationStore._();

  final Map<String, OpportunityReservation> _reservations = {};

  OpportunityReservation? reserve(String opportunityId, {int seconds = 15}) {
    _cleanup();

    final current = _reservations[opportunityId];
    if (current != null && !current.isExpired) return null;

    final reservation = OpportunityReservation(
      opportunityId: opportunityId,
      expiresAt: DateTime.now().add(Duration(seconds: seconds)),
    );

    _reservations[opportunityId] = reservation;
    return reservation;
  }

  bool isValid(String opportunityId) {
    _cleanup();
    final reservation = _reservations[opportunityId];
    return reservation != null && !reservation.isExpired;
  }

  void release(String opportunityId) {
    _reservations.remove(opportunityId);
  }

  void _cleanup() {
    _reservations.removeWhere((_, reservation) => reservation.isExpired);
  }
}
