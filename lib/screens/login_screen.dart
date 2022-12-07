import 'package:bank_loan/screens/forgetpasswordscreen.dart';
import 'package:bank_loan/screens/home_screen.dart';
import 'package:bank_loan/widgets/bottom_navigationbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/constant.dart';
import '../api/validator.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';
import '../widgets/input_password.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routName = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                "Welcome back!",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5, top: 5),
              child: Text(
                "Login to your account",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 20,
                ),
              ),
            ),
            _buildEmail(),
            _buildPassword(),
            _buildLoginButton(),
            _buildForgetPassword(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account ?",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'InriaSans',
                        fontWeight: FontWeight.bold)),
                TextButton(
                  child: const Text('Sign up',
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold,
                      )),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(SignupScreen.routName);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildEmail() {
    return InputField(
        iconData: Icons.email_rounded,
        controller: emailController,
        textInputType: TextInputType.emailAddress,
        text: "Email",
        function: Validator.emailValidate
    );
  }

  Widget _buildPassword() {
    return InputPasswordField(
      textEditingController: passwordController,
      text: "Password",
      function: Validator.passwordValidate,
    );
  }

  Widget _buildLoginButton() {
    return ButtonField(
        function: () async {
          final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
          sharedPreferences.setString('email', emailController.text);
          signIn(emailController.text, passwordController.text);
        },
        text: "Sign In");
  }

  Widget _buildForgetPassword(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 40),
      child: TextButton(
        child: Text(
          'Forget your Password?',
          style: TextStyle(
              fontFamily: 'InriaSans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor),
        ),
        onPressed: () {
          Navigator.of(context)
              .pushReplacementNamed(ForgetPasswordScreen.routeName);
        },
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    if (_form.currentState!.validate()) {
      print(email);
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successfully"),
            Navigator.of(context)
                .pushReplacementNamed(BottomNavigation.routName),

      })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: 'Incorrect Email or Password.',
            toastLength: Toast.LENGTH_LONG);
      });
    }
  }
}
