import 'package:json_annotation/json_annotation.dart';

import './category.dart';
part 'menu.g.dart';

@JsonSerializable(explicitToJson: true)
class Menu {
  List<Category> menu;

  factory Menu.initial() => Menu(
        menu: [],
      );

  Menu({this.menu});

  Menu copyWith({
    List<Category> menu,
  }) {
    return Menu(
      menu: menu ?? this.menu,
    );
  }

  factory Menu.fromJson(Map<String, dynamic> data) => _$MenuFromJson(data);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
