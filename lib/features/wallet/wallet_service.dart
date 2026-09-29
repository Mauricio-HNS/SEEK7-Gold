import '../../core/mining/mining_models.dart';

class WalletService {
  final List<RewardTransaction> _transactions = [];

  List<RewardTransaction> get transactions =>
      List.unmodifiable(_transactions);

  void addTransaction(RewardTransaction transaction) {
    _transactions.add(transaction);
  }
}
