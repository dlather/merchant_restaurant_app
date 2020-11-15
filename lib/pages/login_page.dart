import 'package:flutter/material.dart';
import '../containers/auth_button/auth_button_container.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue[50],
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/menu.png"), height: 200.0),
              SizedBox(height: 80),
              GoogleAuthButtonContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
