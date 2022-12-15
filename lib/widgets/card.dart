import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView(
      {Key? key, required this.topic, required this.function, this.text})
      : super(key: key);

  final String topic;
  final String? text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.02, top: size.height * 0.02),
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
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * 0.02,
                      horizontal: size.width * 0.03),
                  child: Container(
                    width: size.width * 0.38,
                    height: size.height * 0.18,
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
