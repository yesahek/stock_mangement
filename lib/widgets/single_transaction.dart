// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_mangement/screens/item_invoice.dart';
import '../models/transaction.dart';
import '../util/colors.dart';

class SingleTransaction extends StatelessWidget {
  final String stockId;
  final int code;
  final String name;
  final int balance;
  final double costPrice;
  final Transaction transaction;
  const SingleTransaction({
    Key? key,
    required this.stockId,
    required this.code,
    required this.name,
    required this.balance,
    required this.costPrice,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isSell = transaction.type.name == "sell";
    String sign = '';
    isSell ? sign = '-' : sign = '+';
    void openInvoice() {
      //Navigator.pushNamed(context, '/ItemInvoice');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemInvoice(
            stockId: stockId,
            code: code,
            date: transaction.dateTimeTransaction,
            invNumber: transaction.invoiceNumber,
            name: name,
            quantity: transaction.quantity,
            unitPrice: transaction.price,
            transaction: transaction,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: openInvoice,
      child: Card(
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: appColor, width: 1.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Date of Transaction
                        Text(DateFormat.yMd()
                            .format(transaction.dateTimeTransaction)),
                        Text(DateFormat.jms()
                            .format(transaction.dateTimeTransaction)),
                        Text(transaction.invoiceNumber.toString()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quantity how much sailed
                        //  isSell ? const Text("+") : const Text('-'),
                        Text("$sign  ${transaction.quantity.toString()}"),
                        Text("X ${transaction.price}"),
                        Text("${transaction.quantity * transaction.price} Br"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text("$balance Items"),
                        Text("${balance * costPrice} br"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
