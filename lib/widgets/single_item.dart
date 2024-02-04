// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:stock_mangement/models/stock.dart';
import 'package:stock_mangement/util/colors.dart';

import '../models/item.dart';
import 'app_drop_down.dart';

// ignore: must_be_immutable
class SingleItem extends StatefulWidget {
  final Item bTax;
  final Item item;
  final List<Stock> founStock;

  bool showDetail;
  SingleItem({
    Key? key,
    required this.bTax,
    required this.item,
    required this.founStock,
    required this.showDetail,
  }) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
//  List<Stock> foundStock = [];
  void showDetail() {
    setState(() {
      widget.showDetail = !widget.showDetail;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
    var size = MediaQuery.of(context).size;

    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: appColor, width: 4.0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            15.0,
          ),
          topRight: Radius.circular(15.0),
        ),
      ),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            child: Card(
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: appColor, width: 1.0),
                borderRadius: BorderRadius.zero,
              ),
              color: Colors.white,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomDropdownButton(
                        bTax: widget.bTax,
                        sells: widget.item,
                        Foundstocks: widget.founStock,
                        value: widget.founStock[0],
                        displayFunction: (Stock value) => value,
                        onChanged: (Stock? val) {
                          if (val != null) {
                            int selectedIndex = widget.founStock.indexOf(val);
                            setState(() {
                              // Swap the values at the first position and the selected index
                              Stock temp = widget.founStock[0];
                              widget.founStock[0] =
                                  widget.founStock[selectedIndex];
                              widget.founStock[selectedIndex] = temp;
                            });
                          }
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
