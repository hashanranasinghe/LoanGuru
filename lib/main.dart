import 'package:bank_loan/screens/calculatorscreen.dart';
import 'package:bank_loan/screens/filter_screen.dart';
import 'package:bank_loan/screens/forgetpasswordscreen.dart';
import 'package:bank_loan/screens/home_screen.dart';
import 'package:bank_loan/screens/loan_screen.dart';
import 'package:bank_loan/screens/loancategory_screen.dart';
import 'package:bank_loan/screens/login_screen.dart';
import 'package:bank_loan/screens/messagescreen.dart';
import 'package:bank_loan/screens/morescreen.dart';
import 'package:bank_loan/screens/profile_screen.dart';
import 'package:bank_loan/screens/signup_screen.dart';
import 'package:bank_loan/screens/splash_screen.dart';
import 'package:bank_loan/screens/verificationscreen.dart';
import 'package:bank_loan/widgets/bottom_navigationbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const routeName = 'nav bar';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Poppins"),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        MessageScreen.routName: (ctx) => const MessageScreen(),
        CalculatorScreen.routName: (ctx) => const CalculatorScreen(),
        MoreScreen.routName: (ctx) => const MoreScreen(),
        BottomNavigation.routName: (ctx) => const BottomNavigation(),
        SignupScreen.routName: (ctx) => const SignupScreen(),
        LoginScreen.routName: (ctx) => const LoginScreen(),
        HomeScreen.routName: (ctx) => const HomeScreen(),
        VerificationEmailScreen.routeName: (ctx) =>
            const VerificationEmailScreen(),
        SplashScreen.routName: (ctx) => const SplashScreen(),
        ForgetPasswordScreen.routeName: (ctx) => ForgetPasswordScreen(),
        FilterScreen.routName: (ctx) => FilterScreen(),
        ProfileScreen.routName: (ctx) => ProfileScreen(),
      },
    );
  }
}
