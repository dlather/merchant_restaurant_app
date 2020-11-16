import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

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
  Map _dataJson = {
    'restaurantId': '123456789',
    'item': 'table',
    'itemNo': '1',
  };

  @override
  Widget build(BuildContext context) {
    return _contentWidget();
  }

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      await Share.file(
          'title',
          '${_dataJson['item']}-${_dataJson['itemNo']}.png',
          pngBytes,
          'image/png',
          text: '${_dataJson['item']}-${_dataJson['itemNo']}');
    } catch (e) {
      print(e.toString());
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        _dataJson['item'] = result.toLowerCase();
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
                        _dataJson['itemNo'] = result.toLowerCase();
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
                    data: _dataJson.toString(),
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
  }
}
