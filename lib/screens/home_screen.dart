import 'package:flutter/material.dart';
import 'package:stock_mangement/screens/calculator_screen.dart';

import '../widgets/app_drawer.dart';
import '../widgets/my_app_bar.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    //print("width $width " + "height $height");

    return Scaffold(
      endDrawer: const AppDrawer(),
      body: Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          const MyAppBar(
            backButton: false,
          ),
          SizedBox(
            height: height * 0.88,
            child: PageView(
              onPageChanged: null,
              children: const [
                CalculatorScreen(),
               // FactorScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
