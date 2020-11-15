import 'package:redux/redux.dart';
import '../actions/common_actions.dart';

final Reducer<bool> commonReducer = combineReducers([
  new TypedReducer<bool, SetIsLoading>(_setIsLoading),
]);

bool _setIsLoading(bool isLoading, action) {
  if (action is SetIsLoading) {
    return action.isLoading;
  }
  return isLoading;
}
