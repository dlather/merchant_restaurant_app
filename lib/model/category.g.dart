// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    categoryDesc: json['categoryDesc'] as String,
    categoryName: json['categoryName'] as String,
    items: (json['items'] as List)
        ?.map(
            (e) => e == null ? null : Item.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryDesc': instance.categoryDesc,
      'items': instance.items?.map((e) => e?.toJson())?.toList(),
    };
