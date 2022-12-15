import 'dart:convert';
import 'dart:io';

import 'package:bank_loan/api/constant.dart';
import 'package:bank_loan/widgets/expansion_details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;
import '../api/bankapi.dart';
import '../models/loans.dart';

class LoanDetailsScreen extends StatefulWidget {
  final String text;
  const LoanDetailsScreen({Key? key, required this.text}) : super(key: key);

  @override
  State<LoanDetailsScreen> createState() => _LoanDetailsScreenState();
}

class _LoanDetailsScreenState extends State<LoanDetailsScreen> {
  Future<void> _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Error============';
    }
  }

  launchUrl(url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Details"),
        backgroundColor: primaryColor,
      ),
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
                                    subtitle: Text(items[index].bank.toString(),
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
                                          : items[index].loanName.toString(),
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
                                  items[index].link != null
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              top: size.height * 0.01,
                                              bottom: size.height * 0.01),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                _launch(items[index]
                                                    .link
                                                    .toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Apply for loan',
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                  Icon(
                                                    Icons.double_arrow_rounded,
                                                    size: 20,
                                                    color: primaryColor,
                                                  )
                                                ],
                                              ),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0))),
                                        )
                                      : Container(),
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
