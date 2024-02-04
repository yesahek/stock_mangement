// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'transaction.dart';

class Stock with ChangeNotifier {
  final String id;
  final int code;
  final String name;
  final DateTime dateRegistored;
  final double costPrice;
  late final double sellingPrice;
  final String packageType;
  final List<Transaction> transactions;

  Stock({
    required this.id,
    required this.code,
    required this.name,
    required this.dateRegistored,
    required this.costPrice,
    required this.sellingPrice,
    required this.packageType,
    required this.transactions,
  }) {
    // Attach a listener to the transactions list
    _listenToTransactions();
  }

  //total received
  int get totalReceived => calculateTotalReceived(transactions);

  //total sailed
  int get totalSailed => calculateTotalSailed(transactions);

  //Balance
  int get balance => calculateBalance(transactions);

  //profit
  double get profit => calculateProfit(transactions, costPrice);

  //total sailed price
  double get totalSailedPrice => calculateTotalSailedPrice(transactions);

//total cost price
  double get totalCostPrice => calculateTotalCostPrice(transactions);

  // Attach a listener to the transactions list
  void _listenToTransactions() {
    for (var transaction in transactions) {
      transaction.addListener(_onTransactionChanged);
    }
  }

  // Callback when a transaction changes
  void _onTransactionChanged() {
    notifyListeners();
  }

  // Cleanup: remove listeners when the Stock object is disposed
  @override
  void dispose() {
    for (var transaction in transactions) {
      transaction.removeListener(_onTransactionChanged);
    }
    super.dispose();
  }

  static int calculateTotalReceived(List<Transaction> transactions) {
    int totalReceived = 0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.buy) {
        totalReceived += transaction.quantity;
      }
    }
    return totalReceived;
  }

  //total sailed
  static int calculateTotalSailed(List<Transaction> transactions) {
    int totalReceived = 0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.sell) {
        totalReceived += transaction.quantity;
      }
    }

    return totalReceived;
  }

  //total sailed price

  static double calculateTotalSailedPrice(List<Transaction> transactions) {
    double totalSailedPrice = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.sell) {
        totalSailedPrice += transaction.total;
      }
    }
    return totalSailedPrice;
  }

  //total cost price

  static double calculateTotalCostPrice(List<Transaction> transactions) {
    double totalCostPrice = 0.0;
    for (var transaction in transactions) {
      if (transaction.type == TransactionType.buy) {
        totalCostPrice += transaction.total;
      }
    }
    return totalCostPrice;
  }

  //profit
  double calculateProfit(List<Transaction> transactions, double costPrice) {
    double totalProfit = 0.0;
    double balancePrice = calculateBalance(transactions) * costPrice;
    double totalSailedPrice = calculateTotalSailedPrice(transactions);
    double totalCostPrice =
        calculateTotalCostPrice(transactions) - balancePrice;
    // Balance * cost price and substaract from totoal profit
    totalProfit = totalSailedPrice - totalCostPrice;
    return totalProfit;
  }

  //Balance
  static int calculateBalance(List<Transaction> transactions) {
    int bal = 0;
    bal = calculateTotalReceived(transactions) -
        calculateTotalSailed(transactions);
    return bal;
  }
}
