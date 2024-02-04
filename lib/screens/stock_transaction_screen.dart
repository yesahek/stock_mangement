// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/models/transaction.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';

import '../models/stock.dart';
import '../util/colors.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/single_transaction.dart';

class StockTransaction extends StatelessWidget {
  final String stockId;
  const StockTransaction({
    Key? key,
    required this.stockId,
  }) : super(key: key);
  //static const routeName = "/StockTransaction";

  @override
  Widget build(BuildContext context) {
    Stock stock = Provider.of<StocksProvider>(context).singleStock(stockId);
    List<Transaction> transactions = stock.transactions;

    List<int> balanceGenerator() {
      List<int> balance = List.filled(transactions.length, 0);
      int mainBalance = 0;

      if (transactions.isEmpty) {
        return balance; // Assuming initial balance is 0 if there are no transactions
      }

      for (int i = 0; i <= transactions.length - 1; i++) {
        int currentQty = transactions[i].quantity;
        TransactionType currentType = transactions[i].type;

        if (currentType == TransactionType.buy) {
          mainBalance += currentQty;
          balance[i] = mainBalance; // Buying increases the balance
        } else if (currentType == TransactionType.sell) {
          mainBalance -= currentQty;
          balance[i] = mainBalance; // Selling decreases the balance
        }
      }
      return balance;
    }

    List<int> balances = balanceGenerator();

    Widget topBar = Row(
      children: [
        Text(
          "Cost P: ${stock.costPrice} ",
          style: const TextStyle(fontSize: 15),
        ),
        // Container(width: 2, color: Colors.red),
        const Text(
          "| ",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),
        ),
        Text(
          " Sailing P : ${stock.sellingPrice}",
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );

    return Scaffold(
      endDrawer: const AppDrawer(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            MyAppBar(title: "${stock.code} - ${stock.name}", topBar: topBar),
            Column(
              children: [
                const Card(
                  color: appColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: appColor, width: 1.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Date",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Buy / Sell",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Balance",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: transactions.length,
                    itemBuilder: (_, i) => SingleTransaction(
                      stockId: stockId,
                      code: stock.code,
                      name: stock.name,
                      transaction: transactions[i],
                      //balance: stock.balance,
                      balance: balances[i],
                      costPrice: stock.costPrice,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
