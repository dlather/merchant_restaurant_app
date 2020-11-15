// reducers/auth_reducer.dart
import 'package:firebase_auth/firebase_auth.dart';
import '../actions/auth_actions.dart';
import 'package:redux/redux.dart';

final Reducer<User> authReducer = combineReducers([
  new TypedReducer<User, LogInSuccessful>(_logIn),
  new TypedReducer<User, LogOut>(_logOut),
]);
User _logIn(User user, action) {
  if (action is LogInSuccessful) {
    return action.user;
  }
  return user;
}

Null _logOut(User user, action) {
  if (action is LogOut) {
    return null;
  }
  return user;
}
