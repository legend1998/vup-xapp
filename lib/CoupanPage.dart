import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class CoupanCard extends StatefulWidget {
  CoupanCard({Key key}) : super(key: key);

  @override
  _CoupanCardState createState() => _CoupanCardState();
}

class _CoupanCardState extends State<CoupanCard> {
  bool loading;
  User user;
  @override
  void initState() {
    super.initState();
    loading = false;
    loadcoupans();
  }

  void loadcoupans() async {
    User temp = await Services.getUser();

    setState(() {
      if (temp != null) {
        user = temp;
      }
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coupans"),
      ),
      body: loading
          ? GridView.builder(
              itemCount: user.coupans.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Image.asset('images/coupancard.png'),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 1,
              ),
            )
          : Container(
              child: Center(
                child: Text("Refer and earn coupans."),
              ),
            ),
    );
  }
}
