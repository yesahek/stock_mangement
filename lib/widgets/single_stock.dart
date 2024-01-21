// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_mangement/screens/stock_transaction_screen.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/widgets/app_button.dart';

import '../models/transaction.dart';

// ignore: must_be_immutable
class SingleStock extends StatefulWidget {
  final String stockId;
  final String name;
  final int code;
  final DateTime dateReg;
  final DateTime datePur;
  final double costP;
  final double sellingP;
  final int balance;
  final double birrBal;
  final DateTime lastSailed;
  final int sailed;
  final int received;
  final List<Transaction> transaction;
  bool showDetail;
  SingleStock({
    Key? key,
    required this.stockId,
    required this.name,
    required this.code,
    required this.dateReg,
    required this.datePur,
    required this.costP,
    required this.sellingP,
    required this.balance,
    required this.birrBal,
    required this.lastSailed,
    required this.sailed,
    required this.received,
    required this.transaction,
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
          stockId: widget.stockId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    "code ${widget.code}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: appColor,
                    ),
                  ),
                  const VerticalDivider(
                    width: 40,
                  ),
                  Text(
                    "last sailed ${daysBetween(widget.lastSailed)}",
                    style: const TextStyle(
                      color: appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Text(
                "${widget.balance} X",
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
                  height: size.height * 0.25,
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
                                Text("Name : ${widget.name}"),
                                Text(
                                    "Date reg : ${widget.dateReg.day}/${widget.dateReg.month}/${widget.dateReg.year}"),
                                Text(
                                    "Date pur : ${widget.datePur.day}/${widget.datePur.month}/${widget.datePur.year}"),
                                Text("Cost price : ${widget.costP}"),
                                Text("Selling price : ${widget.sellingP}"),
                              ],
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("${widget.balance} : Balance"),
                                Text("${widget.birrBal} : Per Birr Bal"),
                                Text(
                                    "${widget.lastSailed.day}/${widget.lastSailed.month}/${widget.lastSailed.year} : Last Sailed"),
                                Text("${widget.sailed} : Sailed"),
                                Text("${widget.received} : Received"),
                              ],
                            ),
                          ],
                        ),
                        AppButton(
                          title: "Open Stock",
                          onTap: () => openStockBtn(widget.transaction),
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
