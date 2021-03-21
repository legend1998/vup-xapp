import 'package:flutter/material.dart';
import 'package:vup/CoupanPage.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class ReferAndEarn extends StatefulWidget {
  ReferAndEarn({Key key}) : super(key: key);

  @override
  _ReferAndEarnState createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  User user;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loaduser();
  }

  void loaduser() async {
    print("calling");
    var temp = await Services.getUser();
    setState(() {
      user = temp;
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Refer and Earn"),
        actions: [
          TextButton(
            child: Text(
              "coupan",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CoupanCard()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              decoration: BoxDecoration(),
              child: Center(
                child: Text(
                  loading ? 'Hello ${user.fname}' : "Hello user",
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
            Center(
              child: Text("share and Earn a coupan worth 20 Rs."),
            ),
            Center(
              child: Text("Your reference code is "),
            ),
            Center(
                child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 30),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/coupan.png"))),
                    child: Center(
                      child: loading
                          ? SelectableText(
                              user.refCode,
                              style: TextStyle(
                                  color: Colors.green,
                                  backgroundColor: Colors.grey[100]),
                            )
                          : Text(
                              "refer and earn",
                              style: TextStyle(
                                  color: Colors.green,
                                  backgroundColor: Colors.greenAccent[100]),
                            ),
                    ))),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rules to play:",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("1. user get 1 coupan when sign up first time"),
                  Text(
                      "2. share this application and reference code to other user by tapping the share button,"),
                  Text(
                      "3. when the other user install this app and enter your reference code in refer and earn tab. then you will get a coupan."),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    width: MediaQuery.maybeOf(context).size.width * 0.9,
                    height: 60),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    "Share",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
              ),
            )
          ])),
    );
  }
}
