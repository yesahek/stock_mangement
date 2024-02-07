// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stock_mangement/util/colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: OutlinedButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(appColor)),
        onPressed: onTap,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
