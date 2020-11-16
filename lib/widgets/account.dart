import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:merchant_restaurant_app/containers/auth_button/auth_button_container.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/routing_constant.dart';
import 'package:redux/redux.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
        return vm.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Container(
                    height: 200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage(vm.currentUser.photoURL),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            vm.currentUser.displayName,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text('Edit Restaurant Details'),
                    leading: Icon(Icons.edit),
                    onTap: () {
                      vm.onEditTap();
                    },
                  ),
                  GoogleAuthButtonContainer(
                    logIn: false,
                  ),
                ],
              );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel {
  final User currentUser;
  final Function onEditTap;
  final bool isLoading;
  _ViewModel({
    this.currentUser,
    this.onEditTap,
    this.isLoading,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentUser: store.state.currentUser.currentUser,
      onEditTap: () =>
          store.dispatch(NavigateToAction.push(EditRestaurantDetailsRoute)),
      isLoading: store.state.isLoading,
    );
  }
}
