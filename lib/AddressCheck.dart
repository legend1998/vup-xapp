import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class AddressCheck extends StatefulWidget {
  AddressCheck({Key key, this.addressfunc}) : super(key: key);

  final addressfunc;

  @override
  _AddressCheckState createState() => _AddressCheckState();
}

class _AddressCheckState extends State<AddressCheck> {
  User user;
  bool loading;
  int animationstatus;
  int radioselect = -1;

  final houseandstreetcontroller = TextEditingController();
  final landmarkcontroller = TextEditingController();
  final districtcontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final pincontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationstatus = 0;
    loading = false;
    loaduser();
  }

  void handleRadioselect(int value) {
    setState(() {
      radioselect = value;
    });
    widget.addressfunc(value);
  }

  void addaddresstoapi() async {
    setState(() {
      animationstatus = 1;
    });
    bool response = await Services.addAddress(
        uid: user.id,
        street: houseandstreetcontroller.text,
        landmark: landmarkcontroller.text,
        dist: districtcontroller.text,
        state: statecontroller.text,
        pin: pincontroller.text);
    if (response) {
      Fluttertoast.showToast(msg: "address added succesfully");
    } else {
      Fluttertoast.showToast(msg: "something went wrong can't add address");
    }
    setState(() {
      animationstatus = 0;
    });
  }

  void loaduser() async {
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
        title: Text("Address"),
        actions: loading
            ? ([user.address.length == 1 ? Text("Add More") : Text("")])
            : [],
      ),
      body: loading
          ? SingleChildScrollView(
              child: user.address.isEmpty ? addAddress() : listAddress(),
            )
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Widget addAddress() => Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, right: 15, left: 15),
              child: Text("address is empty add one"),
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 15, left: 15),
                    child: TextFormField(
                      controller: houseandstreetcontroller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "house no. and street",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: TextFormField(
                      controller: landmarkcontroller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "landmark",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: TextFormField(
                      controller: districtcontroller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "district",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: TextFormField(
                      controller: statecontroller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "state",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, right: 15, left: 15),
                    child: TextFormField(
                      controller: pincontroller,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          return "must not be empty";
                        }
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintText: "pin code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                      width: 150,
                      height: 60,
                      child: TextButton(
                        child: animationstatus == 0
                            ? Text(
                                "Add Address",
                                style: TextStyle(color: Colors.white),
                              )
                            : CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                        onPressed: () {
                          this.setState(() {
                            animationstatus = 1;
                          });
                          addaddresstoapi();
                        },
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue,
                      )),
                ],
              ),
            )
          ],
        ),
      );

  Widget listAddress() => Container(
        height: MediaQuery.maybeOf(context).size.height,
        child: ListView.builder(
          itemCount: user.address.length,
          itemBuilder: (context, index) {
            var address = user.address[index];
            return ListTile(
              leading: Radio(
                  value: index,
                  groupValue: radioselect,
                  onChanged: handleRadioselect),
              title: Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${address["street"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ' ${address["Landmark"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${address["district"].toString()} ${address["state"].toString()},${address["pin_code"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
            );
          },
        ),
      );
}
