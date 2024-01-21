// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final double amount;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final bool isEditable;

  const MyTextBox({
    Key? key,
    required this.amount,
    required this.labelText,
    this.onChanged,
    this.isEditable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.40,
      child: Center(
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          onChanged: onChanged,
          initialValue: "$amount",
          enabled: isEditable,
          decoration: InputDecoration(
            icon: Text(labelText),
          ),
        ),
      ),
    );
  }
}
