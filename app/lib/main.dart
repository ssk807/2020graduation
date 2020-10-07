import 'package:app/login_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'user_model.dart';

import 'dart:convert';
//import

void main() {
  runApp(MyApp());
}
//run App

final TextEditingController tnameController = TextEditingController();
final TextEditingController tuserIdController = TextEditingController();
final TextEditingController tpasswdController = TextEditingController();
final TextEditingController tcityController = TextEditingController();
final TextEditingController tstreetController = TextEditingController();
final TextEditingController tzipcodeController = TextEditingController();
//input text save

final String url = 'http://10.0.2.2:8080/';
//target server url
String targeturl;

Future<User> createUser(String name, String userId, String passwd, String city,
    String street, String zipcode) async {
  final msg = jsonEncode({
    'name': name,
    'userId': userId,
    'passwd': passwd,
    'city': city,
    'street': street,
    'zipcode': zipcode
  });

  final response = await http.post(
    targeturl,
    headers: {'Content-Type': 'application/json'},
    body: msg,
  );

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return userFromJson(responseString);
  } else {
    return null;
  }
}
//user structure to send

Future<LoginUser> loginUser(String userId, String passwd) async {
  final msg = jsonEncode({'userId': userId, 'passwd': passwd});

  final response = await http.post(
    targeturl,
    headers: {'Content-Type': 'application/json'},
    body: msg,
  );

  if (response.statusCode == 201) {
    final String responseString = response.body;
    return loginuserFromJson(responseString);
  } else {
    return null;
  }
}
//login structure to send

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new LoginForm(),
    );
  }
}
//start base to be revised later

Widget bulidTextField(String labelText, TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    obscureText: labelText == "PASSWORD" ? true : false,
  );
}
//text box widget form

Widget bulidregisterField(String labelText, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 5.0,
      ),
      border: OutlineInputBorder(),
    ),
    obscureText: labelText == "비밀번호" ? true : false,
  );
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 40.0, 0.0, 0.0),
                      child: Text('안녕하세요 \nGreenCafe입니다.',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 120.0, 0.0, 0.0),
                      child: Text('원활한 서비스 이용을 위해 로그인 해주세요.',
                          style: TextStyle(
                              fontSize: 10.0, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      bulidTextField("ID", tuserIdController),
                      SizedBox(
                        height: 10.0,
                      ),
                      bulidTextField("PASSWORD", tpasswdController),
                      SizedBox(height: 5.0),
                      Container(
                          padding: EdgeInsets.only(top: 15, left: 140),
                          child: InkWell(
                            child: Text('you are not the member?',
                                style: TextStyle(
                                    color: Colors.green[400],
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterForm()));
                            },
                          )),
                      SizedBox(height: 60),
                      Container(
                          height: 60,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.lightGreen,
                            elevation: 7.0,
                            child: GestureDetector(
                                onTap: () async {
                                  final String userId = tuserIdController.text;
                                  final String passwd = tpasswdController.text;

                                  targeturl = url + 'login/';

                                  await loginUser(userId, passwd);
                                },
                                child: Center(
                                    child: Text('LOGIN',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        )))),
                          ))
                    ],
                  ))
            ]));
  }
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Container(
                child: Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: <Widget>[
                        bulidregisterField("이름", tnameController),
                        SizedBox(
                          height: 10.0,
                        ),
                        bulidregisterField("아이디", tuserIdController),
                        SizedBox(
                          height: 10.0,
                        ),
                        bulidregisterField("비밀번호", tpasswdController),
                        SizedBox(
                          height: 10.0,
                        ),
                        bulidregisterField("도시", tcityController),
                        SizedBox(
                          height: 10.0,
                        ),
                        bulidregisterField("거리", tstreetController),
                        SizedBox(
                          height: 10.0,
                        ),
                        bulidregisterField("집주소", tzipcodeController),
                      ],
                    ))
              ],
            )),
            SizedBox(height: 20),
            Container(
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  elevation: 7.0,
                  child: GestureDetector(
                      onTap: () async {
                        //after we received the token should be changed area.
                        final String name = tnameController.text;
                        final String userId = tuserIdController.text;
                        final String passwd = tpasswdController.text;
                        final String city = tcityController.text;
                        final String street = tstreetController.text;
                        final String zipcode = tzipcodeController.text;

                        if ((name == "") |
                            (userId == "") |
                            (passwd == "") |
                            (city == "") |
                            (street == "") |
                            (zipcode == "")) {
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterSuccessForm()));
                          targeturl = url + 'account/create/';

                          await createUser(
                              name, userId, passwd, city, street, zipcode);
                        }
                      },
                      child: Center(
                          child: Text('register',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )))),
                ))
          ],
        ));
  }
}

class RegisterSuccessForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
            Container(
                child: Center(
              child: Text('login success'),
            ))
          ],
        ));
  }
}
