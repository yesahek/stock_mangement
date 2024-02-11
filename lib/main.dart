import 'package:flutter/material.dart';
import 'package:stock_mangement/models/stock_adapter.dart';
import 'package:stock_mangement/providers/factor_provider.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/screens/factors_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/transaction_adapter.dart';
import 'screens/home_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/add_new_stocks_screen.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();
// Register the StockAdapter
  Hive.registerAdapter(StockAdapter());

  Hive.registerAdapter(TransactionAdapter()); // Register the adapter
  // open a box
  await Hive.openBox('stocks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: StocksProvider(),
        ),
        ChangeNotifierProvider.value(
          value: FactorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Negade App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        home: const Home(),
        routes: {
          Stocks.routeName: (context) => const Stocks(),
          AddNewStocksScreen.routeName: (context) => const AddNewStocksScreen(),
          // AddNewStockTransactionScreen.routeName: (context) =>  AddNewStockTransactionScreen(),
          Factors.routeName: (context) => const Factors(),
          //StockTransaction.routeName: (context) => const StockTransaction(),
          //ItemInvoice.routeName: (context) => const ItemInvoice(),
        },
      ),
    );
  }
}
