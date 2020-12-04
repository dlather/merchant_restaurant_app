import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:merchant_restaurant_app/actions/common_actions.dart';
import 'package:merchant_restaurant_app/actions/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/model/owner_details.dart';
import 'package:merchant_restaurant_app/model/restaurant_details.dart';
import 'package:merchant_restaurant_app/routing_constant.dart';
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
          Map<String, dynamic> data = querySnapshot.docs.single.data();
          Map<String, dynamic> restaurantDetailsJson =
              data['restaurantDetails'];
          RestaurantDetails restaurantDetails =
              RestaurantDetails.fromJson(restaurantDetailsJson);
          store.dispatch(FetchRestaurantDetailsDataSuccess(
            restaurantDetails: restaurantDetails,
          ));
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
        print(
            '--------------------------${action.type.toString()}--------------');
        RestaurantDetails restaurantDetails = RestaurantDetails(
          name: action.name,
          mobile: action.mobile,
          address: action.address,
          owner: OwnerDetails(
            name: action.owner.name,
            mobile: action.owner.mobile,
            imageUrl: action.owner.imageUrl,
          ),
        );
        if (action.type == Type.create) {
          DocumentReference documentReference =
              FirebaseFirestore.instance.collection('Restaurants').doc();
          RestaurantDetails createRestaurantDetails =
              restaurantDetails.copyWith(
            restaurantId: documentReference.id,
          );
          var data = {
            'ownerEmail': action.ownerEmail,
            'restaurantDetails': createRestaurantDetails.toJson(),
          };
          await documentReference.set(data);
          store.dispatch(
            FetchRestaurantDetailsDataSuccess(
              restaurantDetails: restaurantDetails,
            ),
          );
        } else if (action.type == Type.update) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('Restaurants')
              .where("ownerEmail", isEqualTo: action.ownerEmail)
              .get();

          print(querySnapshot.docs.first.id);
          if (querySnapshot.docs.length == 1) {
            String docId = querySnapshot.docs.single.id;
            RestaurantDetails updateRestaurantDetails =
                restaurantDetails.copyWith(
              restaurantId: docId,
            );
            var data = {
              'ownerEmail': action.ownerEmail,
              'restaurantDetails': updateRestaurantDetails.toJson(),
            };
            await FirebaseFirestore.instance
                .collection('Restaurants')
                .doc(docId)
                .update(data);
            store.dispatch(
              FetchRestaurantDetailsDataSuccess(
                restaurantDetails: restaurantDetails,
              ),
            );
          } else {
            print("Query Snapshot has length ${querySnapshot.docs.length}");
          }
        }
        store.dispatch(NavigateToAction.replace(HomePageRoute));
        store.dispatch(SetIsLoading(isLoading: false));
      } catch (error) {
        print('_createFetchData $error');
      }
    }
    next(action);
  };
}
