import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/stock.dart';

class StocksProvider with ChangeNotifier {
  final List<Stock> _items = [
    Stock(
      id: 's1',
      code: 001,
      name: "Micro",
      datePurchased: DateTime.now(),
      dateRegistored: DateTime.now(),
      costPrice: 750.00,
      sellingPrice: 850.00,
      packageType: "CTN",
      transactions: [
        Transaction(
          id: "T002",
          type: TransactionType.buy,
          quantity: 15,
          invoiceNumber: 00002,
          price: 500,
          dateTime: DateTime.now(),
        ),
      ],
    ),
    Stock(
      id: 's2',
      code: 002,
      name: "Link",
      datePurchased: DateTime.now(),
      dateRegistored: DateTime.now(),
      costPrice: 750.00,
      sellingPrice: 850.00,
      packageType: "CTN",
      transactions: [
        Transaction(
          id: "T001",
          type: TransactionType.sell,
          quantity: 10,
          invoiceNumber: 00001,
          price: 300,
          dateTime: DateTime.now(),
        ),
        Transaction(
          id: "T002",
          type: TransactionType.sell,
          quantity: 15,
          invoiceNumber: 00002,
          price: 150,
          dateTime: DateTime.now(),
        ),
        Transaction(
          id: "T003",
          type: TransactionType.buy,
          quantity: 35,
          invoiceNumber: 01548,
          price: 450,
          dateTime: DateTime.now(),
        ),
      ],
    ),
  ];
  List<Stock> get items {
    return [..._items];
  }

  //List<Stock> get getItem => _items;

  void addStock(newStock) {
    _items.add(newStock);
    notifyListeners();
  }

//Finding single stock
  Stock singleStock(String stockid) {
    Stock foundStock;
    foundStock = _items.firstWhere((e) => e.id == stockid);
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    return foundStock;
  }

  Future<void> editTransaction(
      String stockId, Transaction editTransaction) async {
    final stockIndex = _items.indexWhere((st) => st.id == stockId);
    final trnaIndex = _items[stockIndex]
        .transactions
        .indexWhere((tr) => tr.id == editTransaction.id);
    _items[stockIndex].transactions[trnaIndex] = editTransaction;
    notifyListeners();
  }
}
