import 'package:bank_loan/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(widget.message.msg.toString()),
    );
  }
}
