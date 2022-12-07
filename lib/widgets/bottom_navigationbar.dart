

import 'package:bank_loan/screens/filter_screen.dart';
import 'package:bank_loan/screens/home_screen.dart';
import 'package:bank_loan/screens/loan_screen.dart';
import 'package:bank_loan/screens/morescreen.dart';
import 'package:bank_loan/screens/profile_screen.dart';
import 'package:bank_loan/screens/sendmessage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../api/constant.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routName = 'nav-screen';

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int index = 1;
  final screens = [
    const FilterScreen(),
    const HomeScreen(),
    const MoreScreen(),
    const SendMessageScreen(),
  ];
  final items = <Widget>[
    Icon(
      Icons.filter_alt_outlined,
      size: 30,
    ),
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(
      Icons.more_vert_outlined,
      size: 30,
    ),
    // Icon(
    //   Icons.message_outlined,
    //   size: 30,
    // ),
  ];
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Scaffold(
        extendBody: true,
        body: screens[index],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white)
          ),
          child: CurvedNavigationBar(
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            color: primaryColor,
            backgroundColor: Colors.transparent,
            index: index,
            height: 60,
            items: items,
            onTap: (index) {
              setState(() => this.index = index);
            },
          ),
        ),
      ),
    );
  }
}
