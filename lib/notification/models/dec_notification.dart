import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dec_notification.g.dart';

@JsonSerializable()
class DecNotification {
  DecNotification();

  String id;
  String title;
  DateTime date;
  String content;


  factory DecNotification.fromJson(Map<String,dynamic> json) => _$DecNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$DecNotificationToJson(this);
}
