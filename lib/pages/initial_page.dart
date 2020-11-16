import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/pages/home_registration_decider.dart';
import 'package:redux/redux.dart';
import '../model/app_state.dart';
import '../actions/auth_actions.dart';
import './login_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(IsLoggedIn()),
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return vm.isLoggedIn ? HomeRegistrationDecider() : LoginPage();
      },
    );
  }
}

class _ViewModel {
  bool isLoggedIn;
  _ViewModel({this.isLoggedIn});
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      isLoggedIn: store.state.currentUser.isLoggedIn,
    );
  }
}
