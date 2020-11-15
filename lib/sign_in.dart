// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();

// String name;
// String uid;
// String email;
// String imageUrl;

// Future<String> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   final AuthCredential credential = GoogleAuthProvider.credential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );

//   final UserCredential authResult =
//       await _auth.signInWithCredential(credential);
//   final User user = authResult.user;

//   if (user != null) {
//     name = user.displayName;
//     email = user.email;
//     uid = user.uid;
//     imageUrl = user.photoURL;
//     print('signInWithGoogle succeeded: ${user.email} and $uid');
//     return '$user';
//   }

//   return null;
// }

// Future<void> signOutGoogle() async {
//   await googleSignIn.signOut();

//   print("User Signed Out");
// }

// Future<bool> isLoggedIn() async {
//   await Firebase.initializeApp();
//   User user = _auth.currentUser;
//   if (user != null) {
//     name = user.displayName;
//     email = user.email;
//     uid = user.uid;
//     imageUrl = user.photoURL;
//     print('User $email logged in');
//     return true;
//   }
//   return false;
// }
