import 'package:redux/redux.dart';
import '../actions/data.dart';
import '../model/menu.dart';

final Reducer<Menu> menuReducer = combineReducers([
  new TypedReducer<Menu, FetchDataSuccess>(_fetchData),
]);

Menu _fetchData(Menu prevMenu, action) {
  if (action is FetchDataSuccess) {
    return prevMenu.copyWith(
      menu: prevMenu.menu,
    );
  }
  return prevMenu;
}
