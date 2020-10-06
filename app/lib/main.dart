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
//run

final TextEditingController tnameController = TextEditingController();
final TextEditingController tuserIdController = TextEditingController();
final TextEditingController tpasswdController = TextEditingController();
final TextEditingController tcityController = TextEditingController();
final TextEditingController tstreetController = TextEditingController();
final TextEditingController tzipcodeController = TextEditingController();

final String url = 'https://10.0.2.2:8080/';

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
//define input textarea

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
                      padding: EdgeInsets.fromLTRB(30.0, 38.0, 0.0, 0.0),
                      child: Text('Green',
                          style: TextStyle(
                              fontSize: 50.0, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(25.0, 90.0, 0.0, 0.0),
                      child: Text('Coffee',
                          style: TextStyle(
                              fontSize: 80.0, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: tuserIdController,
                        decoration: InputDecoration(
                            labelText: 'ID',
                            labelStyle: TextStyle(
                                fontFamily: 'Gothic',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 255, 22, 0)))),
                      ),
                      TextField(
                        controller: tpasswdController,
                        decoration: InputDecoration(
                            labelText: 'PassWord',
                            labelStyle: TextStyle(
                                fontFamily: 'Gothic',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(13, 255, 22, 0)))),
                      ),
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
                    padding: EdgeInsets.only(top: 35.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: tnameController,
                          decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                        TextField(
                          controller: tuserIdController,
                          decoration: InputDecoration(
                              labelText: 'ID',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                        TextField(
                          controller: tpasswdController,
                          decoration: InputDecoration(
                              labelText: 'PassWord',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                        TextField(
                          controller: tcityController,
                          decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                        TextField(
                          controller: tstreetController,
                          decoration: InputDecoration(
                              labelText: 'Street',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                        TextField(
                          controller: tzipcodeController,
                          decoration: InputDecoration(
                              labelText: 'zipcode',
                              labelStyle: TextStyle(
                                  fontFamily: 'Gothic',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(13, 255, 22, 0)))),
                        ),
                      ],
                    ))
              ],
            )),
            SizedBox(height: 50),
            Container(
                height: 50,
                child: Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  elevation: 7.0,
                  child: GestureDetector(
                      onTap: () async {
                        final String name = tnameController.text;
                        final String userId = tuserIdController.text;
                        final String passwd = tpasswdController.text;
                        final String city = tcityController.text;
                        final String street = tstreetController.text;
                        final String zipcode = tzipcodeController.text;

                        targeturl = url + 'account/create/';

                        await createUser(
                            name, userId, passwd, city, street, zipcode);
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

// to send /account/create
// to send /login
