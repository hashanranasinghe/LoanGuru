class CreateAccount {
  String? id;
  String? fName;
  String? sName;
  String? lName;
  String? number;
  String? address;
  String? idNumber;
  String? email;

  CreateAccount(
      {this.id,
      this.fName,
      this.sName,
      this.lName,
      this.number,
      this.address,
      this.idNumber,
      this.email});

  factory CreateAccount.fromMap(map) {
    return CreateAccount(
        id: map['id'],
        fName: map['fName'],
        sName: map['sName'],
        lName: map['lName'],
        number: map['number'],
        address: map['address'],
        idNumber: map['idNumber'],
        email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fName': fName,
      'sName': sName,
      'lName': lName,
      'number': number,
      'address': address,
      'idNumber': idNumber,
      'email': email
    };
  }
}
