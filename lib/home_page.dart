// import 'package:flutter/material.dart';
// import './widgets/account.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:http/http.dart' as http;
// import './sign_in.dart';
// import './widgets/qr.dart';
// import './widgets/menu.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final String onRestaurantRegistrationDetailSubmissionUrl =
//       'https://asia-south1-restaurant-order-app-290403.cloudfunctions.net/onRestaurantRegistrationDetailSubmission';
//   final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
//       functionName: 'onRestaurantRegistrationDetailSubmission')
//     ..timeout = const Duration(seconds: 30);

//   Future<bool> submit() async {
//     final response =
//         await http.post(onRestaurantRegistrationDetailSubmissionUrl, body: {
//       'email': email,
//       'displayName': name,
//       'uid': uid,
//     });
//     if (response.statusCode == 200) {
//       return true;
//     }
//     return false;
//   }

//   int _currentIndex = 0;
//   var data = {};
//   List<String> bottomNavTitles = ['Home', 'Orders', 'Menu', 'QR', 'Account'];
//   List<String> appBarTitles = [
//     'Home',
//     'Orders',
//     'Menu',
//     'QR Code Generator',
//     'Account'
//   ];
//   List<Widget> body = [
//     Center(
//       child: Text('Home'),
//     ),
//     Center(
//       child: Text('Orders'),
//     ),
//     Menu(),
//     QrCode(),
//     Account(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldKey =
//         new GlobalKey<ScaffoldState>();
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.lightBlue[50],
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           appBarTitles[_currentIndex],
//           style: TextStyle(
//             color: Colors.blue,
//           ),
//         ),
//         backgroundColor: Colors.lightBlue[50],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.lightBlue[50],
//         currentIndex: _currentIndex,
//         onTap: (value) {
//           setState(() {
//             _currentIndex = value;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         items: [
//           bottomNavigationBarItem(
//             title: bottomNavTitles[0],
//             icon: Icon(Icons.home),
//           ),
//           bottomNavigationBarItem(
//             title: bottomNavTitles[1],
//             icon: Icon(Icons.list),
//           ),
//           bottomNavigationBarItem(
//             title: bottomNavTitles[2],
//             icon: Icon(Icons.restaurant_menu),
//           ),
//           bottomNavigationBarItem(
//             title: bottomNavTitles[3],
//             icon: Icon(Icons.crop_free),
//           ),
//           bottomNavigationBarItem(
//             title: bottomNavTitles[4],
//             icon: Icon(Icons.account_circle),
//           ),
//         ],
//       ),
//       body: body[_currentIndex],
//     );
//   }
// }

// BottomNavigationBarItem bottomNavigationBarItem({
//   String title,
//   Widget icon,
// }) {
//   return BottomNavigationBarItem(
//     icon: icon,
//     title: Text(
//       title,
//       style: TextStyle(
//         fontSize: 12,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//   );
// }
