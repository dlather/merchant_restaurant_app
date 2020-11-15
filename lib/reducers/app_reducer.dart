import '../model/app_state.dart';
import './auth_reducer.dart';
import './common_reducer.dart';
import './ui_reducer.dart';
import './menu_reducer.dart';
import './restaurant_details_reducer.dart';

AppState appReducer(AppState prevState, action) {
  return prevState.copyWith(
    isLoading: commonReducer(prevState.isLoading, action),
    currentUser: authReducer(prevState.currentUser, action),
    ui: uiReducer(prevState.ui, action),
    menu: menuReducer(prevState.menu, action),
    restaurantDetails:
        restaurantDetailsReducer(prevState.restaurantDetails, action),
  );
}
