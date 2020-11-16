// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) {
  return Item(
    imageUrl: json['imageUrl'] as String,
    itemDesc: json['itemDesc'] as String,
    itemName: json['itemName'] as String,
  );
}

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'itemName': instance.itemName,
      'itemDesc': instance.itemDesc,
      'imageUrl': instance.imageUrl,
    };
