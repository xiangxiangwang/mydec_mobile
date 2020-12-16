// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_welcome_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWelcomeMessage _$UserWelcomeMessageFromJson(Map<String, dynamic> json) {
  return UserWelcomeMessage()
    ..id = json['id'] as String
    ..welcomeMessageId = json['welcomeMessageId'] as String
    ..readFlag = json['readFlag'].toString().toLowerCase() == "true"
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..imageUrl = json['imageUrl'] as String
    ..date = DateTime.parse(json['date'] as String)
    ..readDate = json['readDate'] == null ? null : DateTime.parse(json['readDate'] as String)
  ;
}

Map<String, dynamic> _$UserWelcomeMessageToJson(UserWelcomeMessage instance) => <String, dynamic>{
      'id': instance.id,
      'welcomeMessageId': instance.welcomeMessageId,
      'readFlag': instance.readFlag,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'imageUrl': instance.imageUrl,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(instance.date),
      'readDate': instance.readDate == null ? '' : DateFormat('yyyy-MM-dd HH:mm:ss').format(instance.readDate)
    };
