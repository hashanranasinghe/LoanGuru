import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/widgets/expansion_details.dart';
import 'package:flutter/material.dart';
import '../api/bankapi.dart';
import '../models/loans.dart';

class LoanDetailsScreen extends StatefulWidget {
  final String text;
  const LoanDetailsScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: BankApi.ReadDetails(widget.text),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                var items = snapshot.data as List<Bank>;
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: () {},
                                    title: Text(
                                      items[index].loanCategory.toString(),
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    subtitle:
                                        Text(items[index].bank.toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                      text: items[index].loanName == null
                                          ? "N/A"
                                          : items[index]
                                          .loanName
                                          .toString(),
                                      topic: "Loan Name"),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                      text: items[index].interestRate == null
                                          ? "N/A"
                                          : items[index]
                                          .interestRate
                                          .toString(),
                                      topic: "Interest Rate"),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                      text: items[index].targetApplicant == null
                                          ? "N/A"
                                          : items[index]
                                              .targetApplicant
                                              .toString(),
                                      topic: "Target Applicant"),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                    topic: "Loan payment period",
                                    text: items[index].period == null
                                        ? "N/A"
                                        : items[index].period.toString(),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                      text: items[index].guarantor == null
                                          ? "N/A"
                                          : items[index].guarantor.toString(),
                                      topic: "Guarantors"),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                  ExpansionDetails(
                                      text: items[index].specialBenefits == null
                                          ? "N/A"
                                          : items[index]
                                              .specialBenefits
                                              .toString(),
                                      topic: 'Special benefits'),
                                  Divider(
                                    thickness: 2,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
