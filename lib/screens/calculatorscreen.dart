import 'package:bank_loan/api/constant.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  static const routName = 'calculator-screen';
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 50,bottom: 50),
              child: Text("Loan Calculator")),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
