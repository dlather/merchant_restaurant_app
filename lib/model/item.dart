import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item {
  final String itemName;
  final String itemDesc;
  final String imageUrl;

  factory Item.initial() => Item(
        itemName: '',
        itemDesc: '',
        imageUrl: '',
      );

  Item({this.imageUrl, this.itemDesc, this.itemName});

  Item copyWith({String imageUrl, String itemDesc, String itemName}) {
    return Item(
      imageUrl: imageUrl ?? this.imageUrl,
      itemDesc: itemDesc ?? this.itemDesc,
      itemName: itemName ?? this.itemName,
    );
  }

  factory Item.fromJson(Map<String, dynamic> data) => _$ItemFromJson(data);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
