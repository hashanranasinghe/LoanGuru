import 'dart:ffi';
import 'dart:math';

import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/api/validator.dart';
import 'package:bank_loan/widgets/button.dart';
import 'package:bank_loan/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  static const routName = 'calculator-screen';
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double? monthlyPay;
  double? totalInterest;
  double? totalAmount;
  double? monthlyPayment;
  final _form = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController interestController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 10),
                  child: Text(
                    "Loan Calculator",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 480,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildAmount(),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                "Interest",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            InputField(
                              function: Validator.interest,
                              controller: interestController,
                              textInputType: TextInputType.number,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                "Loan repayment period",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 175,
                                  child: InputField(
                                    function: Validator.year,
                                    text: "Years",
                                    controller: yearController,
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  width: 175,
                                  child: InputField(
                                    text: "Months",
                                    function: Validator.month,
                                    controller: monthController,
                                    textInputType: TextInputType.number,
                                  ),
                                )
                              ],
                            ),
                            ButtonField(
                                function: () {
                                  if (_form.currentState!.validate()) {
                                    calculation(
                                        double.parse(amountController.text),
                                        double.parse(interestController.text),
                                        int.parse(yearController.text),
                                        int.parse(monthController.text));
                                  }
                                },
                                text: "Calculate"),
                            ButtonField(function: () {}, text: "Reset")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 20),
                                  child: Text(
                                    "Monthly payment",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 20,right: 20),
                                  child: Text(
                                    (monthlyPay!=null)
                                        ? monthlyPay!.toStringAsFixed(2)
                                        : "",

                                    style: TextStyle(

                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 30, top: 20),
                                    child: Text(
                                      "Total Interest",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 20, right: 20),
                                  child: Text(
                                      (totalInterest !=null)?
                                      totalInterest!.toStringAsFixed(2):"",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                                Padding(
                                    padding: EdgeInsets.only(left: 30, top: 20),
                                    child: Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(left: 30, top: 20,right: 20),
                                    child: Text(
                                        (totalAmount!=null)?
                                        totalAmount!.toStringAsFixed(2):"",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Loan Amount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        InputField(
          controller: amountController,
          textInputType: TextInputType.number,
          function: Validator.amount,
        ),
      ],
    );
  }

  double calculation(principalAmount, interest, years, months) {
    double monthlyInterest = (interest / 12 / 100);
    int totalMonths = (years * 12) + months;
    double result = (principalAmount *
            monthlyInterest *
            (pow((1 + monthlyInterest), totalMonths))) /
        (pow((1 + monthlyInterest), totalMonths) - 1);
    setState(() {
      monthlyPay = result;
      totalInterest = (result * totalMonths)-principalAmount;
      totalAmount = (totalInterest! + principalAmount);
    });
    print(result);
    return result;
  }
}
