class FraudService {
  const FraudService();

  bool isEligible({
    required bool locationVerified,
    required bool sessionActive,
    required bool deviceTrusted,
  }) {
    return locationVerified && sessionActive && deviceTrusted;
  }
}
