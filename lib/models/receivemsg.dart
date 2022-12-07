class ReceiveMessage{
  String? uid;
  String? receiveMsg;

  ReceiveMessage({
    this.uid,
    this.receiveMsg
  });

  factory ReceiveMessage.fromMap(map) {
    return ReceiveMessage(
        uid: map['uid'],
        receiveMsg: map['receiveMsg']
    );}

  Map<String, dynamic> toMap() {
    return {
      'uid':uid,
      'receiveMsg':receiveMsg
    };

  }


}