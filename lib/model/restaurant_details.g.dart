// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDetails _$RestaurantDetailsFromJson(Map<String, dynamic> json) {
  return RestaurantDetails(
    name: json['name'] as String,
    mobile: json['mobile'] as String,
    address: json['address'] as String,
    owner: json['owner'] == null
        ? null
        : OwnerDetails.fromJson(json['owner'] as Map<String, dynamic>),
    restaurantId: json['restaurantId'] as String,
  );
}

Map<String, dynamic> _$RestaurantDetailsToJson(RestaurantDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'address': instance.address,
      'owner': instance.owner?.toJson(),
      'restaurantId': instance.restaurantId,
    };
