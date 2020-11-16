import './owner_details.dart';

class RestaurantDetails {
  final String name;
  final String mobile;
  final String address;
  final OwnerDetails owner;

  factory RestaurantDetails.initial() => RestaurantDetails(
        address: '',
        name: '',
        mobile: '',
        owner: OwnerDetails.initial(),
      );

  RestaurantDetails({this.name, this.mobile, this.address, this.owner});

  RestaurantDetails copyWith({
    String address,
    String name,
    String mobile,
    OwnerDetails owner,
  }) {
    return RestaurantDetails(
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      address: address ?? this.address,
      owner: owner ?? this.owner,
    );
  }
}
