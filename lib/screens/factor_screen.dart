// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:stock_mangement/providers/factor_provider.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/widgets/app_button.dart';

import '../models/item.dart';
import '../models/items.dart';
import '../util/util.dart';
import '../widgets/invoice_generator.dart';
import '../widgets/my_text_box.dart';

// ignore: must_be_immutable
class FactorScreen extends StatefulWidget {
  Items originalList;
  Items bTax;
  final double tax;
  FactorScreen({
    Key? key,
    required this.originalList,
    required this.bTax,
    required this.tax,
  }) : super(key: key);

  @override
  State<FactorScreen> createState() => _FactorScreenState();
}

class _FactorScreenState extends State<FactorScreen> {
  late TextEditingController _invoiceNumberController;
  late TextEditingController _customerNameController;
  void clear() {}
  void share() {}
  void save(String name) {
    widget.originalList.customerName = name;
    String forSnack = "";
    setState(() {});
    Provider.of<FactorProvider>(context, listen: false)
        .addFactors(widget.originalList);
    forSnack = "Factor Added successfuly";

    setState(() {});
    showSnackBar(context, forSnack);
    Navigator.of(context).pop();
  }

  void saveToStock() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invoice Number"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: "Invoice Number"),
            controller: _invoiceNumberController,
          ),
          actions: const [
            TextButton(
              onPressed: null,
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  //Generate Invoice Button
  void generateInvoice(bool isStockAvailable) {
    isStockAvailable
        ? showInvoice(context, widget.bTax, widget.bTax.Item, widget.tax)
        : showSnackBar(context, "There is No Stock Available!");
  }

  @override
  void initState() {
    super.initState();
    _invoiceNumberController = TextEditingController();
    _customerNameController = TextEditingController();
  }

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    bool stockAvailable = true;
    int availableStockLength =
        Provider.of<StocksProvider>(context).items.length;
    if (availableStockLength == 0) {
      stockAvailable = false;
    } else {
      stockAvailable = true;
    }
    List<Item> originalList = widget.originalList.Item;
    List<Item> bTaxRows = widget.bTax.Item;
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Customer Name"),
                      content: TextField(
                        autofocus: true,
                        decoration:
                            const InputDecoration(hintText: "Unkown Customer"),
                        controller: _customerNameController,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => save(_customerNameController.text),
                          child: const Text("Submit"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              AppBar(
                backgroundColor: appColor,
                foregroundColor: Colors.white,
                title: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Factor"),
                    SizedBox(
                      height: 05,
                    ),
                  ],
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context, widget.originalList);
                  },
                ),
              ),
              Container(
                color: appColor,
                child: secondBar,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.values[5],
                children: [
                  Text(
                    widget.originalList.customerName,
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
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              /// dataRowHeight: 35,
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
                                for (var item in originalList)
                                  DataRow(
                                    cells: [
                                      DataCell(Text(item.id)),
                                      DataCell(
                                        TextFormField(
                                          initialValue: item.name,
                                          keyboardType: TextInputType.text,
                                          onFieldSubmitted: (value) {
                                            item.name = value;
                                          },
                                        ),
                                        // Text(item.name),
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

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Divider(),
                              MyTextBox(
                                amount: widget.originalList.total,
                                labelText: "Total      ",
                                isEditable: false,
                              ),
                              MyTextBox(
                                amount: widget.originalList.payment,
                                labelText: "payment",
                                onChanged: (value) {
                                  setState(() {
                                    widget.originalList.payment =
                                        double.parse(value);
                                    widget.originalList.loan =
                                        widget.originalList.total -
                                            double.parse(value);
                                  });
                                },
                              ),
                              Text(
                                  "Loan                          ${widget.originalList.loan}"),
                            ],
                          ),
                          const Divider(),
                          OutlinedButton(
                            onPressed: () => generateInvoice(stockAvailable),
                            child: const Text("Generate Invoice"),
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
      ),
    );
  }
}
