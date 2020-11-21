import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {

  String name;
  String text;
  String url;
  String image;

  // whether it is a page or a URL
  bool openPage;

  // whether it is a page or a URL
  bool zoomLink;

  Menu();

  Menu.withValue(this.name,  this.text,  this.openPage, this.zoomLink, this.url,  this.image);


  factory Menu.fromJson(Map<String,dynamic> json) => _$MenuFromJson(json);
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
