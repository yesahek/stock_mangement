import 'package:flutter/material.dart';
import '../models/item.dart';
import '../models/transaction.dart';
import '../models/stock.dart';
import '../models/items.dart';

class StocksProvider with ChangeNotifier {
  final List<Stock> _items = [
    Stock(
      id: 's1',
      code: 001,
      name: "Micro",
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
          price: 750,
          dateTimeTransaction: DateTime.now(),
          dateTimeSaved: DateTime.now(),
        ),
      ],
    ),
    Stock(
      id: 's2',
      code: 002,
      name: "Link",
      dateRegistored: DateTime.now(),
      costPrice: 1000.00,
      sellingPrice: 850.00,
      packageType: "CTN",
      transactions: [
        Transaction(
          id: "T001",
          type: TransactionType.buy,
          quantity: 100,
          invoiceNumber: 00001,
          price: 1000,
          dateTimeTransaction: DateTime.now(),
          dateTimeSaved: DateTime.now(),
        ),
        Transaction(
          id: "T002",
          type: TransactionType.sell,
          quantity: 80,
          invoiceNumber: 00002,
          price: 1000,
          dateTimeTransaction: DateTime.now(),
          dateTimeSaved: DateTime.now(),
        ),
        Transaction(
          id: "T003",
          type: TransactionType.sell,
          quantity: 10,
          invoiceNumber: 01548,
          price: 1000,
          dateTimeTransaction: DateTime.now(),
          dateTimeSaved: DateTime.now(),
        ),
        Transaction(
          id: "T004",
          type: TransactionType.buy,
          quantity: 10,
          invoiceNumber: 01548,
          price: 1000,
          dateTimeTransaction: DateTime.now(),
          dateTimeSaved: DateTime.now(),
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

//Add new Transaction

  void addTransaction(Transaction newTransaction, String stockId) {
    Stock findStock = _items.firstWhere((st) => st.id == stockId);
    findStock.transactions.add(newTransaction);
    notifyListeners();
  }

//Finding single stock
  Stock singleStock(String stockid) {
    Stock foundStock;
    foundStock = _items.firstWhere((e) => e.id == stockid);
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
    foundStock.transactions.reversed;
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

  Stock findStock(String stockId) {
    final stock = _items.firstWhere((st) => st.id == stockId);
    return stock;
  }

  //finding the closest stock
  List<List<Stock>> getStocksByCostPrice(List<Item> sells) {
    List<List<Stock>> foundStock = [];

    for (Item item in sells) {
      List<Stock> filteredStocks = [];

      for (Stock stock in _items) {
        if (stock.costPrice <= item.price) {
          filteredStocks.add(stock);
        }
      }

      foundStock.add(filteredStocks);
    }

    return foundStock;
  }

  List<Stock> findStocksByCostPrice(double price) {
    List<Stock> filteredStocks = [];
    for (Stock stock in _items) {
      if (stock.costPrice <= price) {
        filteredStocks.add(stock);
      }
    }

    return filteredStocks;
  }
}
