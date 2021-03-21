import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vup/AddressCheck.dart';
import 'package:vup/model/Services.dart';
import 'package:vup/model/User.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Razorpay _razorpay;
  User user;
  bool loading;
  int radio=0;

    void handleRadioSelect(int value) {
    setState(() {
      radio = value;
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


  var options = {
    'key': 'rzp_test_KMsrZgN1an1lTo',
    'amount': 50000, //in the smallest currency sub-unit.
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'},
    'wallets': ['paytm']
  };
  void openPayment() async {
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
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
          child: loading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Confirm the address."),
                    InkWell(
                      child: user.address.isNotEmpty?Card(
                        child:Container(
                          width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.address[radio]["street"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        ' ${user.address[radio]["Landmark"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${user.address[radio]["district"].toString()} ${user.address[radio]["state"].toString()},${user.address[radio]["pin_code"].toString()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ))):Text("add atleast one address for delivery."),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressCheck(addressfunc: handleRadioSelect,)));
                      },
                    ),
                    Divider(),
                    Container(child: Card(child: Text("cart values"))),
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
