import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/model/Services.dart';

class OrderSuccess extends StatefulWidget {
  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  @override
  void initState() {
    super.initState();
    update();
  }

  void update() async {
    bool res = await Services.updateUser();
    if (!res) {
      Fluttertoast.showToast(
          msg: "can't update user, re login to fetch the order items",
          toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/checkcircle.gif"),
            SizedBox(
              height: 60,
            ),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(right: 30, left: 30),
              child: Text(
                  " Thank You, your order is confirmed we will deliver it in 1 to 2 days.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      height: 2,
                      decoration: TextDecoration.none)),
            )),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 100,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30))),
                onPressed: () {
                  //do something
                  Navigator.pop(context);
                },
                child: Text(
                  "Okay",
                  style: TextStyle(
                      decoration: TextDecoration.none, color: Colors.white),
                ),
              ),
            )
          ],
        ));
  }
}
