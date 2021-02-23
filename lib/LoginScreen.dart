import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/ForgotPassword.dart';
import 'package:vup/SignupScreen.dart';
import 'package:vup/main.dart';
import 'package:vup/model/Services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var animationstatus = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void validateandMovetomain() async {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print("form is valid");

      var response = await Services.loginUser(
          _usernameController.text, _passwordController.text);
      if (response) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: "vup",
                    )));
      } else {
        Fluttertoast.showToast(
            msg: "either phone or email or password is incorrect");
      }
    } else {
      print("form is not valid");
    }
    this.setState(() {
      animationstatus = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                        child: TextFormField(
                            controller: _usernameController,
                            validator: (value) {
                              if (value.isNotEmpty) {
                                if (!value.endsWith("@gmail.com")) {
                                  if (value.length < 10) {
                                    return "must be 10 digits";
                                  } else {
                                    RegExp regexp = new RegExp(r'^[0-9]{10}$');
                                    if (!regexp.hasMatch(value)) {
                                      return "not valid phone number";
                                    }
                                  }
                                }
                              } else {
                                return "enter email or phone number";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.grey[100],
                              filled: true,
                              hintText: "email or phone no.",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                            ))),
                    Container(
                        margin: EdgeInsets.only(top: 10, right: 15, left: 15),
                        child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "enter password ";
                              } else if (value.length < 5) {
                                return "should be more than 5 letters";
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
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                  width: 150,
                  height: 60,
                  child: FlatButton(
                    child: animationstatus == 0
                        ? Text(
                            "Sign in",
                            style: TextStyle(color: Colors.white),
                          )
                        : CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                    onPressed: () {
                      this.setState(() {
                        animationstatus = 1;
                      });
                      validateandMovetomain();
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignupScreen()));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
