
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



class SundayServiceLivePage extends StatefulWidget {
  @override
  _SundayServiceLivePageState createState() => _SundayServiceLivePageState();
}

class _SundayServiceLivePageState extends State<SundayServiceLivePage> {


  Timer timer;

  bool _hasNotification = false;
  List<SundayServiceMenu> _sundayServiceMenus = [];

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
  void _initListTiles(BuildContext context) {
    _sundayServiceMenus = [];

    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceLiveZoom",
        DecLocalizations
            .of(context)
            .sundayServiceLiveZoom,
        "",
        DecLocalizations.of(context).password + ":dec",
        "zoom_logo.png",
        "zoom@6266783619:12345"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "sundayServiceLiveYoutube",
        DecLocalizations
            .of(context)
            .sundayServiceLiveYoutube,
        "","",
        "youtube_logo.png",
        "https://youtu.be/Xqz_n3duoH0"
    ));
  }
  @override
  Widget build(BuildContext context) {
     _initListTiles(context);
    return Scaffold(
        appBar: buildAppBar(context,
            DecLocalizations.of(context).sundayService, null, _hasNotification),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          child: Container(
             child: Image.asset('assets/images/card_sunday_service_live.png', fit: BoxFit.fitHeight,
                 width: MediaQuery.of(context).size.width),
          )
        ),
        Text(DecLocalizations.of(context).sundayServiceChinese),
        Text(DecLocalizations.of(context).sundayServiceTime),
        SizedBox(
         height: MediaQuery.of(context).size.height-24-56-56,
            child:
              ListView.separated(
                  itemCount: _sundayServiceMenus.length,
                  //列表项构造器
                  itemBuilder: (BuildContext context, int index) {
                    return _getListTile(index);
                  },
                //分割器构造器
                  separatorBuilder: (BuildContext context, int index) {
                    return  Divider(color: Colors.blue);
                  },
              )
        )
      ]
    );

  }

  ListTile _getListTile(int index) {
    return ListTile(
      dense: true,
      leading: Image(image: AssetImage("assets/images/${_sundayServiceMenus[index].image}"), height: 55.0),
      title: Text(_sundayServiceMenus[index].title),
      // subtitle:Text(_sundayServiceMenus[index].subtitle),
     // trailing: _sundayServiceMenus[index].trailing.isNotEmpty?
      //    Text(_sundayServiceMenus[index].trailing,        textScaleFactor: .9) : null,
      onTap: () => _openPage(_sundayServiceMenus[index].url, _sundayServiceMenus[index].title ),
    );
  }

  _openPage(String url, String title){
    if (url.startsWith("zoom")) {
      // for zoom, the url will be in the format of
      // zoom@meetingId:password
      url = url.substring(5);
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
          title: title,
        );
      }));
    }
  }


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

