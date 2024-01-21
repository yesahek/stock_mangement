import 'package:flutter/material.dart';

import '../models/items.dart';

class singleFactor extends StatelessWidget {
  final Items factors;
  const singleFactor({
    super.key,
    required this.factors,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(factors.customerName),
        subtitle: Text("${factors.total}"),
      ),
    );
  }
}
