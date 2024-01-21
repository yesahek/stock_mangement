import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_mangement/providers/stocks_provider.dart';
import 'package:stock_mangement/util/colors.dart';
import 'package:stock_mangement/util/util.dart';
import 'package:stock_mangement/widgets/app_drawer.dart';

import '../models/stock.dart';
import '../widgets/app_button.dart';

class AddNewStocksScreen extends StatefulWidget {
  const AddNewStocksScreen({super.key});
  static const routeName = "/AddNewStocksScreen";

  @override
  State<AddNewStocksScreen> createState() => _AddNewStocksScreenState();
}

class _AddNewStocksScreenState extends State<AddNewStocksScreen> {
  var _newStock = Stock(
    id: "00",
    code: 00,
    name: "",
    datePurchased: DateTime.now(),
    dateRegistored: DateTime.now(),
    costPrice: 00.01,
    sellingPrice: 0.01,
    packageType: "",
    transactions: [],
  );
  final _initValues = {
    'code': '',
    'name': '',
    'dateRegistored': '',
    'costPrice': '',
    'sellingPrice': '',
    'packageType': '',
    'Quantity': '',
  };

  final _codeFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _datePFocusNode = FocusNode();
  final _costPFocusNode = FocusNode();
  final _sellPFocusNode = FocusNode();
  final _pkgTFocusNode = FocusNode();
  final _quatntityFocusNode = FocusNode();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  final _form = GlobalKey<FormState>();

  bool _isLoading = false;

 
  void _save() {
    //print("Save Button\n $code $costP, $dateP,$name, $pkgType,$sellingP,");
    String forSnack = "";
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();
    Provider.of<StocksProvider>(context, listen: false).addStock(_newStock);
    forSnack = "Stock Added successfuly";

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
    _codeFocusNode.dispose();
    _nameFocusNode.dispose();
    _datePFocusNode.dispose();
    _costPFocusNode.dispose();
    _sellPFocusNode.dispose();
    _pkgTFocusNode.dispose();
    _quatntityFocusNode.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.blueAccent,
          ))
        : Scaffold(
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
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      //Code input field
                      TextFormField(
                          initialValue: _initValues['code'],
                          decoration:
                              const InputDecoration(labelText: 'Stock Code'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _codeFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_nameFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newStock = Stock(
                              id: _newStock.id,
                              code: int.parse(value!),
                              name: _newStock.name,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: _newStock.sellingPrice,
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
                             
                            );
                          }),

                      //Name input field
                      TextFormField(
                          initialValue: _initValues['name'],
                          decoration:
                              const InputDecoration(labelText: 'Stock Name'),
                          textInputAction: TextInputAction.next,
                          //keyboardType: TextInputType.number,
                          focusNode: _nameFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_datePFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name.';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: value!,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: _newStock.sellingPrice,
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
                            );
                          }),
//Date Input field
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
                            FocusScope.of(context).requestFocus(_codeFocusNode);
                          },
                          onSaved: (value) {
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: _newStock.name,
                              datePurchased: DateTime.parse(value!),
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: _newStock.sellingPrice,
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
                            );
                          }),

                      TextFormField(
                          initialValue: _initValues['costPrice'],
                          decoration:
                              const InputDecoration(labelText: 'Cost Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _costPFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_sellPFocusNode);
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
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: _newStock.name,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: double.parse(value!),
                              sellingPrice: _newStock.sellingPrice,
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
                            );
                          }),

                      TextFormField(
                          initialValue: _initValues['selling price'],
                          decoration:
                              const InputDecoration(labelText: 'Selling Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _sellPFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_pkgTFocusNode);
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
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: _newStock.name,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: double.parse(value!),
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
                            );
                          }),

                      TextFormField(
                          initialValue: _initValues['packageType'],
                          decoration:
                              const InputDecoration(labelText: 'Package Type'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: _pkgTFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_quatntityFocusNode);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Package type.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: _newStock.name,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: _newStock.sellingPrice,
                              packageType: value!,
                              transactions: _newStock.transactions,
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
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter a quantity.';
                            // }
                            if (int.tryParse(value!) == null) {
                              return 'Please enter a valid number.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newStock = Stock(
                              id: _newStock.id,
                              code: _newStock.code,
                              name: _newStock.name,
                              datePurchased: _newStock.datePurchased,
                              dateRegistored: _newStock.dateRegistored,
                              costPrice: _newStock.costPrice,
                              sellingPrice: _newStock.sellingPrice,
                              packageType: _newStock.packageType,
                              transactions: _newStock.transactions,
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
