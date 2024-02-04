// displaying snackbas
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/screens/invoice_generator_screen.dart';
import 'package:stock_mangement/widgets/app_button.dart';

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

//show invoice

Future<dynamic> showInvoice(
    BuildContext context, Items bTax, List<Item> rows, double tax) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      List<List<Stock>> foundStock =
          Provider.of<StocksProvider>(context).getStocksByCostPrice(rows);
      double total = (bTax.total * tax / 100) + bTax.total;

      return DraggableScrollableSheet(
        initialChildSize: 0.90,
        minChildSize: 0.25,
        maxChildSize: 1.0,
        expand: false,
        builder: (context, scrollController) {
          return Column(
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
                  controller: scrollController,
                  itemCount: rows.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SingleItem(
                      bTax: bTax.Item[index],
                      item: rows[index],
                      founStock: foundStock[index],
                      showDetail: false,
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
