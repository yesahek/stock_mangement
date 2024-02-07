// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stock_mangement/models/stock.dart';
import 'package:stock_mangement/screens/add_new_stock_transaction_screen.dart';

import 'package:stock_mangement/screens/stock_transaction_screen.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/widgets/app_button.dart';

import '../models/transaction.dart';
import '../screens/sale_screen.dart';

// ignore: must_be_immutable
class SingleStock extends StatefulWidget {
  final Stock stock;

  bool showDetail;
  SingleStock({
    Key? key,
    required this.stock,
    required this.showDetail,
  }) : super(key: key);

  @override
  State<SingleStock> createState() => _SingleStockState();
}

class _SingleStockState extends State<SingleStock> {
  String daysBetween(DateTime from) {
    String daysBetw;
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime.now();
    int res = (to.difference(from).inHours);
    if (res > 24) {
      daysBetw = "${(to.difference(from).inDays)} days ago";
    } else {
      daysBetw = "${(to.difference(from).inHours)}hrs ago";
    }
    return daysBetw;
  }

  void showDetail() {
    setState(() {
      widget.showDetail = !widget.showDetail;
    });
  }

  void openStockBtn(List<Transaction> transaction) {
    //Navigator.of(context).pushNamed('/StockTransaction');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StockTransaction(
          stockId: widget.stock.id,
        ),
      ),
    );
  }

  void saleBtn() {
    //Navigator.of(context).pushNamed('/StockTransaction');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaleScreen(
          stockId: widget.stock.id,
          stockBalance: widget.stock.balance,
        ),
      ),
    );
  }

  void addNewStockTransactionBtn() {
    //Navigator.of(context).pushNamed('/StockTransaction');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewStockTransactionScreen(
          transaction: widget.stock.transactions,
          balance: widget.stock.balance,
          code: widget.stock.code,
          name: widget.stock.name,
          stockId: widget.stock.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String profitPercent = widget.stock.profitPercent.toStringAsFixed(2);
    var size = MediaQuery.of(context).size;
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: appColor, width: 4.0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15.0,
          ),
          topRight: Radius.circular(15.0),
        ),
      ),
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: showDetail,
            child: ListTile(
              leading: const Icon(
                Icons.spa,
                size: 40,
              ),
              title: const Text(
                "Stocks",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "code ${widget.stock.code}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                  ),
                  const VerticalDivider(
                    width: 40,
                  ),
                  Expanded(
                    child: Text(
                      "last sailed ${daysBetween(
                        DateTime.now(),
                      )}",
                      style: const TextStyle(
                        color: appColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: Text(
                "${widget.stock.balance} X",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appColor,
                ),
              ),
            ),
          ),
          widget.showDetail
              ? SizedBox(
                  height: size.height * 0.30,
                  width: size.width,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: appColor, width: 1.0),
                      borderRadius: BorderRadius.zero,
                    ),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Name : ${widget.stock.name}"),
                                Text(
                                    "Date reg : ${widget.stock.dateRegistored.day}/${widget.stock.dateRegistored.month}/${widget.stock.dateRegistored.year}"),
                                Text(
                                    "Date pur : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
                                Text("Cost price : ${widget.stock.costPrice}"),
                                Text(
                                    "Selling price : ${widget.stock.sellingPrice}"),
                                Text(
                                    "Total Purchase : ${widget.stock.totalCostPrice}"),
                                Text(
                                    "Total sailed : ${widget.stock.totalSailedPrice}"),
                              ],
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("${widget.stock.balance} : Balance"),
                                Text(
                                    "${widget.stock.balance * widget.stock.costPrice} : Per Birr Bal"),
                                Text(
                                    "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} : Last Sailed"),
                                Text("${widget.stock.totalSailed} : Sailed"),
                                Text(
                                    "${widget.stock.totalReceived} : Received"),
                                Text("${profitPercent}% : Profit"),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              title: "Open Stock",
                              onTap: () => openStockBtn(
                                widget.stock.transactions,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            AppButton(
                              title: "Add new ${widget.stock.name}",
                              onTap: () => addNewStockTransactionBtn(),
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            AppButton(
                              title: "Sell ",
                              onTap: () => saleBtn(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // title: const Text('Sonu Nigam'),
                    // subtitle: const Text('Best of Sonu Nigam Song'),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
