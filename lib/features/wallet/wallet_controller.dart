import 'package:flutter/foundation.dart';

class Seek7Transaction {
  final String merchant;
  final double amount;
  final DateTime createdAt;

  const Seek7Transaction({
    required this.merchant,
    required this.amount,
    required this.createdAt,
  });
}

class Seek7WalletController extends ChangeNotifier {
  Seek7WalletController._();

  static final instance = Seek7WalletController._();

  double _balance = 0;
  final List<Seek7Transaction> _transactions = [];

  double get balance => _balance;
  List<Seek7Transaction> get transactions => List.unmodifiable(_transactions);

  void credit({
    required String merchant,
    required double amount,
  }) {
    _balance += amount;
    _transactions.insert(
      0,
      Seek7Transaction(
        merchant: merchant,
        amount: amount,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
