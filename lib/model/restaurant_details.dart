import './owner_details.dart';

class RestaurantDetails {
  final String restaurantId;
  final String name;
  final String mobile;
  final String address;
  final OwnerDetails owner;

  factory RestaurantDetails.initial() => RestaurantDetails(
        restaurantId: '',
        address: '',
        name: '',
        mobile: '',
        owner: OwnerDetails.initial(),
      );

  RestaurantDetails(
      {this.restaurantId, this.name, this.mobile, this.address, this.owner});

  RestaurantDetails copyWith({
    String restaurantId,
    String address,
    String name,
    String mobile,
    OwnerDetails owner,
  }) {
    return RestaurantDetails(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      restaurantId: restaurantId ?? this.restaurantId,
      owner: owner ?? this.owner,
    );
  }
}
