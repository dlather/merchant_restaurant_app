import './category.dart';

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
}
