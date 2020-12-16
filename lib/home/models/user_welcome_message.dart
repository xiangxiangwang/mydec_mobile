import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_welcome_message.g.dart';

@JsonSerializable()
class UserWelcomeMessage {
  UserWelcomeMessage();

  String id;
  String welcomeMessageId;
  String title;
  String subtitle;
  DateTime date;
  DateTime readDate;

  bool readFlag;
  String imageUrl;


  factory UserWelcomeMessage.fromJson(Map<String,dynamic> json) => _$UserWelcomeMessageFromJson(json);
  Map<String, dynamic> toJson() => _$UserWelcomeMessageToJson(this);
}
