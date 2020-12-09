import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(top: 100, right: 15, left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.grey,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 10, right: 15, left: 15),
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
                      return "enter mobile number ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "Mobile number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "enter email ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "email",
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
                  "Sign up",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  //do something
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              )),
          Container(
            margin: EdgeInsets.only(top: 40, right: 15, left: 15),
            alignment: Alignment.centerRight,
            width: 300,
            height: 60,
            child: FlatButton(
              child: Text(
                "already have an account? sign in.",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
