// actions/auth_actions.dart
import 'package:firebase_auth/firebase_auth.dart' as auth;
// gives us access to `@required`
import 'package:flutter/foundation.dart';

class LogIn {}

class IsLoggedIn {}

class LogInSuccessful {
  final auth.User user;
  LogInSuccessful({@required this.user});
  @override
  String toString() {
    return 'LogInSuccessful{user: $user}';
  }
}

class LogInFail {
  final dynamic error;
  LogInFail(this.error);
  @override
  String toString() {
    return 'LogInFail{There was an error loggin in: $error}';
  }
}

class LogOut {}

class LogOutSuccessful {
  LogOutSuccessful();
  @override
  String toString() {
    return 'LogOut{user: null}';
  }
}
