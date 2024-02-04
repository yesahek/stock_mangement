// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stock_mangement/models/stock.dart';
import 'package:stock_mangement/models/transaction.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/util.dart';
import 'package:stock_mangement/widgets/app_button.dart';

import '../util/colors.dart';
import '../widgets/app_drawer.dart';

class SaleScreen extends StatefulWidget {
  String stockId;
  int stockBalance;
  SaleScreen({
    Key? key,
    required this.stockId,
    required this.stockBalance,
  }) : super(key: key);

  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  void initState() {
    super.initState();
    _invoiceNumberController = TextEditingController();
  }

  var _newTransaction = Transaction(
    id: "",
    type: TransactionType.sell,
    quantity: 0,
    invoiceNumber: 000,
    dateTimeTransaction: DateTime.now(),
    dateTimeSaved: DateTime.now(),
    price: 0,
  );

  final _initValues = {
    'quantity': '',
    'price': '',
    'invoiceNumber': '0000',
  };

  final _quantityFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  late TextEditingController _invoiceNumberController;

  final _form = GlobalKey<FormState>();
  final _formInvoice = GlobalKey<FormState>();
  bool _isLoading = false;

  void acceptInvoiceNumber() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Invoice Number"),
          content: Form(
            key: _formInvoice,
            child: TextFormField(
              autofocus: true,
              decoration: const InputDecoration(hintText: "Invice Number"),
              keyboardType: TextInputType.number,
              initialValue: _initValues['invoiceNumber'],
              // controller: _invoiceNumberController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter an Invoice Number';
                }
                if (int.parse(value.toString()) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              onSaved: (newValue) =>
                  _newTransaction.invoiceNumber = int.parse(newValue!),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (!isValid) {
                  return;
                }
                _formInvoice.currentState?.save();
                _save();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _save() {
    String forSnack = "";
    setState(() {
      _isLoading = true;
    });
    _form.currentState?.save();

    Provider.of<StocksProvider>(context, listen: false)
        .addTransaction(_newTransaction, widget.stockId);
    // Provider.of<StocksProvider>(context, listen: false).addStock(_newStock);
    forSnack = "Added successfuly";

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).popAndPushNamed("/Stocks");
    showSnackBar(context, forSnack);
  }

  void _cancel() {
    //print("Save Button");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _quantityFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Stocks",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigator.pop(context);
            Navigator.popAndPushNamed(context, "/Stocks");
          },
        ),
      ),
      endDrawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: Form(
          key: _form,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  initialValue: _initValues['quantity'],
                  decoration: const InputDecoration(labelText: "Quantity"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _quantityFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    }
                    if (int.tryParse(value.toString())! <= 0) {
                      return 'Please enter a number greater than zero.';
                    }
                    if (int.tryParse(value.toString())! > widget.stockBalance) {
                      return 'You can\'t saile more than ${widget.stockBalance}';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _newTransaction = Transaction(
                      id: _newTransaction.id,
                      type: _newTransaction.type,
                      quantity: int.parse(newValue!),
                      invoiceNumber: _newTransaction.invoiceNumber,
                      dateTimeTransaction: _newTransaction.dateTimeTransaction,
                      dateTimeSaved: _newTransaction.dateTimeSaved,
                      price: _newTransaction.price,
                    );
                  },
                ),

                // seiling price

                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: const InputDecoration(labelText: "price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Quantity';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid number.';
                    } else if (double.parse(value) <= 0) {
                      return 'Please enter a number greater than zero.';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _newTransaction = Transaction(
                      id: _newTransaction.id,
                      type: _newTransaction.type,
                      quantity: _newTransaction.quantity,
                      invoiceNumber: _newTransaction.invoiceNumber,
                      dateTimeTransaction: _newTransaction.dateTimeTransaction,
                      dateTimeSaved: _newTransaction.dateTimeSaved,
                      price: double.parse(newValue!),
                    );
                  },
                ),

                //buttons
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      AppButton(
                        title: "Cancel",
                        onTap: () => _cancel(),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      AppButton(
                        title: "Save",
                        onTap: () {
                          final isValid = _form.currentState!.validate();
                          if (!isValid) {
                            return;
                          }
                          acceptInvoiceNumber();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
