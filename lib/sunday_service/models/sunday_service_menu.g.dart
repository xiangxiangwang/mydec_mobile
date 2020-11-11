// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sunday_service_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SundayServiceMenu _$SundayServiceMenuFromJson(Map<String, dynamic> json) {
  return SundayServiceMenu()
    ..name = json['name'] as String
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..url = json['url'] as String
    ..image = json['image'] as String;
}

Map<String, dynamic> _$SundayServiceMenuToJson(SundayServiceMenu instance) =>
    <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'url': instance.url,
      'image': instance.image,
    };
