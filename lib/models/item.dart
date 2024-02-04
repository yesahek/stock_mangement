// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Item with ChangeNotifier {
  String id;
  String name;
  int quantity;
  double price;
  double total;
  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.total,
  });

 
}
