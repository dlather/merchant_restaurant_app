// models/app_state.dart
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:merchant_restaurant_app/model/ui.dart';
import './restaurant_details.dart';
import './menu.dart';

@immutable
class AppState {
  final bool isLoading;
  final User currentUser;
  final RestaurantDetails restaurantDetails;
  final Ui ui;
  final Menu menu;

  factory AppState.initial() => AppState(
        isLoading: false,
        currentUser: null,
        restaurantDetails: RestaurantDetails.initial(),
        ui: Ui.initial(),
        menu: Menu.initial(),
      );

  AppState({
    this.isLoading = false,
    this.currentUser,
    this.restaurantDetails,
    this.ui,
    this.menu,
  });

  AppState copyWith({
    bool isLoading,
    User currentUser,
    RestaurantDetails restaurantDetails,
    Ui ui,
    Menu menu,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      currentUser: currentUser ?? this.currentUser,
      restaurantDetails: restaurantDetails ?? this.restaurantDetails,
      ui: ui ?? this.ui,
      menu: menu ?? this.menu,
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading  restaurantDetails: ${restaurantDetails.name} ui:${ui.selectedBottomNavTab}';
  }
}
