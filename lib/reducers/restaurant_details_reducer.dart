import 'package:merchant_restaurant_app/model/owner_details.dart';
import 'package:redux/redux.dart';
import '../actions/data.dart';
import '../model/restaurant_details.dart';

final Reducer<RestaurantDetails> restaurantDetailsReducer = combineReducers([
  new TypedReducer<RestaurantDetails, FetchRestaurantDetailsDataSuccess>(
      _fetchRestaurantDetailsDataSuccess),
]);

RestaurantDetails _fetchRestaurantDetailsDataSuccess(
    RestaurantDetails prevRestaurantDetails, action) {
  if (action is FetchRestaurantDetailsDataSuccess) {
    return prevRestaurantDetails.copyWith(
      name: action.restaurantDetails.name,
      mobile: action.restaurantDetails.mobile,
      address: action.restaurantDetails.address,
      owner: action.restaurantDetails.owner,
      restaurantId: action.restaurantDetails.restaurantId,
    );
  }
  return prevRestaurantDetails;
}
