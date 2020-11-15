import 'package:merchant_restaurant_app/actions/common_actions.dart';
import 'package:merchant_restaurant_app/actions/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createDataMiddleware() {
  final fetchData = _createFetchData();
  return ([
    new TypedMiddleware<AppState, FetchData>(fetchData),
  ]);
}

Middleware<AppState> _createFetchData() {
  return (Store store, action, NextDispatcher next) async {
    if (action is FetchData) {
      store.dispatch(SetIsLoading(isLoading: true));
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('Restaurants')
          .doc(action.restaurantId);
      DocumentSnapshot _snapshot = await documentReference.get();
      print('-------------------');
      print('Data ${_snapshot.data()}');
      // store.dispatch(FetchDataSuccess());
      store.dispatch(SetIsLoading(isLoading: false));
    }
    next(action);
  };
}
