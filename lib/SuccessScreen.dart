import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/OrderSuccess.dart';
import 'package:vup/model/Services.dart';

class SuccessScreen extends StatefulWidget {
  SuccessScreen({Key key, this.amount}) : super(key: key);

  final int amount;
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  bool animation = false;

  void placeorder() async {
    this.setState(() {
      animation = true;
    });
    Fluttertoast.showToast(
        msg: "placing order for wait for a sec.",
        toastLength: Toast.LENGTH_LONG);
    String result = await Services.makeOrder(widget.amount);

    if (result == "success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OrderSuccess()));
    } else {
      Fluttertoast.showToast(
          msg:
              "something went wrong on server side plz try again after some time",
          toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
    }
  }

  void cancelOrder() {
    Fluttertoast.showToast(
        msg: "soon we will add a payment gateway.",
        toastLength: Toast.LENGTH_LONG);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              "Now Cash On Delivery is available only. Is this Okay ?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                height: 2,
                color: Colors.white,
              ),
            )),
            SizedBox(
              height: 100,
            ),
            Container(
              child: animation
                  ? CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                // do something
                                cancelOrder();
                              },
                              child: Text(
                                "Cancel",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.blue),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightBlueAccent,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                // do something
                                placeorder();
                              },
                              child: Text(
                                "okay",
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    ));
  }
}
