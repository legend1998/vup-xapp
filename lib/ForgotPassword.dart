import 'package:flutter/material.dart';
import 'package:vup/OTPpage.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                    hintText: "Mobile number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              width: 150,
              height: 60,
              child: TextButton(
                child: Text(
                  "Get OTP",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  //do something
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OTPconfirmScreen()));
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blue,
              )),
        ],
      ),
    );
  }
}
