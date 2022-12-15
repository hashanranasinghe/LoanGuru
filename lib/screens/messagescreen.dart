import 'package:bank_loan/models/message.dart';
import 'package:bank_loan/widgets/input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../api/constant.dart';
import '../widgets/message_field.dart';

class MessageScreen extends StatefulWidget {
  static const routName = 'message-screen';
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _auth = FirebaseAuth.instance;
  List<Object> _msgList = [];
  String? uid;
  TextEditingController msgController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getMsg();
  }

  final Stream<QuerySnapshot> _msgStream = FirebaseFirestore.instance
      .collection('message')
      .doc()
      .collection('nodes')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.8,
            child: TextFormField(
              controller: msgController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Message",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFCE0326), width: 2.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color(0xFFE3E3E3FF), width: 1.0),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                sendMsg(msgController.text);
              },
              child: Icon(
                Icons.send,
                size: 35,
                color: primaryColor,
              )),
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Admin",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.01),
              child: Container(
                height: MediaQuery.of(context).size.height - size.height * 0.23,
                child: StreamBuilder<List>(
                    stream: getReceiverChats(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List? dataList = snapshot.data;
                        if (dataList!.isEmpty) {
                          return Center(
                            child: Text('No results'),
                          );
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return MsgField(
                                message: dataList[index] as Message,
                                index: index,
                              );
                            });
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Lottie.asset("assets/anime/no.json",
                                repeat: true),
                          );
                        }
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<Message>> getReceiverChats() {
    User? user = _auth.currentUser;
    return FirebaseFirestore.instance
        .collection("message")
        .doc(user!.uid)
        .collection("nodes")
        .orderBy("time", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Message> dataList = [];
      query.docs.forEach((doc) {
        dataList.add(Message.fromMap(doc));
      });
      return dataList;
    });
  }

  Future<String> sendMsg(msg) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    Message message = Message();
    message.receiver = "sKl0QSbufsfFOGWF8KWMD418AnI2";
    message.sender = user!.uid;
    message.msg = msg;
    message.time;

    firebaseFirestore
        .collection("message")
        .doc(user.uid)
        .collection('nodes')
        .doc()
        .set(message.toMap());

    msgController.clear();
    return "success";
  }

  Future getMsg() async {
    User? user = _auth.currentUser;

    setState(() {
      uid = user!.uid;
    });

    var data = await FirebaseFirestore.instance
        .collection('message')
        .doc(user?.uid)
        .collection("nodes")
        .orderBy('time', descending: false)
        .get();

    setState(() {
      _msgList = List.from(data.docs.map((doc) => Message.fromMap(doc)));
      print(uid);
    });
  }
}
