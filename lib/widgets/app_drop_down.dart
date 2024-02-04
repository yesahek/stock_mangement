// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_mangement/models/item.dart';
import 'package:stock_mangement/models/stock.dart';

import '../util/colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final Item bTax;
  final Item sells;
  final List<Stock> Foundstocks;
  final Stock value;
  final Stock Function(Stock) displayFunction;
  final void Function(Stock) onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.bTax,
    required this.sells,
    required this.Foundstocks,
    required this.value,
    required this.displayFunction,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: _toggleDropdown,
          child: ListTile(
            leading: const Icon(
              Icons.spa,
              size: 40,
            ),
            title: Text(
              widget.value.name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: appColor,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  widget.value.id,
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
            trailing: const Column(children: [
              Text("ST Margin : 10%"),
              Text("profit  : 08%"),
            ]),
          ),

          // InputDecorator(
          //   decoration: const InputDecoration(
          //     border: OutlineInputBorder(),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(widget.displayFunction(widget.value!)),
          //       Icon(_isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
          //     ],
          //   ),
          // ),
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
