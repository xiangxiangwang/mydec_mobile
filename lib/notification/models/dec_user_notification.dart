import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dec_user_notification.g.dart';

@JsonSerializable()
class DecUserNotification {
  DecUserNotification();

  String id;
  String notificationId;
  String title;
  DateTime date;
  DateTime readDate;
  String content;

  String url;


  factory DecUserNotification.fromJson(Map<String,dynamic> json) => _$DecUserNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$DecUserNotificationToJson(this);
}
