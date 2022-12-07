import 'package:flutter/material.dart';

import '../api/constant.dart';

class MoreWidget extends StatefulWidget {
  final String text;
  final IconData iconData;
  final Function function;
  const MoreWidget(
      {Key? key,
      required this.text,
      required this.iconData,
      required this.function})
      : super(key: key);

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      color: Colors.white,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
      elevation: 4,
      child: ListTile(
        iconColor: primaryColor,
        trailing: Icon(widget.iconData),
        contentPadding:
            EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
        onTap: () {
          widget.function();
        },
        title: Text(
          widget.text,
          style: TextStyle(color: primaryColor, fontSize: 20),
        ),
      ),
    );
  }
}
