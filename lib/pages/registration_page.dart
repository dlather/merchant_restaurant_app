import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/containers/auth_button/auth_button_container.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/pages/how_to_use.dart';
import 'package:redux/redux.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
        return vm.isLoading
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text('Restaurant Registration'),
                ),
                drawer: vm.isLoggedIn
                    ? Drawer(
                        child: ListView(
                          children: [
                            DrawerHeader(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.network(
                                      vm.currentUser.photoURL,
                                      height: 50,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
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
                            ),
                            ListTile(
                              title: Text('How to use'),
                              leading: Icon(Icons.help_outline),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return HowToUse();
                                }));
                              },
                            ),
                            GoogleAuthButtonContainer(
                              logIn: false,
                            ),
                          ],
                        ),
                      )
                    : null,
                body: Center(
                  child: Text('Registration'),
                ),
              );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel {
  final User currentUser;
  final bool isLoggedIn;
  final bool isLoading;
  _ViewModel({
    this.currentUser,
    this.isLoading,
    this.isLoggedIn,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentUser: store.state.currentUser.currentUser,
      isLoading: store.state.isLoading,
      isLoggedIn: store.state.currentUser.isLoggedIn,
    );
  }
}
