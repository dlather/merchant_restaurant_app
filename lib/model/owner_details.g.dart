// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerDetails _$OwnerDetailsFromJson(Map<String, dynamic> json) {
  return OwnerDetails(
    imageUrl: json['imageUrl'] as String,
    mobile: json['mobile'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$OwnerDetailsToJson(OwnerDetails instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'imageUrl': instance.imageUrl,
    };
