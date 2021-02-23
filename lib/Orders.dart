import 'package:flutter/material.dart';
import 'package:vup/main.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/utils/productTile.dart';

class Orders extends StatefulWidget {
  Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future _user;

  @override
  void initState() {
    super.initState();
    _user = Services.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("my Orders"),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: _user,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              var data = snapshot.data.orders;
              if (data.isNotEmpty) {
                return Container(
                  height: MediaQuery.of(context).size.height - 100,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return productSearchTile(data[index], context);
                      }),
                );
              } else
                return Container(
                    height: MediaQuery.of(context).size.height - 100,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("images/empty_basket.png"),
                        Container(
                            margin:
                                EdgeInsets.only(top: 20, right: 15, left: 15),
                            height: 60,
                            child: FlatButton(
                              child: Text(
                                "Let's buy something",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              title: "vup",
                                            )));
                              },
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue,
                            )),
                      ],
                    ));
              break;
            default:
              return Text("something went wrong");
          }
        },
      )),
    );
  }
}
