// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/providers/factor_provider.dart';
import 'package:stock_mangement/util/colors.dart';

import 'package:stock_mangement/widgets/app_button.dart';

import '../models/items.dart';
import '../util/util.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/my_text_box.dart';

// ignore: must_be_immutable
class FactorScreen extends StatefulWidget {
  Items itemList;
  FactorScreen({
    Key? key,
    required this.itemList,
  }) : super(key: key);

  @override
  State<FactorScreen> createState() => _FactorScreenState();
}

class _FactorScreenState extends State<FactorScreen> {
  bool _isLoading = false;
  void clear() {}
  void share() {}
  void save() {
    String forSnack = "";
    setState(() {
      _isLoading = true;
    });
    Provider.of<FactorProvider>(context, listen: false)
        .addFactors(widget.itemList);
    forSnack = "Stock Added successfuly";

    setState(() {
      _isLoading = false;
    });
    showSnackBar(context, forSnack);
    Navigator.of(context).pop();
  }

  void add() {}

  void generateInvoice() {
    // Update the loan amount based on the payment
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget secondBar = Column(
      children: [
        const Divider(
          color: Colors.white,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButton(
              title: "Clear",
              onTap: clear,
            ),
            AppButton(
              title: "Share",
              onTap: share,
            ),
            AppButton(
              title: "Save",
              onTap: save,
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyAppBar(
              backButton: true,
              secondBar: secondBar,
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.values[5],
              children: [
                Text(
                  widget.itemList.customerName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Date ${DateFormat.yMd().format(DateTime.now()).toString()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            dataRowHeight: 35,
                            columnSpacing: width / 12,
                            columns: const [
                              DataColumn(
                                label: Text('No'),
                                numeric: true,
                              ),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Qty')),
                              DataColumn(label: Text('Price')),
                              DataColumn(label: Text('Total')),
                            ],
                            rows: [
                              for (var item in widget.itemList.Item)
                                DataRow(
                                  cells: [
                                    DataCell(Text(item.id)),
                                    DataCell(
                                      Text(item.name),
                                      showEditIcon: true,
                                      placeholder: true,
                                    ),
                                    DataCell(Text("${item.quantity}")),
                                    DataCell(Text("${item.price}")),
                                    DataCell(Text("${item.total}")),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        //Total, Payment and Loan
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PopupMenuButton(
                              icon: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: appColor, width: 3),
                                ),
                                //color: Colors.grey,
                                child: const Row(
                                  children: [
                                    Icon(Icons.add),
                                    Text("Add"),
                                  ],
                                ),
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: Text("B"),
                                  child: Text("A"),
                                ),
                                const PopupMenuItem(
                                  value: Text("B"),
                                  child: Text("A"),
                                ),
                                const PopupMenuItem(
                                  value: Text("B"),
                                  child: Text("A"),
                                ),
                              ],
                              onSelected: (value) {
                                setState(() {});
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Divider(),
                                MyTextBox(
                                  amount: widget.itemList.total,
                                  labelText: "Total      ",
                                  isEditable: false,
                                ),
                                MyTextBox(
                                  amount: widget.itemList.payment,
                                  labelText: "payment",
                                  onChanged: (value) {
                                    setState(() {
                                      widget.itemList.payment =
                                          double.parse(value);
                                      widget.itemList.loan =
                                          widget.itemList.total -
                                              double.parse(value);
                                    });
                                  },
                                ),
                                Text(
                                    "Loan                          ${widget.itemList.loan}"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    "0912345678",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
