// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../sign_in.dart';
// import '../login_page.dart';

// class Account extends StatefulWidget {
//   @override
//   _AccountState createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   static const platform = const MethodChannel("razorpay_flutter");

//   Razorpay _razorpay;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _razorpay.clear();
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_4cKxXLQBzbVATF',
//       "subscription_id": "sub_FvMhOCYqAuY6GY",
//       'name': 'Menu Corp.',
//       'description': 'Subscription',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint(e);
//     }
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//         msg: "ERROR: " + response.code.toString() + " - " + response.message,
//         timeInSecForIosWeb: 4);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         Container(
//           height: 200,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage(imageUrl),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Text(
//                   name,
//                   style: TextStyle(
//                     fontSize: 20,
//                     color: Colors.black54,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         ListTile(
//           title: Text('Edit'),
//           leading: Icon(Icons.edit),
//           onTap: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               return Edit();
//             }));
//           },
//         ),
//         ListTile(
//           title: Text('Pay'),
//           leading: Icon(Icons.payment),
//           onTap: openCheckout,
//         ),
//         ListTile(
//           title: Text('Sign Out'),
//           leading: Icon(Icons.exit_to_app),
//           onTap: () {
//             signOutGoogle();
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) {
//               return LoginPage();
//             }), ModalRoute.withName('/'));
//           },
//         ),
//       ],
//     );
//   }
// }

// class Edit extends StatefulWidget {
//   @override
//   _EditState createState() => _EditState();
// }

// class _EditState extends State<Edit> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Text('Edit'),
//       ),
//     );
//   }
// }
