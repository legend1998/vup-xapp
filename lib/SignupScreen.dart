import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/main.dart';
import 'package:vup/model/Services.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool animationStatus = false;

  void validateandMovetomain() async {
    this.setState(() {
      animationStatus = true;
    });
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      print("form is valid");

      var response = await Services.signupUser(
          _usernameController.text,
          _emailController.text,
          _phoneController.text,
          _passwordController.text);
      if (response) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: "vup",
                    )));
      } else {
        Fluttertoast.showToast(
            msg: "A account is already exist with the given phone or email");
      }
    } else {
      print("form is not valid");
    }

    this.setState(() {
      animationStatus = true;
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
                margin: EdgeInsets.only(top: 100, right: 15, left: 15),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign up",
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
                      margin: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: TextFormField(
                          controller: _usernameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "enter username ";
                            } else if (!value.contains(" ")) {
                              return "last name required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.grey[100],
                            filled: true,
                            hintText: "john doe",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 10, right: 15, left: 15),
                      child: TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "mobile number required";
                            } else {
                              RegExp regexp = new RegExp(r'^[0-9]{10}$');
                              if (regexp.hasMatch(value)) {
                                return null;
                              } else
                                return "not valid phone number";
                            }
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
                          controller: _emailController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "enter email ";
                            } else if (value.endsWith("@gmail.com")) {
                              return null;
                            } else
                              return "not valid email address";
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
                          controller: _passwordController,
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
                          )))
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                width: 150,
                height: 60,
                child: FlatButton(
                  child: !animationStatus
                      ? Text(
                          "Sign up",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      : CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                  onPressed: () {
                    //do something
                    validateandMovetomain();
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
      ),
    );
  }
}
