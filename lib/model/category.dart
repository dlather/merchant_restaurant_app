import './item.dart';

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
}
