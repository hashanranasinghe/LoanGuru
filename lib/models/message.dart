import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? sender;
  String? receiver;
  String? msg;
  Timestamp? time;

  Message({this.sender, this.receiver, this.msg, this.time});

  factory Message.fromMap(map) {
    return Message(
        sender: map['sender'],
        receiver: map['receiver'],
        msg: map['msg'],
        time: map['time']);
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'msg': msg,
      'time': FieldValue.serverTimestamp(),
    };
  }
}
