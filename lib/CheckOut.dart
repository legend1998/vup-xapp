import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckOut extends StatefulWidget {
  CheckOut({Key key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    loadPaymentinstance();
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
    // TODO: implement dispose
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
          child: Column(
        children: [],
      )),
    );
  }
}
