// lib/middleware/auth_middleware.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../actions/auth_actions.dart';
import '../actions/common_actions.dart';
import 'package:firebase_core/firebase_core.dart';
import '../model/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createAuthMiddleware() {
  final logIn = _createLogInMiddleware();
  final isLoggedIn = _createIsLoggedInMiddleware();
  final logOut = _createLogOutMiddleware();
  return ([
    new TypedMiddleware<AppState, LogIn>(logIn),
    new TypedMiddleware<AppState, LogOut>(logOut),
    new TypedMiddleware<AppState, IsLoggedIn>(isLoggedIn)
  ]);
}

Middleware<AppState> _createIsLoggedInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    store.dispatch(SetIsLoading(isLoading: true));
    await Firebase.initializeApp();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User user = _auth.currentUser;
    if (user != null) {
      print('Auto Logged in' + user.displayName);
      store.dispatch(new LogInSuccessful(user: user));
    }
    store.dispatch(SetIsLoading(isLoading: false));
    next(action);
  };
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    store.dispatch(SetIsLoading(isLoading: true));
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      User user = authResult.user;
      print('Logged in ' + user.displayName);
      store.dispatch(new LogInSuccessful(user: user));
    } catch (error) {
      store.dispatch(new LogInFail(error));
    }
    store.dispatch(SetIsLoading(isLoading: false));
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    store.dispatch(SetIsLoading(isLoading: true));
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      store.dispatch(LogOutSuccessful);
    } catch (error) {
      print("Error in Logout + $error");
    }
    store.dispatch(SetIsLoading(isLoading: false));
    next(action);
  };
}
