// displaying snackbas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/models/transaction.dart';

import '../models/item.dart';
import '../models/items.dart';
import '../models/stock.dart';
import '../providers/stocks_provider.dart';
import '../widgets/single_item.dart';
import 'colors.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
