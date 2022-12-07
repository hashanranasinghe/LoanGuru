import 'package:flutter/material.dart';

import '../api/constant.dart';

class CustomDropDown extends StatefulWidget {
  final List<DropdownMenuItem<String>> valueList;
  final String? text;
  final String hint;
  final Function(String?)? function;
  const CustomDropDown(
      {Key? key, required this.valueList, this.text, this.function, required this.hint})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      width: 300,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(widget.hint),
          isExpanded: true,
          iconSize: 36,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          value: widget.text,
          items: widget.valueList,
          onChanged: (value) {
            widget.function!(value!);
          },
        ),
      ),
    );
  }
}
