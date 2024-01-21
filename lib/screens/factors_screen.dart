import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/main.dart';
import 'package:stock_mangement/providers/factor_provider.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';
import 'package:stock_mangement/widgets/my_app_bar.dart';
import 'package:stock_mangement/widgets/single_stock.dart';

import '../models/items.dart';
import '../widgets/singelFactor.dart';

class Factors extends StatefulWidget {
  const Factors({super.key});
  static const routeName = "/Factors";

  @override
  State<Factors> createState() => _FactorsState();
}

class _FactorsState extends State<Factors> {
  @override
  Widget build(BuildContext context) {
    List<Items> factors =
        context.watch<FactorProvider>().items.reversed.toList();
    return Scaffold(
      endDrawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MyAppBar(
              goHome: true,
              title: "Factors",
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: factors.length,
              itemBuilder: (_, i) => singleFactor(
                factors: factors[i],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
