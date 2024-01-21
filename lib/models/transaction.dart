
import 'package:flutter/material.dart';

enum TransactionType{ buy, sell}

class Transaction with ChangeNotifier {
  String id;
  TransactionType type;
  int quantity;
  int invoiceNumber;
  double price;
  DateTime dateTime; 
  double total;

  Transaction({
    required this.id,
    required this.type,
    required this.quantity,
    required this.invoiceNumber,
    required this.dateTime,
    required this.price, 
  }) : total = quantity * price ;
}
