import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/LoginScreen.dart';
import 'package:vup/main.dart';
import 'package:vup/model/cacheHive.dart';
import 'package:vup/utils/permissionService.dart';

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
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void checkPermision() async {
    if (await PermissionService.getPermission(context)) {
      checkLoggedin();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), checkPermision);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.blue),
      child: Center(
        child: Image.asset(
          "images/mainlogowhite.png",
          width: 250,
        ),
      ),
    ));
  }
}
