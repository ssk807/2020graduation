import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final String name;
  final String userId;
  final String passwd;
  final String city;
  final String street;
  final String zipcode;

  User(this.name, this.userId, this.passwd, this.city, this.street,
      this.zipcode);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['userId'],
        passwd = json['passwd'],
        city = json['city'],
        street = json['street'],
        zipcode = json['zipcode'];
  // to send

  Map<String, dynamic> toJson() => {
        'name': name,
        'userId': userId,
        'passwd': passwd,
        'city': city,
        'street': street,
        'zipcode': zipcode
      };
}
// data group
