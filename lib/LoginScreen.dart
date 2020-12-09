import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/ForgotPassword.dart';
import 'package:vup/SignupScreen.dart';

import 'package:vup/main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(top: 180, right: 15, left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "hie there!",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.grey,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "enter username ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "enter password ";
                    } else if (value.length < 8) {
                      return "smaller than 8 letters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              width: 150,
              height: 60,
              child: FlatButton(
                child: Text(
                  "Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                title: "vup",
                              )));
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              )),
          Container(
            margin: EdgeInsets.only(top: 20, right: 15, left: 15),
            alignment: Alignment.centerRight,
            width: 200,
            height: 60,
            child: FlatButton(
              child: Text(
                "forgot password?",
                style: TextStyle(color: Colors.black38, fontSize: 14),
              ),
              onPressed: () {
                // go to forgot page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 0, right: 15, left: 15),
            alignment: Alignment.centerRight,
            width: 200,
            height: 60,
            child: FlatButton(
              child: Text(
                "new here? sign up.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }

  TextStyle newMethod() => new TextStyle(color: Colors.white);
}
