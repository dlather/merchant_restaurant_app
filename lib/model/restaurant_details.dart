import 'package:json_annotation/json_annotation.dart';

import './owner_details.dart';
part 'restaurant_details.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantDetails {
  final String name;
  final String mobile;
  final String address;
  final OwnerDetails owner;
  final String restaurantId;
  factory RestaurantDetails.initial() => RestaurantDetails(
        restaurantId: '',
        address: '',
        name: '',
        mobile: '',
        owner: OwnerDetails.initial(),
      );

  RestaurantDetails(
      {this.name, this.mobile, this.address, this.owner, this.restaurantId});

  RestaurantDetails copyWith({
    String address,
    String name,
    String mobile,
    OwnerDetails owner,
    String restaurantId,
  }) {
    return RestaurantDetails(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      owner: owner ?? this.owner,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  factory RestaurantDetails.fromJson(Map<String, dynamic> data) =>
      _$RestaurantDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$RestaurantDetailsToJson(this);
}
