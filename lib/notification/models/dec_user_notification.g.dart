// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dec_user_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DecUserNotification _$DecUserNotificationFromJson(Map<String, dynamic> json) {
  return DecUserNotification()
    ..id = json['id'] as String
    ..notificationId = json['notificationID'] as String
    ..title = json['title'] as String
    ..url = json['url'] as String
    ..date = DateTime.parse(json['date'] as String)
    ..readDate = json['readDate'] == null ? null : DateTime.parse(json['readDate'] as String)
    ..content = json['content'] as String
  ;
}

Map<String, dynamic> _$DecUserNotificationToJson(DecUserNotification instance) => <String, dynamic>{
      'id': instance.id,
      'notificationId': instance.notificationId,
      'title': instance.title,
      'url': instance.url,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(instance.date),
      'readDate': instance.readDate == null ? '' : DateFormat('yyyy-MM-dd HH:mm:ss').format(instance.readDate),
      'content': instance.content
    };
