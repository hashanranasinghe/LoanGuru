import 'package:bank_loan/api/bankapi.dart';
import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/screens/loancategory_screen.dart';
import 'package:flutter/material.dart';

import '../models/loans.dart';
import '../widgets/loan_card_field.dart';

class LoanScreen extends StatefulWidget {
  static const routName = 'loan-screen';
  final String text;
  const LoanScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("${widget.text}"),
      ),
      body: FutureBuilder(
        future: BankApi.ReadJsonData(widget.text),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              var items = snapshot.data as List<Bank>;
              return buildLoans(items);
          }
        },
      ),
    );
  }

  Widget buildLoans(items) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
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
                          builder: (context) => LoanCategoryScreen(
                            text: items[index].loanCategory.toString(),
                          ),
                        ));
                  });
            },
          ),
        ],
      ),
    );
  }
}
