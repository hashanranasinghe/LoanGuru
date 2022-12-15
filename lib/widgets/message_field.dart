import 'package:bank_loan/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/constant.dart';

class MsgField extends StatefulWidget {
  final Message message;
  final index;
  MsgField({Key? key, required this.message, this.index}) : super(key: key);

  @override
  State<MsgField> createState() => _MsgFieldState();
}

class _MsgFieldState extends State<MsgField> {

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.message.sender != "sKl0QSbufsfFOGWF8KWMD418AnI2") {
      return Padding(
        padding: const EdgeInsets.only(left: 150),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))),
          color: primaryColor,
          margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03, bottom: size.height*0.02),
          elevation: 4,
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: size.height*0.01, left: size.width*0.04, right: size.width*0.04, bottom: size.height*0.01),
            title: Text(
              widget.message.msg.toString(),
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(right: 150),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15))),
          color: Colors.white70,
          margin: EdgeInsets.only(left: size.width*0.03, right: size.width*0.03, bottom: size.height*0.02),
          elevation: 4,
          child: ListTile(
            contentPadding:
                EdgeInsets.only(top: size.height*0.01, left: size.width*0.04, right: size.width*0.04, bottom: size.height*0.01),
            title: Text(
              widget.message.msg.toString(),
              style: TextStyle(),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      );
    }
  }
}
