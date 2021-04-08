import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/model/Services.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobileNUmber = TextEditingController();

  void generateLink() async {
    final FormState form = _formKey.currentState;

    if (form.validate()) {
      if (await Services.forgotPassword(mobileNUmber.text)) {
        Fluttertoast.showToast(
            msg: "A change password link is sent to your email. check please",
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: "soomething went wrong please try again after some time",
            toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: EdgeInsets.only(top: 220, right: 15, left: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Set new one",
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.grey,
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: Form(
                key: _formKey,
                child: TextFormField(
                    controller: mobileNUmber,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "enter mobile number ";
                      } else if (value.length != 10) {
                        return "valid mobile number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      hintText: "Mobile number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                    )),
              )),
          Container(
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              width: 150,
              height: 60,
              child: TextButton(
                  child: Text(
                    "Generate Link",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    generateLink();
                    //do something
                  }),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}
