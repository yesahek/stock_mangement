// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:stock_mangement/models/transaction.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/util.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';

import '../widgets/app_button.dart';
import '../widgets/my_app_bar.dart';

class ItemInvoice extends StatefulWidget {
  final int code;
  final int invNumber;
  final String name;
  final DateTime date;
  final int quantity;
  final double unitPrice;
  final String stockId;
  final Transaction transaction;

  const ItemInvoice({
    Key? key,
    required this.code,
    required this.invNumber,
    required this.name,
    required this.date,
    required this.quantity,
    required this.unitPrice,
    required this.stockId,
    required this.transaction,
  }) : super(key: key);
  // static const routeName = "/ItemInvoice";

  @override
  State<ItemInvoice> createState() => _ItemInvoiceState();
}

class _ItemInvoiceState extends State<ItemInvoice> {
  late Transaction newTransaction;
  final _invoiceFocusNode = FocusNode();
  final _qtyFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  // ignore: prefer_typing_uninitialized_variables
  var selectedTransactionType;

  @override
  void initState() {
    super.initState();
    newTransaction = widget.transaction;
    _selectedDate = newTransaction.dateTime;
    _dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    selectedTransactionType = newTransaction.type;
  }

  bool editable = false;
  bool _isLoading = false;
  final _form = GlobalKey<FormState>();

  Widget topBar = const Text("Invoice ");
  String forSnack = "";
  save() {
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();
    Provider.of<StocksProvider>(context, listen: false)
        .editTransaction(widget.stockId, newTransaction);
    forSnack = "Transaction edited successfuly";
    editable = false;
    showSnackBar(context, forSnack);
    Navigator.of(context).pop();
    setState(() {
      _isLoading = false;
    });
  }

  void cancel() {
    setState(() {
      editable = false;
    });
  }

  void edit() {
    setState(() {
      editable = true;
    });
  }

  @override
  void dispose() {
    _invoiceFocusNode.dispose();
    _qtyFocusNode.dispose();
    _priceFocusNode.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ))
        : Scaffold(
            endDrawer: const AppDrawer(),
            body: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  MyAppBar(
                      title: "${widget.code} - ${widget.name}", topBar: topBar),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 05),
                    child: Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          !editable
                              ? AppButton(title: " Edit", onTap: edit)
                              : const Divider(),
                          //Invoice number input field
                          TextFormField(
                              initialValue: ("${newTransaction.invoiceNumber}"),
                              enabled: editable,
                              decoration: const InputDecoration(
                                  labelText: 'Invoice Number',
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              focusNode: _invoiceFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus();
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Invoice.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                newTransaction = Transaction(
                                  id: newTransaction.id,
                                  type: newTransaction.type,
                                  quantity: newTransaction.quantity,
                                  invoiceNumber: int.parse(value!),
                                  dateTime: newTransaction.dateTime,
                                  price: newTransaction.price,
                                );
                              }),

                          //Date Purchased

                          TextFormField(
                            enabled: editable,
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
                                  .requestFocus(_qtyFocusNode);
                            },
                            onSaved: (value) {
                              newTransaction = Transaction(
                                id: newTransaction.id,
                                type: newTransaction.type,
                                quantity: newTransaction.quantity,
                                invoiceNumber: newTransaction.invoiceNumber,
                                dateTime: DateTime.parse(value!),
                                price: newTransaction.price,
                              );
                            },
                          ),
                          // MyTextField(
                          //   label: "Time",
                          //   controller: _datePurT,
                          //   editable: editable,
                          // ),

                          // Quantity field
                          TextFormField(
                              initialValue: ("${newTransaction.quantity}"),
                              enabled: editable,
                              decoration: const InputDecoration(
                                  labelText: 'Quantity',
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              focusNode: _qtyFocusNode,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_priceFocusNode);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a quantity.';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                newTransaction = Transaction(
                                  id: newTransaction.id,
                                  type: newTransaction.type,
                                  quantity: int.parse(value!),
                                  invoiceNumber: newTransaction.invoiceNumber,
                                  dateTime: newTransaction.dateTime,
                                  price: newTransaction.price,
                                );
                              }),

                          // unit price
                          TextFormField(
                              initialValue: ("${newTransaction.price}"),
                              enabled: editable,
                              decoration: const InputDecoration(
                                  labelText: 'Unit Price',
                                  labelStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  )),
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              focusNode: _priceFocusNode,
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
                                newTransaction = Transaction(
                                  id: newTransaction.id,
                                  type: newTransaction.type,
                                  quantity: newTransaction.quantity,
                                  invoiceNumber: newTransaction.invoiceNumber,
                                  dateTime: newTransaction.dateTime,
                                  price: double.parse(value!),
                                );
                              }),
                          DropdownButtonFormField(
                            value: selectedTransactionType,
                            items: TransactionType.values.map((type) {
                              return DropdownMenuItem(
                                enabled: editable,
                                value: type,
                                child: Text(type.toString()),
                              );
                            }).toList(),
                            onChanged: editable
                                ? (value) {
                                    setState(() {
                                      selectedTransactionType = value!;
                                    });
                                    newTransaction = Transaction(
                                      id: newTransaction.id,
                                      type: selectedTransactionType,
                                      quantity: newTransaction.quantity,
                                      invoiceNumber:
                                          newTransaction.invoiceNumber,
                                      dateTime: newTransaction.dateTime,
                                      price: newTransaction.price,
                                    );
                                  }
                                : null,
                          ),

                          TextFormField(
                            initialValue: ("${newTransaction.total}"),
                            enabled: false,
                            decoration: const InputDecoration(
                                labelText: 'Total',
                                labelStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                )),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _invoiceFocusNode,
                            // onFieldSubmitted: (_) {
                            //   FocusScope.of(context).requestFocus(_nameFocusNode);
                            // },
                          ),
                          editable
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppButton(
                                      title: "Cancel",
                                      onTap: cancel,
                                    ),
                                    AppButton(
                                      title: "Save",
                                      onTap: save,
                                    ),
                                  ],
                                )
                              : const Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
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
