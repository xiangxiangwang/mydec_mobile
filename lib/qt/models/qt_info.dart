import 'package:json_annotation/json_annotation.dart';

part 'qt_info.g.dart';

@JsonSerializable()
class QTInfo {
  QTInfo();


  String date;
  String title;
  String content;
  String pageUrl;
  String videoUrl;



  factory QTInfo.fromJson(Map<String,dynamic> json) => _$QTInfoFromJson(json);
  Map<String, dynamic> toJson() => _$QTInfoToJson(this);
}
