import 'package:bank_loan/screens/calculatorscreen.dart';
import 'package:bank_loan/screens/messagescreen.dart';
import 'package:bank_loan/screens/profile_screen.dart';
import 'package:bank_loan/widgets/more_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/constant.dart';
import 'login_screen.dart';

class MoreScreen extends StatefulWidget {
  static const routName = 'more-screen';
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          MoreWidget(
              text: "Profile",
              iconData: Icons.face_outlined,
              function: () {
                Navigator.of(context).pushNamed(ProfileScreen.routName);
              }),
          MoreWidget(
              text: "Loan Calculator",
              iconData: Icons.calculate_outlined,
              function: () {
                Navigator.of(context).pushNamed(CalculatorScreen.routName);
              }),
          MoreWidget(
              text: "Chat with admin",
              iconData: Icons.help_outline,
              function: () {
                Navigator.of(context).pushNamed(MessageScreen.routName);
              }),
          MoreWidget(
              text: "Log Out",
              iconData: Icons.logout_outlined,
              function: () async {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.remove('email');
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routName);
              }),
        ],
      ),
    );
  }
}
