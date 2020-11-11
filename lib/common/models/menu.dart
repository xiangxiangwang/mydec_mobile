import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {

  String name;
  String text;
  String url;
  String image;

  Menu();

  Menu.withValue(this.name,  this.text,  this.url,  this.image);


  factory Menu.fromJson(Map<String,dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
