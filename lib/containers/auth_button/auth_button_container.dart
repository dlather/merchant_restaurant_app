// containers/auth_button/auth_button_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../actions/auth_actions.dart';
import '../../model/app_state.dart';
import './google_auth_button.dart';
import 'package:redux/redux.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return new GoogleAuthButton(
          buttonText: vm.buttonText,
          onPressedCallback: vm.onPressedCallback,
          isLoading: vm.isLoading,
        );
      },
    );
  }
}

class _ViewModel {
  final String buttonText;
  final bool isLoading;
  final Function onPressedCallback;
  _ViewModel({this.onPressedCallback, this.buttonText, this.isLoading});
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
        isLoading: store.state.isLoading,
        buttonText: store.state.currentUser != null
            ? 'Sign Out'
            : 'Sign in with Google',
        onPressedCallback: () {
          if (store.state.currentUser != null) {
            store.dispatch(new LogOut());
          } else {
            store.dispatch(new LogIn());
          }
        });
  }
}
