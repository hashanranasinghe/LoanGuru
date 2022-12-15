import 'package:bank_loan/screens/loandetails_screen.dart';
import 'package:bank_loan/widgets/expansion_details.dart';
import 'package:bank_loan/widgets/loan_card_field.dart';
import 'package:flutter/material.dart';
import '../api/bankapi.dart';
import '../api/constant.dart';
import '../models/loans.dart';

class LoanCategoryScreen extends StatefulWidget {
  final String text;
  const LoanCategoryScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<LoanCategoryScreen> createState() => _LoanCategoryScreenState();
}

class _LoanCategoryScreenState extends State<LoanCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Category"),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder(
        future: BankApi.ReadData(widget.text),
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
                    ListView.builder(
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
                                    builder: (context) => LoanDetailsScreen(
                                      text: items[index].loanName.toString(),
                                    ),
                                  ));
                            });
                      },
                    ),
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
