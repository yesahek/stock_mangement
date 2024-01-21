import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:stock_mangement/models/items.dart';
import 'package:stock_mangement/models/item.dart';
import 'package:stock_mangement/screens/factor_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";
  Color yellow = const Color(0xfff4b41A);

  Color orange = const Color(0xfff49f1c);
  Color blue = const Color(0xff143d59);

  myCal(String buttonText) {
    // contains all the arithmetic logics
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
      } else if (buttonText == "Del") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
      // Update the result in real-time as the equation is being formed
      expression = equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      } catch (e) {
        //   result = "Error";
      }
    });
  }

  myCustomButton(
      {required String buttonText,
      required double buttonHeight,
      required Color buttonColor,
      bool isMember = true}) {
    var hei = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.all(02),
      height: (hei * 0.10) * buttonHeight,
      decoration: BoxDecoration(
        color: buttonColor,
        shape: BoxShape.circle,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: () => isMember ? myCal(buttonText) : generateFactorButton(),
        child: Text(
          buttonText,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Items parseEquation(String equation) {
    // Replace multiplication signs with '*'
    equation = equation.replaceAll('×', '*');
    // Split the equation into parts based on the '+' symbol
    List<String> parts = equation.split('+');
    int number = 1;
    // Initialize the list to store Item objects
    Items items = Items(
      id: "id",
      customerName: "customerName",
      dateTime: DateTime.now(),
      Item: [],
      total: double.parse(result),
      isPaid: true,
      payment: double.parse(result),
      loan: 00.0,
    );
    // Iterate through each part of the equation
    for (String part in parts) {
      // Split each part based on the '*' symbol
      if (!part.contains('*')) {
        part = "1*$part";
      }
      List<String> factors = part.split('*');

      // Extract the quantity and price
      int quantity = int.parse(factors[0].trim());
      double price = double.parse(factors[1].trim());

      // Create and add a new Item to the list
      // items.add(Item(quantity: quantity, price: price));
      items.Item.add(
        Item(
          id: "$number",
          name: "Item $number",
          quantity: quantity,
          price: price,
          total: quantity * price,
        ),
      );
      number++;
    }

    return items;
  }

  generateFactorButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => equation == ""
            ? const SizedBox()
            : FactorScreen(
                itemList: parseEquation(equation),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.90,
      child: Column(
        children: [
          Container(
            height: height * 0.15,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: const TextStyle(fontSize: 35, color: Colors.black),
            ),
          ),
          Container(
            height: height * 0.15,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: const TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: false,
              children: [
                Container(
                  width: width,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .95,
                        child: Table(
                          children: [
                            TableRow(
                              children: [
                                myCustomButton(
                                    buttonText: "C",
                                    buttonHeight: 1,
                                    buttonColor: yellow),
                                myCustomButton(
                                    buttonText: "Del",
                                    buttonHeight: 1,
                                    buttonColor: yellow),
                                myCustomButton(
                                    buttonText: "÷",
                                    buttonHeight: 1,
                                    buttonColor: yellow),
                                myCustomButton(
                                    buttonText: "G",
                                    buttonHeight: 1,
                                    buttonColor: yellow,
                                    isMember: false),
                              ],
                            ),
                            TableRow(children: [
                              myCustomButton(
                                  buttonText: "7",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "9",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "8",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "×",
                                  buttonHeight: 1,
                                  buttonColor: yellow),
                            ]),
                            TableRow(children: [
                              myCustomButton(
                                  buttonText: "4",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "5",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "6",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "-",
                                  buttonHeight: 1,
                                  buttonColor: yellow),
                            ]),
                            TableRow(children: [
                              myCustomButton(
                                  buttonText: "1",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "2",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "3",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "+",
                                  buttonHeight: 1,
                                  buttonColor: yellow),
                            ]),
                            TableRow(children: [
                              myCustomButton(
                                  buttonText: ".",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "0",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "00",
                                  buttonHeight: 1,
                                  buttonColor: blue),
                              myCustomButton(
                                  buttonText: "=",
                                  buttonHeight: 1,
                                  buttonColor: orange),
                            ]),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.15,
                      //   //  height: MediaQuery.of(context).size.height * .85,
                      //   child: Table(
                      //     children: [
                      //       TableRow(children: [
                      //         myCustomButton("×", 1, yellow),
                      //       ]),
                      //       TableRow(children: [
                      //         myCustomButton("-", 1, yellow),
                      //       ]),
                      //       TableRow(children: [
                      //         myCustomButton("+", 1, yellow),
                      //       ]),
                      //       TableRow(children: [
                      //         myCustomButton("=", 2, orange),
                      //       ]),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
