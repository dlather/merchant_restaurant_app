import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/actions/data.dart';
import 'package:merchant_restaurant_app/containers/auth_button/auth_button_container.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/model/owner_details.dart';
import 'package:merchant_restaurant_app/pages/how_to_use.dart';
import 'package:redux/redux.dart';

class RegistrationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String address = '';
  String mobile = '';
  OwnerDetails owner = OwnerDetails.initial();
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
        return vm.isLoading
            ? Scaffold(
                body: Center(
                  child: Row(
                    children: [
                      Text('Please Log In'),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  iconTheme: IconThemeData(
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Restaurant Registration',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  backgroundColor: Colors.lightBlue[50],
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
                body: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Enter Restaurant Name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  name = value;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter Restaurant Name *'),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  mobile = value;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter Restaurant Mobile'),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  address = value;
                                },
                                decoration: InputDecoration(
                                    labelText: 'Enter Restaurant Address'),
                                keyboardType: TextInputType.name,
                              ),
                            ),
                            SizedBox(height: 50),
                            ListTile(
                              title: RaisedButton(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                color: Colors.lightBlue[100],
                                onPressed: () {
                                  if (_formKey.currentState.validate() &&
                                      !vm.isLoading) {
                                    vm.onSubmit(
                                      ownerEmail: vm.currentUser.email,
                                      name: name,
                                      mobile: mobile,
                                      address: address,
                                      owner: OwnerDetails(
                                        imageUrl: vm.currentUser.photoURL,
                                        mobile: vm.currentUser.phoneNumber,
                                        name: vm.currentUser.displayName,
                                      ),
                                    );
                                  }
                                },
                                child: vm.isLoading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'Submit',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
  final Function({
    String name,
    String mobile,
    String address,
    String ownerEmail,
    OwnerDetails owner,
  }) onSubmit;
  _ViewModel({
    this.currentUser,
    this.isLoading,
    this.isLoggedIn,
    this.onSubmit,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      currentUser: store.state.currentUser.currentUser,
      isLoading: store.state.isLoading,
      isLoggedIn: store.state.currentUser.isLoggedIn,
      onSubmit: ({
        String name,
        String mobile,
        String ownerEmail,
        String address,
        OwnerDetails owner,
      }) =>
          store.dispatch(
        SubmitRestaurantDetails(
          name: name,
          ownerEmail: ownerEmail,
          mobile: mobile,
          address: address,
          owner: owner,
        ),
      ),
    );
  }
}
