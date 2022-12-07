import 'package:bank_loan/api/constant.dart';
import 'package:flutter/material.dart';


class CardView extends StatelessWidget {
  const CardView(
      {Key? key, required this.topic,required this.function, this.text})
      : super(key: key);

  final String topic;
  final String? text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,top: 30),
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Center(
          child: Card(
            elevation: 8,
            color: Colors.white,
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Column(
                      children: [
                        Text(
                          topic,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Image.asset(
                            text!,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
