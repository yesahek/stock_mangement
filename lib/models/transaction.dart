import 'package:flutter/material.dart';

enum TransactionType { buy, sell }

class Transaction with ChangeNotifier {
  String id;
  TransactionType type;
  int quantity;
  int invoiceNumber;
  double price;
  DateTime dateTimeTransaction;
  DateTime dateTimeSaved;
  double total;
  String remark;

  Transaction({
    required this.id,
    required this.type,
    required this.quantity,
    required this.invoiceNumber,
    required this.dateTimeTransaction,
    required this.dateTimeSaved,
    required this.price,
    this.remark = '',
  }) : total = quantity * price;
}
