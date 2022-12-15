import 'dart:math';

import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/api/validator.dart';
import 'package:bank_loan/widgets/button.dart';
import 'package:bank_loan/widgets/input_field.dart';
import 'package:bank_loan/widgets/input_field_cal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculatorScreen extends StatefulWidget {
  static const routName = 'calculator-screen';
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {

  NumberFormat myFormat = NumberFormat.currency(locale: 'en-us',name: "Rs.");
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: size.width*0.1, bottom: size.height*0.01),
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
                      padding: EdgeInsets.symmetric(vertical: size.height*0.05,horizontal: size.height*0.01),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: size.height*0.5,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildAmount(),
                            Padding(
                              padding: EdgeInsets.only(left: size.width*0.06),
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
                              padding: EdgeInsets.only(left:size.width*0.06 ),
                              child: Text(
                                "Loan repayment period",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: size.width*0.44,
                                  child: InputField(
                                    function: Validator.year,
                                    text: "Years",
                                    controller: yearController,
                                    textInputType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  width: size.width*0.44,
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
                                  print(amountController.text.substring(4).replaceAll(',',''));
                                  if (_form.currentState!.validate()) {
                                    calculation(
                                        double.parse(amountController.text.substring(4).replaceAll(',','')),
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
                      padding: EdgeInsets.symmetric(vertical: size.height*0.03,horizontal: size.width*0.05),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: size.height*0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: size.height*0.01,horizontal: size.width*0.01),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Monthly payment",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      (monthlyPay!=null)
                                          ? myFormat.format((monthlyPay))
                                          : "",

                                      style: TextStyle(

                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total Interest",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        (totalInterest !=null)?
                                        myFormat.format(totalInterest):"",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        (totalAmount!=null)?
                                        myFormat.format(totalAmount):"",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
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
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: size.width*0.06),
            child: Text(
              "Loan Amount",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        InputCalField(
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

    return result;
  }
}
