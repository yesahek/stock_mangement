import 'package:flutter/material.dart';
import 'package:stock_mangement/providers/factor_provider.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/screens/factors_screen.dart';

import 'screens/home_screen.dart';
import 'screens/stocks_screen.dart';
import 'screens/add_new_stocks_screen.dart';

void main() {
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
          Factors.routeName: (context) => const Factors(),
          //StockTransaction.routeName: (context) => const StockTransaction(),
          //ItemInvoice.routeName: (context) => const ItemInvoice(),
        },
      ),
    );
  }
}
