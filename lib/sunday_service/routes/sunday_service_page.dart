
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/appbar.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/sunday_service/models/sunday_service_menu.dart';
import 'package:mydec/sunday_service/services/sunday_service.dart';
import 'package:mydec/zoom/meeting_screen.dart';

import '../../common/web_view_page.dart';



class SundayServicePage extends StatefulWidget {
  @override
  _SundayServicePageState createState() => _SundayServicePageState();
}

class _SundayServicePageState extends State<SundayServicePage> {


  Timer timer;

  bool _hasNotification = false;

//   List<SundayServiceMenu> _sundayServiceMenus = [];

  // Map<String,String> sundayServiceLinks;

  @override
  void initState() {
    super.initState();
    _hasNotification = Global.hasNotification();
    Global.eventBus.on("hasNotificationFlagChange", (arg) {
      setState(() {
        _hasNotification = arg;
      });
      // do something
    });
  }
  /***
  void _initListTiles(BuildContext context) {

    _sundayServiceMenus = [];

    _sundayServiceMenus.add(SundayServiceMenu.withValue(
      "sundayServiceLive",
        DecLocalizations.of(context).sundayServiceLive,
        DecLocalizations.of(context).sundayServiceLiveSubtitle,
        "sunday_service_live.png",
        "https://youtu.be/Xqz_n3duoH0"
    ));
    _sundayServiceMenus.add(SundafyServiceMenu.withValue(
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
        "zoom@4981601988"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServicePray",
        DecLocalizations.of(context).sundayServicePray,
        DecLocalizations.of(context).sundayServicePraySubtitle,
        "sunday_service_pray.png",
        "zoom@99357666623"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceWeeklyReport",
        DecLocalizations.of(context).sundayServiceWeeklyReport,
        DecLocalizations.of(context).sundayServiceWeeklyReportSubtitle,
        "sunday_service_weekly_report.png",
        "https://drive.google.com/drive/folders/18cUJaVuZZakia5bDKjI97fpSnzfttAGJ"
    ));

    _initSundayServiceLinks();

  }
  _initSundayServiceLinks() async {
    sundayServiceLinks = await SundayServiceService.getAllSundayServiceLinks();

  }
      ***/
  @override
  Widget build(BuildContext context) {
    // _initListTiles(context);
    return Scaffold(
        appBar: buildAppBar(context,
            DecLocalizations.of(context).home,null, _hasNotification),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    /***
     * As of 11/29/2020, we will not use the list any more
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
        ***/
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        InkWell(
          onTap: () => _openPage("sunday_service_live", DecLocalizations.of(context).sundayServiceLive),
          child: Container(
             child: Image.asset('assets/images/card_sunday_service_live.png', fit: BoxFit.fitHeight,
                 width: MediaQuery.of(context).size.width),
          )
        ),
        Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => _openPage("zoom@4981601988", ""),
              child: Container(
                child: Image.asset('assets/images/card_sunday_service_kids.png', fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width /2),
              ),
            ),
            InkWell(
              onTap: () => _openPage("zoom@99357666623", ""),
              child: Container(
                child: Image.asset('assets/images/card_sunday_service_pray.png', fit: BoxFit.fitHeight,
                  width: MediaQuery.of(context).size.width /2),
              ),
            ),

          ]
        )
      ]
    );

  }
  _openPage(String url, String title){
    if (url.startsWith("zoom")) {
      // for zoom, the url will be in the format of
      // zoom@meetingId:password
      url = url.substring(6);
      print("start to open zoom: $url");
      List<String> zoomLinkInfo = url.split(":");
      String meetingId = zoomLinkInfo[0];
      String password = "";
      if (zoomLinkInfo.length > 1) {
        password = zoomLinkInfo[1];
      }
      _joinZoomMeeting(context, meetingId, password);

    }
    else if (url.startsWith("http")) {
      // Navigator.of(context).pushNamed("web_view_page", arguments: sundayServiceMenu.url);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) {
        return new Browser(
          url: url,
          title: title,
        );
      }));
    }
    else {
      Navigator.of(context).pushNamed(url);
    }
  }

  /***
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

    String url = sundayServiceLinks.containsKey(sundayServiceMenu.name) ?
        sundayServiceLinks[sundayServiceMenu.name] : sundayServiceMenu.url;
    if (url.startsWith("zoom")) {
      // for zoom, the url will be in the format of
      // zoom@meetingId:password
      url = url.substring(6);
      print("start to open zoom: $url");
      List<String> zoomLinkInfo = url.split(":");
      String meetingId = zoomLinkInfo[0];
      String password = "";
      if (zoomLinkInfo.length > 1) {
        password = zoomLinkInfo[1];
      }
      _joinZoomMeeting(context, meetingId, password);

    }
    else {


      // Navigator.of(context).pushNamed("web_view_page", arguments: sundayServiceMenu.url);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) {
        return new Browser(
          url: url,
          title: sundayServiceMenu.title,
        );
      }));
    }


  }
   **/

  _joinZoomMeeting(BuildContext context, String meetingId, String password) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MeetingWidget(meetingId: meetingId, meetingPassword: password);
        },
      ),
    );
  }


}

