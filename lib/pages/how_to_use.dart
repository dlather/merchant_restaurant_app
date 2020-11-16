import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HowToUse extends StatefulWidget {
  @override
  _HowToUseState createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[100],
          iconTheme: IconThemeData(
            color: Colors.black54,
          ),
          title: Text(
            'How to use',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Lottie.asset(
                  'assets/scan-to-order.json',
                  height: MediaQuery.of(context).size.height - 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
            ListTile(
              title: Text('Scan'),
            ),
            ListTile(
              title: Text('Order'),
            ),
            ListTile(
              title: Text('Pay'),
            ),
            Container(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
