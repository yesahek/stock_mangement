// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../util/colors.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final Widget topBar;
  final bool backButton;
  final bool goHome;
  final Widget ? secondBar;
  const MyAppBar({
    Key? key,
    this.title = "Negade App",
    this.topBar = const SizedBox(),
    this.backButton = true,
    this.goHome = false,
    this.secondBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: appColor,
          foregroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              const SizedBox(
                height: 05,
              ),
              topBar,
            ],
          ),
          leading: backButton
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    !goHome
                        ? Navigator.pop(context)
                        : Navigator.popAndPushNamed(context, "/");
                  },
                )
              : null,
          // actions: const [
          //   IconButton(
          //     onPressed: null,
          //     icon: Icon(
          //       Icons.search,
          //       color: Colors.white,
          //     ),
          //   ),
          // ],
        ),
        Container(
          color: appColor,
          child: secondBar,
        )
      ],
    );
  }
}
