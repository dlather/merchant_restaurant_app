import 'dart:async';

import 'package:flutter/material.dart';
import 'package:merchant_restaurant_app/middlewre/data_middleware.dart';
import 'package:merchant_restaurant_app/router.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import './model/app_state.dart';
import './reducers/app_reducer.dart';
import './middlewre/auth_middleware.dart';
import 'package:sentry/sentry.dart';
import './pages/initial_page.dart';

final sentry = SentryClient(
    dsn:
        "https://05dc4d59c56343b4bd9310dfa61ce8ba@o476622.ingest.sentry.io/5516591");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Example of Encrption and Decryption
  // String input = {
  //   'restaurantId': '23456789dfgfd345t',
  //   'item': 'table',
  //   'itemNo': '2',
  // }.toString();
  // final publicPem = await rootBundle.loadString('assets/test/public.pem');
  // final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
  // final privatePem = await rootBundle.loadString('assets/test/private.pem');
  // final privKey = RSAKeyParser().parse(privatePem) as RSAPrivateKey;
  // // final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));
  // final encrypter = Encrypter(RSA(publicKey: publicKey));

  // final encrypted = encrypter.encrypt(input);
  // print('Encrypt ${encrypted.base64}');
  // final decrypted = encrypter.decrypt(encrypted);
  // print(decrypted);

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
      ..add(NavigationMiddleware())
      ..add(new LoggingMiddleware.printer()),
  );
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: generateRoute,
        home: new InitialPage(),
      ),
    );
  }
}
