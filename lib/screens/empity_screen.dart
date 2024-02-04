import 'package:flutter/material.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';
import 'package:stock_mangement/widgets/my_app_bar.dart';

class EmpityScreen extends StatelessWidget {
  const EmpityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      endDrawer: AppDrawer(),
      body: Column(
        children: [
          MyAppBar(
            backButton: true,
            title: "Empity",
          ),
        ],
      ),
    );
  }
}
