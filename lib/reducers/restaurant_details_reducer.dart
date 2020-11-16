import 'package:redux/redux.dart';
import '../actions/data.dart';
import '../model/restaurant_details.dart';

final Reducer<RestaurantDetails> restaurantDetailsReducer = combineReducers([
  new TypedReducer<RestaurantDetails, FetchDataSuccess>(_fetchData),
]);

RestaurantDetails _fetchData(RestaurantDetails prevRestaurantDetails, action) {
  if (action is FetchDataSuccess) {
    return prevRestaurantDetails.copyWith(
      restaurantId: prevRestaurantDetails.restaurantId,
    );
  }
  return prevRestaurantDetails;
}
