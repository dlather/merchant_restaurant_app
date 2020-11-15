class Ui {
  final int selectedBottomNavTab;
  List<String> bottomNavTabs;
  List<String> appBarTitles;
  factory Ui.initial() => Ui(
        selectedBottomNavTab: 0,
        bottomNavTabs: ['Home', 'Orders', 'Menu', 'QR', 'Account'],
        appBarTitles: [
          'Home',
          'Orders',
          'Menu',
          'QR Code Generator',
          'Account'
        ],
      );
  Ui({this.selectedBottomNavTab, this.bottomNavTabs, this.appBarTitles});

  Ui copyWith({
    int selectedBottomNavTab,
    List<String> bottomNavTabs,
    List<String> appBarTitles,
  }) {
    return Ui(
      selectedBottomNavTab: selectedBottomNavTab ?? this.selectedBottomNavTab,
      bottomNavTabs: bottomNavTabs ?? this.bottomNavTabs,
      appBarTitles: appBarTitles ?? this.appBarTitles,
    );
  }
}
