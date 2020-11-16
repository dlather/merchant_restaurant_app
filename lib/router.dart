import 'package:flutter/material.dart';
import 'package:merchant_restaurant_app/pages/home_page.dart';
import 'package:merchant_restaurant_app/pages/initial_page.dart';
import 'package:merchant_restaurant_app/pages/login_page.dart';
import 'package:merchant_restaurant_app/pages/registration_page.dart';
import 'package:merchant_restaurant_app/routing_constant.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case InitialPageRoute:
      return MaterialPageRoute(builder: (context) => InitialPage());
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case LoginPageRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case EditRestaurantDetailsRoute:
      return MaterialPageRoute(builder: (context) => RegistrationPage());
    default:
      return MaterialPageRoute(builder: (context) => InitialPage());
  }
}
