// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:stock_mangement/models/transaction.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/util/util.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';

import '../models/stock.dart';
import '../widgets/app_button.dart';

class AddNewStockTransactionScreen extends StatefulWidget {
  String stockId;
  int code;
  String name;
  int balance;
  List<Transaction> transaction;
  AddNewStockTransactionScreen({
    Key? key,
    required this.stockId,
    required this.code,
    required this.name,
    required this.balance,
    required this.transaction,
  }) : super(key: key);
  static const routeName = "/AddNewStockTransactionScreen";

  @override
  State<AddNewStockTransactionScreen> createState() =>
      _AddNewStockTransactionScreenState();
}

class _AddNewStockTransactionScreenState
    extends State<AddNewStockTransactionScreen> {
  var _newTransaction = Transaction(
    id: "",
    type: TransactionType.buy,
    quantity: 0,
    invoiceNumber: 000,
    dateTimeTransaction: DateTime.now(),
    dateTimeSaved: DateTime.now(),
    price: 0,
  );
  final _initValues = {
    'InvoiceNumber': '',
    'datePurchased': '',
    'costPrice': '',
    'Quantity': '',
    'Remark': ''
  };

  final _invoiceFocusNode = FocusNode();
  final _datePFocusNode = FocusNode();
  final _costPFocusNode = FocusNode();
  final _remarkFocusNode = FocusNode();
  final _quatntityFocusNode = FocusNode();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

  void _save() {
    String forSnack = "";
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();
    Provider.of<StocksProvider>(context, listen: false)
        .addTransaction(_newTransaction, widget.stockId);
    // Provider.of<StocksProvider>(context, listen: false).addStock(_newStock);
    forSnack = "Added successfuly";

    setState(() {
      _isLoading = false;
    });
    showSnackBar(context, forSnack);
    Navigator.of(context).pop();
  }

  void _cancel() {
    //print("Save Button");
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _datePFocusNode.dispose();
    _costPFocusNode.dispose();
    _quatntityFocusNode.dispose();
    _remarkFocusNode.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "${widget.name} - ${widget.code}",
                style: const TextStyle(color: Colors.white),
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
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.10,
                      ),
                      Text(
                          "Name: ${widget.name} - ${widget.code} Balance:  ${widget.balance}"),

                      //Invoice number input field
                      TextFormField(
                          initialValue: _initValues['InvoiceNumber'],
                          decoration: const InputDecoration(
                              labelText: 'Invoice Number'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _invoiceFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_datePFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a price.';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            if (int.parse(value) <= 0) {
                              return 'Please enter a number greater than zero.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newTransaction = Transaction(
                              id: _newTransaction.id,
                              type: _newTransaction.type,
                              quantity: _newTransaction.quantity,
                              invoiceNumber: int.parse(value!),
                              dateTimeTransaction:
                                  _newTransaction.dateTimeTransaction,
                              dateTimeSaved: _newTransaction.dateTimeSaved,
                              price: _newTransaction.price,
                            );
                          }),

                      //Date Purchased Input field
                      TextFormField(
                          //initialValue: _initValues['datePurchased'],
                          decoration: const InputDecoration(
                              labelText: 'Date Purchased'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.datetime,
                          //focusNode: _datePFocusNode,
                          controller: _dateController,
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (_selectedDate == null) {
                              return 'Please select a date.';
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_costPFocusNode);
                          },
                          onSaved: (value) {
                            _newTransaction = Transaction(
                              id: _newTransaction.id,
                              type: _newTransaction.type,
                              quantity: _newTransaction.quantity,
                              invoiceNumber: _newTransaction.invoiceNumber,
                              dateTimeTransaction: DateTime.parse(value!),
                              dateTimeSaved: _newTransaction.dateTimeSaved,
                              price: _newTransaction.price,
                            );
                          }),
                      //
                      TextFormField(
                          initialValue: _initValues['costPrice'],
                          decoration:
                              const InputDecoration(labelText: 'Cost Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _costPFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_quatntityFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a price.';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than zero.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newTransaction = Transaction(
                              id: _newTransaction.id,
                              type: _newTransaction.type,
                              quantity: _newTransaction.quantity,
                              invoiceNumber: _newTransaction.invoiceNumber,
                              dateTimeTransaction:
                                  _newTransaction.dateTimeTransaction,
                              dateTimeSaved: _newTransaction.dateTimeSaved,
                              price: double.parse(value!),
                            );
                          }),

                      //Quatity input field
                      TextFormField(
                          initialValue: _initValues['Quantity'],
                          decoration:
                              const InputDecoration(labelText: 'Quantity'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _quatntityFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_remarkFocusNode);
                          },
                          validator: (value) {
                            if (int.tryParse(value!) == null) {
                              return 'Please enter a valid number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newTransaction = Transaction(
                              id: _newTransaction.id,
                              type: _newTransaction.type,
                              quantity: int.parse(value!),
                              invoiceNumber: _newTransaction.invoiceNumber,
                              dateTimeTransaction:
                                  _newTransaction.dateTimeTransaction,
                              dateTimeSaved: _newTransaction.dateTimeSaved,
                              price: _newTransaction.price,
                            );
                          }),

                      //Remark Input field

                      TextFormField(
                          initialValue: _initValues['Remark'],
                          decoration:
                              const InputDecoration(labelText: 'Remark'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          focusNode: _remarkFocusNode,
                          onSaved: (value) {
                            _newTransaction = Transaction(
                              id: _newTransaction.id,
                              type: _newTransaction.type,
                              quantity: _newTransaction.quantity,
                              invoiceNumber: _newTransaction.invoiceNumber,
                              dateTimeTransaction:
                                  _newTransaction.dateTimeTransaction,
                              dateTimeSaved: _newTransaction.dateTimeSaved,
                              price: _newTransaction.price,
                              remark: _newTransaction.remark,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButton(
                              title: "Cancel",
                              onTap: _cancel,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            AppButton(
                              title: "Save",
                              onTap: () => _save(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

//Date Selector
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? currentDate,
      firstDate: currentDate.subtract(const Duration(days: 365)),
      lastDate: currentDate.add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }
}
