import 'package:bank_loan/widgets/loan_card_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../api/bankapi.dart';
import '../api/constant.dart';
import '../models/loans.dart';
import 'loandetails_screen.dart';

class SuggestionScreen extends StatefulWidget {
  final String value;
  final String lValue;
  final String yValue;
  final String jobPosition;
  final String ineterestRate;
  const SuggestionScreen(
      {Key? key,
      required this.value,
      required this.lValue,
      required this.yValue,
      required this.jobPosition,
      required this.ineterestRate})
      : super(key: key);

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Suitable loans for You"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: BankApi.ReadFilterData(
              widget.value,
              widget.lValue,
              widget.yValue,
              widget.jobPosition,
              widget.ineterestRate.toString()),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                var items = snapshot.data as List<Bank>;
                return Padding(
                  padding: EdgeInsets.only(top: size.height * 0.02),
                  child: Column(
                    children: [
                      !items.isEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return LoanCardField(
                                    text: items[index].loanName.toString(),
                                    function: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoanDetailsScreen(
                                              text: items[index]
                                                  .loanName
                                                  .toString(),
                                            ),
                                          ));
                                    });
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/anime/no.json",
                                  repeat: true,
                                ),
                              ],
                            )
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
