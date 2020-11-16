// reducers/auth_reducer.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/model/current_user.dart';
import '../actions/auth_actions.dart';
import 'package:redux/redux.dart';

final Reducer<CurrentUser> authReducer = combineReducers([
  new TypedReducer<CurrentUser, LogInSuccessful>(_logIn),
  new TypedReducer<CurrentUser, LogOut>(_logOut),
]);
CurrentUser _logIn(CurrentUser user, action) {
  if (action is LogInSuccessful) {
    return user.copyWith(
      isLoggedIn: true,
      currentUser: action.user,
    );
  }
  return user;
}

CurrentUser _logOut(CurrentUser user, action) {
  if (action is LogOut) {
    return user.copyWith(
      isLoggedIn: false,
      currentUser: null,
    );
  }
  return user;
}
