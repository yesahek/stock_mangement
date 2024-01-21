import 'package:flutter/material.dart';
import 'package:stock_mangement/models/item.dart';
import 'package:stock_mangement/models/items.dart';

class FactorProvider with ChangeNotifier {
  final List<Items> _items = [
    Items(
        id: "id",
        customerName: "Ukee First",
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350),
        ],
        dateTime: DateTime.now(),
        total: 2350),
    Items(
        id: "id",
        customerName: "Ukee",
        dateTime: DateTime.now(),
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350)
        ],
        total: 2350),
    Items(
        id: "id",
        customerName: "Ukee",
        dateTime: DateTime.now(),
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350)
        ],
        total: 2350),
    Items(
        id: "id",
        customerName: "Ukee",
        dateTime: DateTime.now(),
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350)
        ],
        total: 2350),
    Items(
        id: "id",
        customerName: "Ukee",
        dateTime: DateTime.now(),
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350)
        ],
        total: 2350),
    Items(
        id: "id",
        customerName: "Issac Last",
        dateTime: DateTime.now(),
        Item: [
          Item(id: "id", name: "Glass", quantity: 5, price: 470, total: 2350)
        ],
        total: 2350)
  ];

//geter
  List<Items> get items {
    return [..._items];
  }

  //add Items
  void addFactors(newItems) {
    _items.add(newItems);
    notifyListeners();
  }
}
