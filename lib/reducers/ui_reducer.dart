import 'package:redux/redux.dart';
import '../model/ui.dart';
import '../actions/ui.dart';

final Reducer<Ui> uiReducer = combineReducers([
  new TypedReducer<Ui, SetSelectedBottomNavTab>(_setSelectedBottomNavTab),
]);

Ui _setSelectedBottomNavTab(Ui prevUi, action) {
  if (action is SetSelectedBottomNavTab) {
    return prevUi.copyWith(
      selectedBottomNavTab: action.selectedBottomNavTab,
    );
  }
  return prevUi;
}
