class FraudDetectionService {
  Future<bool> validateSession({
    required bool trustedDevice,
    required bool locationVerified,
  }) async {
    return trustedDevice && locationVerified;
  }
}
