// import 'package:flutter/material.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import './sign_in.dart';
// import 'package:http/http.dart' as http;

// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final String onRestaurantRegistrationDetailSubmissionUrl =
//       'https://asia-south1-restaurant-order-app-290403.cloudfunctions.net/onRestaurantRegistrationDetailSubmission';
//   bool isLoading = false;
//   String restaurantName = '';
//   String mobileNo = '';
//   String address = '';
//   final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
//       functionName: 'onRestaurantRegistrationDetailSubmission')
//     ..timeout = const Duration(seconds: 30);

//   Future<bool> submit() async {
//     final response =
//         await http.post(onRestaurantRegistrationDetailSubmissionUrl, body: {
//       'email': email,
//       'mobileNo': mobileNo,
//       'displayName': name,
//       'uid': uid,
//       'address': address,
//       'restaurantName': restaurantName
//     });
//     if (response.statusCode == 200) {
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             key: _scaffoldKey,
//             appBar: AppBar(
//               backgroundColor: Colors.lightBlue[100],
//               iconTheme: IconThemeData(
//                 color: Colors.black54,
//               ),
//               title: Text(
//                 'Restaurant Registration',
//                 style: TextStyle(
//                   color: Colors.black54,
//                 ),
//               ),
//             ),
//             body: Container(
//               margin: EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       onChanged: (value) {
//                         restaurantName = value;
//                       },
//                       decoration:
//                           InputDecoration(labelText: 'Enter Restaurant Name'),
//                       keyboardType: TextInputType.name,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       onChanged: (value) {
//                         mobileNo = value;
//                       },
//                       decoration: InputDecoration(labelText: 'Mobile No'),
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(vertical: 10),
//                     child: TextFormField(
//                       onChanged: (value) {
//                         address = value;
//                       },
//                       decoration: InputDecoration(labelText: 'Address'),
//                       keyboardType: TextInputType.streetAddress,
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(30),
//                     child: RaisedButton(
//                       color: Colors.lightBlue[100],
//                       onPressed: () {
//                         submit().then((result) => {
//                               if (result)
//                                 {
//                                   _scaffoldKey.currentState
//                                       .showSnackBar(SnackBar(
//                                     content: Text('Success'),
//                                     duration: Duration(seconds: 3),
//                                   ))
//                                 }
//                               else
//                                 {
//                                   _scaffoldKey.currentState
//                                       .showSnackBar(SnackBar(
//                                     content: Text('Failed, Try Again'),
//                                     duration: Duration(seconds: 3),
//                                   ))
//                                 }
//                             });
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(40),
//                       ),
//                       highlightElevation: 10,
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               'Submit',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
// }
