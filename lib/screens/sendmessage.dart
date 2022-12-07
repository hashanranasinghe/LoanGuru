import 'package:bank_loan/models/message.dart';
import 'package:bank_loan/widgets/input_field.dart';
import 'package:bank_loan/widgets/msgField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendMessageScreen extends StatefulWidget {
  static const routName = 'message-screen';
  const SendMessageScreen({Key? key}) : super(key: key);

  @override
  State<SendMessageScreen> createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final _auth = FirebaseAuth.instance;
  List<Object> _msgList = [];
  TextEditingController msgController = TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getMsg();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          SingleChildScrollView(
            child: Column(

              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _msgList.length,
                    itemBuilder: (context,index){
                      return MsgField(
                        message:_msgList[index] as Message,index: index,
                      );
                    }),

                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: InputField(
                          controller: msgController,
                          textInputType: TextInputType.text),
                    ),
                    TextButton(
                        onPressed: (){
                          User? user = _auth.currentUser;
                          print(user!.uid);
                          sendMsg(user.uid, msgController.text);
                          receiveMsg(user.uid, msgController.text);
                          msgController.clear();
                        }, child: Text('s'))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<String> sendMsg(id,msg) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference users = firebaseFirestore.collection('users');
    Message message = Message();
    message.uid=id;
    message.msg=msg;
    users.doc(id).collection('message').add(message.toMap());
    return "success";
  }
  Future<String> receiveMsg(id,msg) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference users = firebaseFirestore.collection('users');
    Message message = Message();
    message.uid=id;
    message.msg=msg;
    users.doc('sKl0QSbufsfFOGWF8KWMD418AnI2').collection(id).add(message.toMap());
    return 'success';

  }

  Future getMsg() async{
    User? user = _auth.currentUser;
    final uid = user!.uid;
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('message')
        .get();

    setState(() {
      _msgList = List.from(data.docs.map((doc) => Message.fromMap(doc)));
      print(uid);

    });
  }
}
