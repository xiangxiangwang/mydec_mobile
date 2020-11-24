// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dec_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecNotification _$DecNotificationFromJson(Map<String, dynamic> json) {
  return DecNotification()
    ..id = json['id'] as String
    ..title = json['title'] as String
    ..date = DateTime.parse(json['date'] as String)
    ..content = json['content'] as String
  ;
}

Map<String, dynamic> _$DecNotificationToJson(DecNotification instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(instance.date),
      'content': instance.content
    };
