import 'package:bank_loan/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/constant.dart';
import '../api/validator.dart';
import '../widgets/input_field.dart';

class ProfileScreen extends StatefulWidget {
  static const routName = 'profile-screen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final userCollection = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();

  String? detailFName;
  String? detailSName;
  String? detailLName;
  String? detailEmail;
  String? detailPhoneNum;
  String? detailAddress;
  String? detailIdNum;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoading == true
              ? Column(
            children: [
              Text(
                'My Profile',
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontFamily: 'InriaSans',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              _buildFName(),
              _buildSName(),
              _buildLName(),
              _buildPhoneNum(),
              _buildAddress(),
              _buildIdNum(),
              _buildEmail(),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextButton(
                    onPressed: () async {
                      updateUserInfo(
                          fNameController.text,
                          sNameController.text,
                          lNameController.text,
                          emailController.text,
                          phoneNumberController.text,
                          idNumberController.text,
                          addressController.text);

                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Update',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'InriaSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            )),
                        backgroundColor:
                        MaterialStateProperty.all(primaryColor))),
              ),
            ],
          )
              : Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ],
              ))
        ],

      ),
    );
  }
  Widget _buildFName() {
    return InputField(
        text: 'Full Name',
        iconData: Icons.face,
        function: Validator.nameValidate,
        controller: fNameController..text = detailFName!,
        textInputType: TextInputType.name);
  }
  Widget _buildSName() {
    return InputField(
        text: 'Full Name',
        iconData: Icons.face,
        function: Validator.nameValidate,
        controller: sNameController..text = detailSName!,
        textInputType: TextInputType.name);
  }
  Widget _buildLName() {
    return InputField(
        text: 'Full Name',
        iconData: Icons.face,
        function: Validator.nameValidate,
        controller: lNameController..text = detailLName!,
        textInputType: TextInputType.name);
  }
  Widget _buildEmail() {
    return InputField(
      iconData: Icons.email_rounded,
      controller: emailController..text = detailEmail!,
      text: 'User email',
      detail: detailEmail,
      textInputType: TextInputType.emailAddress,
      function: Validator.emailValidate,
    );
  }

  Widget _buildPhoneNum() {
    return InputField(
      iconData: Icons.phone,
      controller: phoneNumberController..text = detailPhoneNum!,
      text: 'Phone Number',
      detail: detailPhoneNum,
      textInputType: TextInputType.number,
      function: Validator.phoneNumber,
    );
  }

  Widget _buildAddress() {
    return InputField(
      iconData: Icons.home,
      controller: addressController..text = detailAddress!,
      text: 'Address',
      detail: detailAddress,
      textInputType: TextInputType.streetAddress,
      function: Validator.nameValidate,
    );
  }

  Widget _buildIdNum() {
    return InputField(
      iconData: Icons.numbers_outlined,
      controller: idNumberController..text = detailIdNum!,
      text: 'Id Number',
      detail: detailIdNum,
      textInputType: TextInputType.number,
      function: Validator.nicValidate,
    );
  }

  Future getCurrentUser() async {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    DocumentSnapshot documentSnapshot = await userCollection.doc(uid).get();
    String firstName = documentSnapshot.get('fName');
    String secondName = documentSnapshot.get('fName');
    String lastName = documentSnapshot.get('fName');
    String email = documentSnapshot.get('email');
    String address = documentSnapshot.get('address');
    String phoneNumber = documentSnapshot.get('number');
    String idNumber = documentSnapshot.get('idNumber');

    setState(() {
      detailFName = firstName;
      detailSName = secondName;
      detailLName = lastName;
      detailEmail = email;
      detailPhoneNum = phoneNumber;
      detailAddress = address;
      detailIdNum = idNumber;

      isLoading = true;
    });
    print(detailEmail);
    return [firstName, email];
  }
  Future updateUserInfo(String fName,String sName,String lName, String email, String phoneNum,
      String idNum, String address) async {
    User? user = _auth.currentUser;
    final uid = user!.uid;
    return await userCollection.doc(uid).set({
      'id': uid,
      'fName': fName,
      'sName': sName,
      'lName': lName,
      'email': email,
      'address': address,
      'number': phoneNum,
      'idNumber': idNum,
    }).whenComplete(() => Fluttertoast.showToast(msg: "uploaded successfully.")
        .whenComplete(() => Navigator.of(context)
        .pushReplacementNamed(ProfileScreen.routName)));
  }
}
