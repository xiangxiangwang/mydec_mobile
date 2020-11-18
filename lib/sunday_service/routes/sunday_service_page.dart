
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/sunday_service/models/sunday_service_menu.dart';

import '../../web_view_page.dart';



class SundayServicePage extends StatefulWidget {
  @override
  _SundayServicePageState createState() => _SundayServicePageState();
}

class _SundayServicePageState extends State<SundayServicePage> {


  Timer timer;


  List<SundayServiceMenu> _sundayServiceMenus = [];

  @override
  void initState() {
    super.initState();
  }

  void _initListTiles(BuildContext context) {
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
      "sundayServiceLive",
        DecLocalizations.of(context).sundayServiceLive,
        DecLocalizations.of(context).sundayServiceLiveSubtitle,
        "sunday_service_live.png",
        "https://youtu.be/Xqz_n3duoH0"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceYouth",
        DecLocalizations.of(context).sundayServiceYouth,
        DecLocalizations.of(context).sundayServiceYouthSubtitle,
        "sunday_service_youth.png",
        "https://www.youtube.com/watch?v=xvBB6xvtCgc&t=15s"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceKids",
        DecLocalizations.of(context).sundayServiceKids,
        DecLocalizations.of(context).sundayServiceKidsSubtitle,
        "sunday_service_kids.png",
        "https://zoom.us/j/4981601988"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServicePray",
        DecLocalizations.of(context).sundayServicePray,
        DecLocalizations.of(context).sundayServicePraySubtitle,
        "sunday_service_pray.png",
        "https://zoom.us/j/99357666623"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceWeeklyReport",
        DecLocalizations.of(context).sundayServiceWeeklyReport,
        DecLocalizations.of(context).sundayServiceWeeklyReportSubtitle,
        "sunday_service_weekly_report.png",
        "https://drive.google.com/drive/folders/18cUJaVuZZakia5bDKjI97fpSnzfttAGJ"
    ));


  }

  @override
  Widget build(BuildContext context) {
    _initListTiles(context);
    return Scaffold(
        appBar: AppBar(title: Text("主日崇拜")),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      itemCount: _sundayServiceMenus.length,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return _getListTile(index);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return  Divider(color: Colors.blue);
      },
    );

    /***
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Image(image: AssetImage("assets/images/youtube.png"), height: 35.0),
          title: Text("Youtube",        textScaleFactor: .9),
          subtitle:Text("click here to see youtube channel"),
        )]
    );
        **/
  }

  ListTile _getListTile(int index) {
    return ListTile(
      dense: true,
      leading: Image(image: AssetImage("assets/images/${_sundayServiceMenus[index].image}"), height: 55.0),
      title: Text(_sundayServiceMenus[index].title,        textScaleFactor: .9),
      subtitle:Text(_sundayServiceMenus[index].subtitle),
      onTap: () => _onTileClicked(_sundayServiceMenus[index]),
    );
  }
  _onTileClicked(SundayServiceMenu sundayServiceMenu) {
    print("${sundayServiceMenu.url} starts With zoom? ${sundayServiceMenu.url.startsWith("zoom")}");

    if (sundayServiceMenu.url.startsWith("zoom")) {

    }
    else {

      // Navigator.of(context).pushNamed("web_view_page", arguments: sundayServiceMenu.url);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) {
        return new Browser(
          url: sundayServiceMenu.url,
          title: sundayServiceMenu.title,
        );
      }));
    }


  }



}

