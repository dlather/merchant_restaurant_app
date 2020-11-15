import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/app_state.dart';
import '../actions/auth_actions.dart';
import './login_page.dart';
import './home_page.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInit: (store) => store.dispatch(IsLoggedIn()),
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return vm.currentUser != null ? HomePage() : LoginPage();
      },
    );
  }
}

class _ViewModel {
  User currentUser;
  _ViewModel({this.currentUser});
  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      currentUser: store.state.currentUser,
    );
  }
}
