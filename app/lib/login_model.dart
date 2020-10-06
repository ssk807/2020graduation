import 'dart:convert';

LoginUser loginuserFromJson(String str) => LoginUser.fromJson(json.decode(str));
String loginuserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  final String userId;
  final String passwd;

  LoginUser(this.userId, this.passwd);

  LoginUser.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        passwd = json['passwd'];

  // to send

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'passwd': passwd,
      };
}
// data group
