// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_mangement/models/item.dart' as item;

class Items with ChangeNotifier {
  String id;
  String customerName;
  // ignore: non_constant_identifier_names
  List<item.Item> Item;
  DateTime dateTime;
  double total;
  double loan;
  double payment;
  bool isPaid;
  double serviceCharge;
  double discount;
  double oldLoan;
  Items({
    // ignore: non_constant_identifier_names
    required this.id,
    required this.customerName,
    // ignore: non_constant_identifier_names
    required this.Item,
    required this.dateTime,
    required this.total,
    this.loan = 0.0,
    this.payment = 0.0,
    this.isPaid = true,
     this.serviceCharge = 0.0,
     this.discount= 0.0,
     this.oldLoan =0.0,
  });

// //isPaid?
//   static bool checkIsPaid(loan) {
//     bool result;
//     if (loan <= 0.00) {
//       result = true;
//     } else {
//       result = false;
//     }
//     return result;
//   }
}
