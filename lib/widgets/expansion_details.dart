import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/constant.dart';

class ExpansionDetails extends StatefulWidget {
  final String text;
  final String topic;
  const ExpansionDetails({Key? key, required this.text, required this.topic})
      : super(key: key);

  @override
  State<ExpansionDetails> createState() => _ExpansionDetailsState();
}

class _ExpansionDetailsState extends State<ExpansionDetails> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          widget.topic,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        children: [
          Text(
            widget.text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
        trailing: Icon(
          Icons.add,
          size: 35,
          color: primaryColor,
        ),
        iconColor: Colors.black,
        textColor: primaryColor,
        expandedAlignment: Alignment.centerLeft,
        childrenPadding: EdgeInsets.only(left: 20),
        expandedCrossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
