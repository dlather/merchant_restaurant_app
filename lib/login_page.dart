// import 'package:flutter/material.dart';

// import 'home_page.dart';
// import 'sign_in.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.lightBlue[50],
//         child: Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image(image: AssetImage("assets/menu.png"), height: 200.0),
//               SizedBox(height: 80),
//               _signInButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signInButton() {
//     return RaisedButton(
//       color: Colors.lightBlue[100],
//       onPressed: () {
//         signInWithGoogle().then((result) {
//           if (result != null) {
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return HomePage();
//                 },
//               ),
//               (Route<dynamic> route) => false,
//             );
//           }
//         }).catchError((error) {
//           print('Error occured while logging in');
//         });
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       highlightElevation: 0,
//       // borderSide: BorderSide(color: Colors.grey),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Image(image: AssetImage("assets/google_logo.png"), height: 30.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'Sign in with Google',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black54,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
