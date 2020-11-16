import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class GoogleLogInButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressedCallback;
  GoogleLogInButton({
    this.onPressedCallback,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RaisedButton(
            onPressed: onPressedCallback,
            color: Colors.lightBlue[100],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 30.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Log in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
