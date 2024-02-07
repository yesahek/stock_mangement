// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_mangement/models/item.dart';
import 'package:stock_mangement/models/stock.dart';

import '../util/colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final Item bTax;
  final Item sells;
  // ignore: non_constant_identifier_names
  final List<Stock> Foundstocks;
  final Stock value;
  final Stock Function(Stock) displayFunction;
  final void Function(Stock) onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.bTax,
    required this.sells,
    // ignore: non_constant_identifier_names
    required this.Foundstocks,
    required this.value,
    required this.displayFunction,
    required this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool _isDropdownOpen = false;
  @override
  Widget build(BuildContext context) {
    double curretnProfit = widget.bTax.price - widget.value.costPrice;
    double currentProfitPercent = curretnProfit / widget.value.costPrice * 100;

    double tempProfit = widget.value
        .calculateTempoProfitPercentage(curretnProfit, widget.sells.quantity);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: _toggleDropdown,
          child: ListTile(
            // leading: const Icon(
            //   Icons.spa,
            //   size: 40,
            // ),
            title: Text(
              widget.value.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Code: ${widget.value.code}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: appColor,
                  ),
                ),
                const VerticalDivider(
                  width: 40,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " ${widget.value.balance} Bal | cos ${widget.value.costPrice} ",
                        style: const TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.sells.quantity} X ${widget.bTax.price}",
                        // "${widget.item.quantity} X ${price}",
                        style: const TextStyle(
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text("ST Profit : ${widget.value.profitPercent} %"),
              Text("profit  : ${currentProfitPercent.toStringAsFixed(2)} %"),
              Text("AfterThis  : ${tempProfit.toStringAsFixed(2)} %"),
            ]),
          ),
        ),
        if (_isDropdownOpen)
          Container(
            constraints: const BoxConstraints(
              maxHeight: 150,
            ),
            child: ListView.builder(
              itemCount: widget.Foundstocks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.Foundstocks[index].name),
                  onTap: () {
                    _selectItem(widget.Foundstocks[index]);
                  },
                );
              },
            ),
          ),
      ],
    );
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  void _selectItem(Stock item) {
    _toggleDropdown();
    widget.onChanged(item);
  }
}
