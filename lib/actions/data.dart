import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:merchant_restaurant_app/model/owner_details.dart';
import 'package:merchant_restaurant_app/model/restaurant_details.dart';

class FetchData {
  String ownerEmail;
  FetchData({@required this.ownerEmail});
}

class FetchDataSuccess {}

class FetchRestaurantDetailsDataSuccess {
  RestaurantDetails restaurantDetails;
  FetchRestaurantDetailsDataSuccess({this.restaurantDetails});
}

class UpdateRestaurantDetailsSuccess {
  RestaurantDetails restaurantDetails;
  UpdateRestaurantDetailsSuccess({this.restaurantDetails});
}

class FetchDataFail {}

enum Type {
  create,
  update,
}

class SubmitRestaurantDetails {
  Type type;
  String ownerEmail;
  String name;
  String address;
  String mobile;
  OwnerDetails owner;
  SubmitRestaurantDetails({
    @required this.name,
    @required this.ownerEmail,
    this.address,
    this.mobile,
    this.owner,
    this.type,
  });
}
