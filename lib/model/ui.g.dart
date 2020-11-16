// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ui _$UiFromJson(Map<String, dynamic> json) {
  return Ui(
    selectedBottomNavTab: json['selectedBottomNavTab'] as int,
    bottomNavTabs:
        (json['bottomNavTabs'] as List)?.map((e) => e as String)?.toList(),
    appBarTitles:
        (json['appBarTitles'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UiToJson(Ui instance) => <String, dynamic>{
      'selectedBottomNavTab': instance.selectedBottomNavTab,
      'bottomNavTabs': instance.bottomNavTabs,
      'appBarTitles': instance.appBarTitles,
    };
