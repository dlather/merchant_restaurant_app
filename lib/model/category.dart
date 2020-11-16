import 'package:json_annotation/json_annotation.dart';

import './item.dart';
part 'category.g.dart';

@JsonSerializable(explicitToJson: true)
class Category {
  final String categoryName;
  final String categoryDesc;
  List<Item> items;

  factory Category.initial() => Category(
        categoryName: '',
        categoryDesc: '',
        items: [],
      );

  Category({this.categoryDesc, this.categoryName, this.items});

  Category copyWith({
    String categoryName,
    String categoryDesc,
    List<Item> items,
  }) {
    return Category(
      categoryName: categoryName ?? this.categoryName,
      categoryDesc: categoryDesc ?? this.categoryDesc,
      items: items ?? this.items,
    );
  }

  factory Category.fromJson(Map<String, dynamic> data) =>
      _$CategoryFromJson(data);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
