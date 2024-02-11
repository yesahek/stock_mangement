// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:stock_mangement/models/transaction.dart';

import '../models/item.dart';
import '../models/items.dart';
import '../models/sells.dart';
import '../models/stock.dart';
import '../providers/stocks_provider.dart';
import '../util/colors.dart';
import '../util/util.dart';
import '../widgets/single_item.dart';

//show invoice
showAlertDialog(BuildContext context, List<Sells> sells) {
  String invoiceNumber = '';

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text('Enter Invoice Number'),
    content: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        invoiceNumber = value;
      },
      decoration: const InputDecoration(labelText: 'Invoice Number'),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          var transactioner =
              Provider.of<StocksProvider>(context, listen: false);
          for (var sell in sells) {
            Transaction newTras = Transaction(
              id: Uuid().v1(),
              type: TransactionType.sell,
              quantity: sell.item.quantity,
              invoiceNumber: int.parse(invoiceNumber),
              dateTimeTransaction: DateTime.now(),
              dateTimeSaved: DateTime.now(),
              price: sell.item.price,
            );
            transactioner.addTransaction(
              newTras,
              sell.stock.id,
            );
          }
          Navigator.of(context).pushReplacementNamed('/');
          showSnackBar(context, "Item Sold!");

          // Navigator.pop(context);
        },
        child: const Text('Submit'),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


Future<dynamic> showInvoice(
    BuildContext context, Items bTax, List<Item> items, double tax) {
  bool stockAvailable = true;
  int availableStockLength = StocksProvider().items.length;
  if (availableStockLength == 0) {
    stockAvailable = false;
  } else {
    stockAvailable = true;
  }

  return stockAvailable
      ? showModalBottomSheet(
          context: context,
          builder: (context) {
            // List<List<Stock>> foundStock =
            //     Provider.of<StocksProvider>(context).getStocksByCostPrice(rows);
            List<List<Stock>> foundStock = Provider.of<StocksProvider>(context)
                .getStocksByCostPriceAndAll(items);
            double total = (bTax.total * tax / 100) + bTax.total;

            List<Sells> newSells = [];
            for (var it in items) {
              for (var stId in foundStock) {
                newSells.add(Sells(stock: stId[0], item: it));
              }
            }
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
                            Text("Tax : $tax%"),
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
                        itemCount: items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SingleItem(
                            bTax: bTax.Item[index],
                            item: items[index],
                            founStock: foundStock[index],
                            showDetail: false,
                            trackItem: (stock, item) =>
                                newSells.add(Sells(stock: stock, item: item)),
                            onStockSelected: (stockSelected) {
                              var pointer = newSells.firstWhere(
                                (ite) => ite.item.id == items[index].id,
                              );
                              pointer.stock = stockSelected;
                            },
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    OutlinedButton(
                      onPressed: () => showAlertDialog(context, newSells),
                      child: const Text("SELL"),
                    ),
                  ],
                );
              },
            );
          },
        )
      : showSnackBar(context, "There is No Stock Available");
}
