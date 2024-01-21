import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';

import '../models/stock.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/single_stock.dart';

class Stocks extends StatefulWidget {
  const Stocks({super.key});
  static const routeName = "/Stocks";

  @override
  State<Stocks> createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  @override
  Widget build(BuildContext context) {
    List<Stock> stock = context.watch<StocksProvider>().items;
    Widget topBAr = const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Stocks : 6"),
        Text("Stocks : 37,000"),
      ],
    );
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              topBar: topBAr,
              goHome: true,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: stock.length,
              itemBuilder: (_, i) => SingleStock(received: stock[i].totalReceived,
                stockId: stock[i].id,
                balance: stock[i].balance,
                birrBal: stock[i].balance * stock[i].costPrice,
                code: stock[i].code,
                costP: stock[i].costPrice,
                name: stock[i].name,
                showDetail: false,
                //onTap: showDetail,
                sailed: stock[i].totalSailed,
                sellingP: stock[i].sellingPrice,
                dateReg: stock[i].dateRegistored,
                datePur: stock[i].datePurchased,
                lastSailed: DateTime.now(),
                // lastSailed: stock[i]
                //     .transactions[stock[i].transactions.length - 1]
                //     .dateTime,
                transaction: stock[i].transactions,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () => Navigator.pushNamed(context, '/AddNewStocksScreen'),
        // Navigator.of(context).pushReplacementNamed('/AddNewStocksScreen'),
        backgroundColor: appColor,
        child: const Text(
          "+",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
