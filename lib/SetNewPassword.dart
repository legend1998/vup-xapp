import 'package:flutter/material.dart';

class SetNewPassword extends StatelessWidget {
  const SetNewPassword({Key key}) : super(key: key);

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
                "set new password!",
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
                      return "enter password ";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey[100],
                    filled: true,
                    hintText: "new password",
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
                    hintText: "password again",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 20, right: 15, left: 15),
              width: 150,
              height: 60,
              child: TextButton(
                child: Text(
                  "Set Password",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // set new password and go to login page
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
