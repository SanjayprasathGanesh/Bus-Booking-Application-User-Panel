class UserModel{
  String? uEmail;
  String? name;
  String? phoneNum;
  String? gender;
  String? dob;
  int? age;
  String? psw;

  userMap(){
    var map = <String, dynamic>{};
    map['uEmail'] = uEmail!;
    map['name'] = name!;
    map['phoneNum'] = phoneNum!;
    map['gender'] = gender!;
    map['dob'] = dob!;
    map['age'] = age!;
    map['psw'] = psw!;
    return map;
  }

}