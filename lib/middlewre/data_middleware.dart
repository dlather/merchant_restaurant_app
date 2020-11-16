import 'package:merchant_restaurant_app/actions/common_actions.dart';
import 'package:merchant_restaurant_app/actions/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/model/owner_details.dart';
import 'package:merchant_restaurant_app/model/restaurant_details.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createDataMiddleware() {
  final fetchData = _createFetchData();
  final submitRestaurantDetails = _createSubmitRestaurantDetails();
  return ([
    new TypedMiddleware<AppState, FetchData>(fetchData),
    new TypedMiddleware<AppState, SubmitRestaurantDetails>(
        submitRestaurantDetails),
  ]);
}

Middleware<AppState> _createFetchData() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchData) {
      try {
        store.dispatch(SetIsLoading(isLoading: true));
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Restaurants')
            .where("ownerEmail", isEqualTo: action.ownerEmail)
            .get();
        if (querySnapshot.docs.length == 1) {
          dynamic data = querySnapshot.docs.single.data();
          store.dispatch(
            FetchRestaurantDetailsDataSuccess(
              restaurantDetails: RestaurantDetails(
                name: data['restaurantDetails']['name'],
                mobile: data['restaurantDetails']['mobile'],
                address: data['restaurantDetails']['address'],
                owner: OwnerDetails(
                  imageUrl: data['restaurantDetails']['owner']['imageUrl'],
                  mobile: data['restaurantDetails']['owner']['mobile'],
                  name: data['restaurantDetails']['owner']['name'],
                ),
              ),
            ),
          );
        } else {
          print("Query Snapshot has length ${querySnapshot.docs.length}");
        }
        store.dispatch(SetIsLoading(isLoading: false));
      } catch (error) {
        print('_createFetchData $error');
      }
    }
    next(action);
  };
}

Middleware<AppState> _createSubmitRestaurantDetails() {
  return (Store store, action, NextDispatcher next) async {
    if (action is SubmitRestaurantDetails) {
      try {
        store.dispatch(SetIsLoading(isLoading: true));
        var data = {
          'ownerEmail': action.ownerEmail,
          'restaurantDetails': {
            'name': action.name,
            'mobile': action.mobile,
            'address': action.address,
            'owner': {
              'name': action.owner.name,
              'mobile': action.owner.mobile,
              'imageUrl': action.owner.imageUrl
            },
          }
        };
        DocumentReference documentReference =
            FirebaseFirestore.instance.collection('Restaurants').doc();
        await documentReference.set(data);
        store.dispatch(SetIsLoading(isLoading: false));
      } catch (error) {
        print('_createFetchData $error');
      }
    }
    next(action);
  };
}
