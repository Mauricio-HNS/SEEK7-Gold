import '../../core/mining/mining_models.dart';

class MiningService {
  Future<List<MiningCandidate>> discover({
    required List<MiningCandidate> candidates,
  }) async {
    // Repository/API integration will provide candidates in production.
    return List<MiningCandidate>.from(candidates);
  }
}
