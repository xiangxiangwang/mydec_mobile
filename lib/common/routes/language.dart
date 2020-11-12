

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    // var localeModel = Provider.of<LocaleModel>(context);
    var gm = DecLocalizations.of(context);
    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          // style: TextStyle(color: localeModel.locale == value ? color : null),
        ),
        trailing:
            // localeModel.locale == value ? Icon(Icons.done, color: color) : null,
            Icon(Icons.done, color: color),
        onTap: () {
          // 此行代码会通知MaterialApp重新build
          // localeModel.locale = value;
        print("on tab");
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}
