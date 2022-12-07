class Message{
  String? uid;
  String? msg;

  Message({
   this.uid,
   this.msg
});

  factory Message.fromMap(map) {
    return Message(
      uid: map['uid'],
      msg: map['msg']
    );}

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'msg':msg
    };

    }


}