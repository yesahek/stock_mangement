// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stock_mangement/models/item.dart';
import 'package:stock_mangement/util/colors.dart';

import '../models/items.dart';
import '../models/stock.dart';
import '../providers/stocks_provider.dart';
import '../widgets/single_item.dart';

class InvoiceGeneratorScreen extends StatelessWidget {
  final Items items;
  final Items bTax;
  final double tax;
  const InvoiceGeneratorScreen({
    Key? key,
    required this.items,
    required this.bTax,
    required this.tax,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    List<List<Stock>> foundStock =
        Provider.of<StocksProvider>(context).getStocksByCostPrice(items.Item);
    double total = (bTax.total * tax / 100) + bTax.total;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          IgnorePointer(
            child: SizedBox(
              height: 50,
              child: AppBar(
                title: const Text("Choose Stocks"),
                automaticallyImplyLeading: false,
                actions: [
                  const VerticalDivider(
                    width: 10,
                    color: appColor,
                  ),
                  Text("Tax : ${tax}%"),
                  const VerticalDivider(
                    width: 10,
                    color: appColor,
                  ),
                  Text("subT : ${bTax.total}"),
                  const VerticalDivider(
                    width: 10,
                    color: appColor,
                  ),
                  Text("ToTal : ${total.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              //controller: scrollController,
              itemCount: items.Item.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return SingleItem(
                  bTax: bTax.Item[index],
                  item: items.Item[index],
                  founStock: foundStock[index],
                  showDetail: false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
