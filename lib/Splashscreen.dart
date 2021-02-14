import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/main.dart';
import 'package:vup/model/cacheHive.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkLoggedin() async {
    HiveService hiveService = new HiveService();
    bool exist = await hiveService.isExists(boxName: "user");
    if (exist) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: "vup",
                  )));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), checkLoggedin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "vup",
          style: TextStyle(fontSize: 40, color: Colors.blue),
        ),
      ),
    );
  }
}
