import 'package:bank_loan/screens/loan_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/card.dart';

class HomeScreen extends StatefulWidget {
  static const routName = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,

      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardView(
                    text: "assets/images/pblogo.png",
                      topic: "People's bank",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoanScreen(
                                text: "People’s bank"
                              ),
                            ));

                      }),
                  CardView(
                      text: "assets/images/com.png",
                      topic: "COM Bank",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoanScreen(
                                  text: "com bank"
                              ),
                            ));
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardView(
                      text: "assets/images/sampath.png",
                      topic: "Sampath Bank",
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoanScreen(
                                  text: "Sampath bank"
                              ),
                            ));
                      }),
                  // CardView(
                  //     text: "assets/images/boc.png",
                  //     topic: "NDB",
                  //     function: () {
                  //     }),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CardView(
              //         text: "assets/images/boc.png",
              //         topic: "COM bank",
              //         function: () {
              //         }),
              //     CardView(
              //         text: "assets/images/boc.png",
              //         topic: "BOC",
              //         function: () {
              //         }),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CardView(
              //         text: "assets/images/boc.png",
              //         topic: "NSB",
              //         function: () {
              //
              //         }),
              //     CardView(
              //         text: "assets/images/boc.png",
              //         topic: "HNB",
              //         function: () {
              //
              //         }),
              //   ],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CardView(
              //         text: "assets/images/boc.png",
              //         topic: "Nation Trust Bank",
              //         function: () {
              //
              //         }),
              //
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
