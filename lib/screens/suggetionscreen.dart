import 'package:bank_loan/widgets/loan_card_field.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: BankApi.ReadFilterData(widget.value, widget.lValue, widget.yValue,widget.jobPosition),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                var items = snapshot.data as List<Bank>;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Text("Suitable loans for You",style: TextStyle(
                        fontSize: 30,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,

                      ),),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return LoanCardField(text: items[index].loanName.toString(),
                            function: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoanDetailsScreen(
                                      text: items[index].loanName.toString(),
                                    ),
                                  ));
                            });
                      },
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
