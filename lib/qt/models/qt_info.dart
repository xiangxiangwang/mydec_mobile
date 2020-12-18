import 'package:json_annotation/json_annotation.dart';

part 'qt_info.g.dart';

@JsonSerializable()
class QTInfo {
  QTInfo();


  String date;
  String title;
  String subtitle;
  String content;
  String pageUrl;
  String videoUrl;



  factory QTInfo.fromJson(Map<String,dynamic> json) {
    QTInfo qtInfo = _$QTInfoFromJson(json);
    // let's see if we can substract the qt subtitle from the title
    // in case the title is in the format of
    // 在家庭和教会中 延续祝福的基督徒 (彼得前书 3:1~12)
    // Then the first part become title and the
    // second part that in the brackets become subtitle
    int titleBracketStartIndex = -1;
    int titleBracketEndIndex = -1;
    if (qtInfo.title.contains("(")) {
      titleBracketStartIndex = qtInfo.title.indexOf("(");

    }
    else if (qtInfo.title.contains("（")) {
      titleBracketStartIndex = qtInfo.title.indexOf("（");
    }
    if (titleBracketStartIndex > 0) {
      if (qtInfo.title.contains(")")) {
        titleBracketEndIndex = qtInfo.title.indexOf(")");

      }
      else if (qtInfo.title.contains("）")) {
        titleBracketEndIndex = qtInfo.title.indexOf("）");
      }
      if (titleBracketEndIndex > titleBracketStartIndex) {

        // print("qtInfo.title: ${qtInfo.title}");
        if (qtInfo.subtitle == null || qtInfo.subtitle.isEmpty) {
          // only replace the sub title when it is empty
          // print("titleBracketStartIndex: $titleBracketStartIndex, titleBracketEndIndex: $titleBracketEndIndex");
          qtInfo.subtitle =  qtInfo.title.substring(titleBracketStartIndex + 1, titleBracketEndIndex);
        }
        qtInfo.title = qtInfo.title.substring(0, titleBracketStartIndex);
      }
    }
    return qtInfo;
  }
  Map<String, dynamic> toJson() => _$QTInfoToJson(this);
}
