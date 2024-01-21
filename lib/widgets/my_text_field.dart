// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController controller;
  final bool editable;
  const MyTextField({
    Key? key,
    this.hintText = '',
    required this.label,
    required this.controller,
    this.editable = true, required Null Function(dynamic value) onSave, required Null Function(dynamic _) onFieldSubmitted, required String? Function(dynamic value) validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controler = TextEditingController(text: controller.text);
    return Card(
      child: TextFormField(
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(12),
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
          
        ],
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        controller: controler,
        enabled: editable,
       
        decoration: InputDecoration(
          // border: const OutlineInputBorder(),
          labelStyle: !editable
              ? const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                )
              : const TextStyle(
                  // fontSize: 18,
                  // fontWeight: FontWeight.bold,
                  // color: Colors.black,
                ),
          hintText: hintText,
          label: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
