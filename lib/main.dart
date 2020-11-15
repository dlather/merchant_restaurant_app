// import 'package:flutter/material.dart';

// import 'sign_in.dart';
// import 'login_page.dart';
// import 'home_page.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isLoading = true;
//   bool isUserLoggedIn = false;
//   @override
//   void initState() {
//     isLoggedIn().then((result) {
//       setState(() {
//         isUserLoggedIn = result;
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(child: CircularProgressIndicator())
//         : MaterialApp(
//             title: 'Merchant Order App',
//             theme: ThemeData(
//               primarySwatch: Colors.lightBlue,
//             ),
//             home: isUserLoggedIn ? HomePage() : LoginPage(),
//           );
//   }
// }

// main.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:merchant_restaurant_app/middlewre/data_middleware.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import './model/app_state.dart';
import './reducers/app_reducer.dart';
import './middlewre/auth_middleware.dart';
import 'package:sentry/sentry.dart';
import './pages/initial_page.dart';

final sentry = SentryClient(
    dsn:
        "https://05dc4d59c56343b4bd9310dfa61ce8ba@o476622.ingest.sentry.io/5516591");

void main() async {
  runZonedGuarded(
    () => runApp(MainApp()),
    (error, stackTrace) async {
      await sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    },
  );
}

class MainApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.initial(),
    middleware: []
      ..addAll(createAuthMiddleware())
      ..addAll(createDataMiddleware())
      ..add(new LoggingMiddleware.printer()),
  );
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        home: new InitialPage(),
      ),
    );
  }
}
