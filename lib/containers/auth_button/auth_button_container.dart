// containers/auth_button/auth_button_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:merchant_restaurant_app/containers/auth_button/google_logout_button.dart';
import '../../actions/auth_actions.dart';
import '../../model/app_state.dart';
import 'google_login_button.dart';
import 'package:redux/redux.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  final bool logIn;
  GoogleAuthButtonContainer({@required this.logIn});
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return logIn
            ? GoogleLogInButton(
                onPressedCallback: vm.onPressedCallback,
                isLoading: vm.isLoading,
              )
            : GoogleLogOutButton(
                isLoading: vm.isLoading,
                onPressedCallback: vm.onPressedCallback,
              );
      },
    );
  }
}

class _ViewModel {
  final bool isLoading;
  final Function onPressedCallback;
  _ViewModel({this.onPressedCallback, this.isLoading});
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        isLoading: store.state.isLoading,
        onPressedCallback: () {
          if (store.state.currentUser.isLoggedIn) {
            store.dispatch(new LogOut());
          } else {
            store.dispatch(new LogIn());
          }
        });
  }
}
