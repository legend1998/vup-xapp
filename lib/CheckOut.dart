import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vup/AddressCheck.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key key, this.basket}) : super(key: key);

  final basket;

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Razorpay _razorpay;
  User user;
  bool loading;
  int radio = -1;
  var address;
  int total = 0;
  int delivery = 0;
  int coupan = 0;

  void handleRadioSelect(int value) {
    setState(() {
      radio = value;
      address = user.address[radio];
    });
  }

  void manageBasketValue() {
    int limit = 1;

    if (total >= 1000 && total < 2000) {
      limit = 3;
    } else if (total > 2000) {
      limit = 5;
    }
    print(limit);
    this.setState(() {
      coupan =
          user.coupans.length > limit ? limit * 20 : user.coupans.length * 20;

      total = widget.basket + delivery - coupan;
    });
  }

  @override
  void initState() {
    super.initState();
    loading = false;
    _razorpay = Razorpay();
    loadPaymentinstance();
    loadUser();
  }

  void loadUser() async {
    var temp = await Services.getUser();
    if (temp != null) {
      setState(() {
        user = temp;
        loading = true;
      });
    }
  }

  void openPayment(
      {int total, String name, String contact, String email}) async {
    var options = {
      'key': 'rzp_test_KMsrZgN1an1lTo',
      'amount': total * 100, //in the smallest currency sub-unit.
      'name': name,
      'timeout': 60, // in seconds
      'prefill': {'contact': contact, 'email': email},
      'wallets': ['paytm']
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print('this is error $e');
    }
  }

  void _handlepaymentsuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: response.orderId);
  }

  void _handlepaymenterror(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: response.message);
    print(response.message);
  }

  void _handleexternalwallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: response.walletName);
  }

  void loadPaymentinstance() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlepaymentsuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlepaymenterror);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleexternalwallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: FittedBox(
              child: FloatingActionButton.extended(
                  onPressed: () {
                    // do something
                    if (total == 0) {
                      Fluttertoast.showToast(
                          msg: "apply coupan to first to proceed.");
                      return;
                    }
                    if (radio == -1) {
                      Fluttertoast.showToast(msg: "select address first");
                      return;
                    }
                    // openPayment(
                    //     total: total,
                    //     name: '${user.fname} ${user.lname}',
                    //     contact: user.phone,
                    //     email: user.email);
                  },
                  label: Text("Pay now")))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
          child: loading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text("Confirm the address."),

                    InkWell(
                      child: address != null
                          ? Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(),
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  height: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  )))
                          : Card(
                              child: Container(
                                height: 100,
                                child: Center(
                                    child: Text(
                                        "select one address for delivery.")),
                              ),
                            ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressCheck(
                                      addressfunc: handleRadioSelect,
                                    )));
                      },
                    ),
                    // apply coupan here
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerRight,
                        child: Container(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                // do something
                                manageBasketValue();
                              },
                              child: Text("apply coupan"),
                            ))),
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                        child: Column(
                      children: [
                        Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("basket value."),
                                Text('${widget.basket} Rs'),
                              ],
                            )),
                        Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("delivery charges"),
                                Text('$delivery Rs.'),
                              ],
                            )),
                        Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Coupan applied"),
                                Text('$coupan Rs'),
                              ],
                            )),
                        Container(
                            height: 30,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "net Payable",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text('$total Rs.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.topRight,
                          child: Text(
                            "GST included*",
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      ],
                    )),
                    Divider(),
                  ],
                )
              : Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
    );
  }
}
