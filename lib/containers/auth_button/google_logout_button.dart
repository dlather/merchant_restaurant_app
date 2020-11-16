import 'package:flutter/material.dart';

class GoogleLogOutButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressedCallback;
  GoogleLogOutButton({
    this.onPressedCallback,
    this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: onPressedCallback,
          );
  }
}
