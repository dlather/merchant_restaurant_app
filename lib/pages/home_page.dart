// pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:merchant_restaurant_app/actions/ui.dart';
import 'package:merchant_restaurant_app/model/app_state.dart';
import 'package:merchant_restaurant_app/widgets/qr.dart';
import 'package:redux/redux.dart';
import '../widgets/account.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Widget> bottomNavWidgets = [
    Center(
      child: Text('Home'),
    ),
    Center(
      child: Text('Orders'),
    ),
    Center(
      child: Text('Menu'),
    ),
    QrCode(),
    Account(),
  ];
  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      converter: _ViewModel.fromStore,
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              vm.appBarTitles[vm.selectedBottomNavTab],
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            backgroundColor: Colors.lightBlue[50],
          ),
          body: vm.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : bottomNavWidgets[vm.selectedBottomNavTab],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.lightBlue[50],
            currentIndex: vm.selectedBottomNavTab,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => vm.onBottomNavTabTap(value),
            items: [
              bottomNavigationBarItem(
                title: vm.bottomNavTabs[0],
                icon: Icon(Icons.home),
              ),
              bottomNavigationBarItem(
                title: vm.bottomNavTabs[1],
                icon: Icon(Icons.list),
              ),
              bottomNavigationBarItem(
                title: vm.bottomNavTabs[2],
                icon: Icon(Icons.restaurant_menu),
              ),
              bottomNavigationBarItem(
                title: vm.bottomNavTabs[3],
                icon: Icon(Icons.crop_free),
              ),
              bottomNavigationBarItem(
                title: vm.bottomNavTabs[4],
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final int selectedBottomNavTab;
  final List<String> bottomNavTabs;
  final List<String> appBarTitles;
  final bool isLoading;
  final Function(int value) onBottomNavTabTap;
  _ViewModel({
    this.selectedBottomNavTab,
    this.bottomNavTabs,
    this.appBarTitles,
    this.onBottomNavTabTap,
    this.isLoading,
  });
  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      selectedBottomNavTab: store.state.ui.selectedBottomNavTab,
      bottomNavTabs: store.state.ui.bottomNavTabs,
      appBarTitles: store.state.ui.appBarTitles,
      onBottomNavTabTap: (int value) =>
          store.dispatch(SetSelectedBottomNavTab(selectedBottomNavTab: value)),
      isLoading: store.state.isLoading,
    );
  }
}

BottomNavigationBarItem bottomNavigationBarItem({
  String title,
  Widget icon,
}) {
  return BottomNavigationBarItem(
    icon: icon,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
