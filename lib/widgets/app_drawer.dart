import 'package:flutter/material.dart';
import 'package:stock_mangement/util/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            title: const Text("Hello, User"),
            backgroundColor: appColor,
            foregroundColor: Colors.white,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy),
            title: const Text('Stocks'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/Stocks');
            },
          ),
             ListTile(
            leading: const Icon(Icons.folder_copy),
            title: const Text('Factors'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/Factors');
            },
          ),
        ],
      ),
    );
  }
}
