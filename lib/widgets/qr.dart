import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/actions/common_actions.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:redux/redux.dart';

class QrCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QrCodeState();
}

class QrCodeState extends State<QrCode> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  List<String> selectItem = ['Table', 'Room'];
  String selectedItem = 'Table';
  var selectNumber = new List<int>.generate(10, (i) => i + 1);
  String selectedNumber = '1';
  var encrypter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.loadString('assets/test/public.pem').then((publicPem) {
      final publicKey = RSAKeyParser().parse(publicPem) as RSAPublicKey;
      setState(() {
        encrypter = Encrypter(RSA(publicKey: publicKey));
      });
    }).catchError((err) {
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return encrypter == null
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          )
        : StoreConnector(
            builder: (BuildContext context, _ViewModel vm) {
              final bodyHeight = MediaQuery.of(context).size.height -
                  MediaQuery.of(context).viewInsets.bottom;
              return vm.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      color: const Color(0xffffff),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: _topSectionTopPadding,
                              left: 20.0,
                              right: 10.0,
                              bottom: _topSectionBottomPadding,
                            ),
                            child: Container(
                              height: _topSectionHeight,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  DropdownButton(
                                    items: selectItem
                                        .map((item) => DropdownMenuItem(
                                              child: Text(item),
                                              value: item,
                                            ))
                                        .toList(),
                                    onChanged: (String result) {
                                      setState(() {
                                        selectedItem = result;
                                      });
                                    },
                                    value: selectedItem,
                                  ),
                                  DropdownButton(
                                    items: selectNumber
                                        .map((item) => DropdownMenuItem(
                                              child: Text(item.toString()),
                                              value: item.toString(),
                                            ))
                                        .toList(),
                                    onChanged: (String result) {
                                      setState(() {
                                        selectedNumber = result;
                                        // _dataJson['itemNo'] = result.toLowerCase();
                                      });
                                    },
                                    value: selectedNumber.toString(),
                                  ),
                                  RaisedButton(
                                    onPressed: _captureAndSharePng,
                                    color: Colors.lightBlue[50],
                                    child: Text(
                                      'Share',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: RepaintBoundary(
                                key: globalKey,
                                child: Container(
                                  color: Colors.white,
                                  child: QrImage(
                                    backgroundColor: Colors.transparent,
                                    data: 'https://beyondthread.in/' +
                                        encrypter
                                            .encrypt({
                                              'restaurantId': vm.restaurantId,
                                              'item':
                                                  selectedItem.toLowerCase(),
                                              'itemNo':
                                                  selectedNumber.toLowerCase(),
                                            }.toString())
                                            .base64,
                                    size: 0.5 * bodyHeight,
                                    version: QrVersions.auto,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
            },
            converter: _ViewModel.fromStore,
          );
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      await Share.file(
          'title', '$selectedItem-$selectedNumber.png', pngBytes, 'image/png',
          text: '$selectedItem-$selectedNumber');
    } catch (e) {
      print(e.toString());
    }
  }
}

class _ViewModel {
  final String restaurantId;
  final bool isLoading;
  _ViewModel({
    this.restaurantId,
    this.isLoading,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      restaurantId: store.state.restaurantDetails.restaurantId,
      isLoading: store.state.isLoading,
    );
  }
}
