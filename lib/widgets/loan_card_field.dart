import 'package:flutter/material.dart';
import '../api/constant.dart';

class LoanCardField extends StatefulWidget {
  final String text;
  final Function function;
  const LoanCardField({Key? key, required this.text, required this.function}) : super(key: key);

  @override
  State<LoanCardField> createState() => _LoanCardFieldState();
}

class _LoanCardFieldState extends State<LoanCardField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
      color: primaryColor,
      margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
      elevation: 4,
      child: ListTile(
        iconColor: Colors.white,
        trailing: Icon(Icons.arrow_forward_ios_sharp),
        contentPadding: EdgeInsets.only(top: 15,left: 20,right: 20,bottom: 15),

        onTap: () {
          widget.function();
        },
        title: Text(widget.text,style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),),
      ),
    );
  }
}
