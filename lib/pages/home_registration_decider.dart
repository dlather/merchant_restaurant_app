import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/actions/data.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/model/current_user.dart';
import 'package:merchant_restaurant_app/pages/home_page.dart';
import 'package:merchant_restaurant_app/pages/registration_page.dart';
import 'package:redux/redux.dart';

class HomeRegistrationDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        // TODO: Remove const email
        onInit: (store) {
          CurrentUser currentUser = store.state.currentUser;
          store.dispatch(FetchData(ownerEmail: currentUser.currentUser.email));
        },
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          return vm.isLoading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (vm.restaurantName.isEmpty ? RegistrationPage() : HomePage());
        });
  }
}

class _ViewModel {
  final String restaurantName;
  final bool isLoading;
  _ViewModel({
    this.restaurantName,
    this.isLoading,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      restaurantName: store.state.restaurantDetails.name,
      isLoading: store.state.isLoading,
    );
  }
}
