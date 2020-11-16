import 'package:firebase_auth/firebase_auth.dart';

// if isLoggedIn is true then currentUser contains data for sure,
// if isLoggedIn is false then currentUser may/may not contain data

class CurrentUser {
  bool isLoggedIn;
  User currentUser;
  CurrentUser({this.currentUser, this.isLoggedIn});
  factory CurrentUser.initial() => CurrentUser(
        isLoggedIn: false,
        currentUser: null,
      );

  CurrentUser copyWith({
    bool isLoggedIn,
    User currentUser,
  }) {
    return CurrentUser(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
