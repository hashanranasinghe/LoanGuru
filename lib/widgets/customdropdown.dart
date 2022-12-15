import 'package:flutter/material.dart';

import '../api/constant.dart';

class CustomDropDown extends StatefulWidget {
  final List<DropdownMenuItem<String>> valueList;
  final String? text;
  final String hint;
  final Function(String)? validator;
  final Function(String?)? function;
  const CustomDropDown(
      {Key? key,
      required this.valueList,
      this.text,
      this.function,
      required this.hint,
      this.validator})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.01),
      width: size.width * 0.74,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.width * 0.02),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          validator: (value) {
            widget.validator!(value!);
            return null;
          },
          decoration: InputDecoration(border: InputBorder.none),
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
