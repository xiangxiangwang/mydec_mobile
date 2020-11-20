// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qt_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QTInfo _$QTInfoFromJson(Map<String, dynamic> json) {
  return QTInfo()
    ..date = json['date'] as String
    ..title = json['title'] as String
    ..content = json['content'] as String
    ..pageUrl = json['pageUrl'] as String
    ..videoUrl = json['videoUrl'] as String
    ;
}

Map<String, dynamic> _$QTInfoToJson(QTInfo instance) => <String, dynamic>{
  'date': instance.date,
  'title': instance.title,
  'content': instance.content,
  'pageUrl': instance.pageUrl,
  'videoUrl': instance.videoUrl,
};
