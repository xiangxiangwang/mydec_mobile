import 'package:json_annotation/json_annotation.dart';

part 'sunday_service_menu.g.dart';

@JsonSerializable()
class SundayServiceMenu {

  String name;
  String title;
  String subtitle;
  String image;
  String url;

  SundayServiceMenu();

  SundayServiceMenu.withValue(this.name,  this.title,  this.subtitle,  this.image, this.url);


  factory SundayServiceMenu.fromJson(Map<String,dynamic> json) => _$SundayServiceMenuFromJson(json);
  Map<String, dynamic> toJson() => _$SundayServiceMenuToJson(this);
}
