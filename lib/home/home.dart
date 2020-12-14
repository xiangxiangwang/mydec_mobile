
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/appbar.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/zoom/meeting_screen.dart';

import '../common/web_view_page.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Menu> _menuList = [];
  List<String> _carouselImageList = [];
 
  bool _hasNotification = false;

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

  _initMenuList(){
    _menuList.clear();
    _menuList.add(new Menu.withValue("sunnay_service", DecLocalizations.of(context).sundayService, true, false, "sunday_service", "icon-worship-live.png"));
    _menuList.add(new Menu.withValue("daily_qt", DecLocalizations.of(context).dailyQt, true, false, "qt_list", "icon-bible-with-label.png"));
    _menuList.add(new Menu.withValue("morning_pray", DecLocalizations.of(context).morningPray, false, true, "3070131323", "icon-pray-hands.png"));
    _menuList.add(new Menu.withValue("class_learning", DecLocalizations.of(context).classLearning, false,false,  "404", "icon-bible-study.png"));
    _menuList.add(new Menu.withValue("church_group", DecLocalizations.of(context).churchGroup, false, false, "https://docs.google.com/forms/d/e/1FAIpQLSc4qxJqp9zOUh8-TKYyjGBSNY-BzKpWIGmhaDxfC0kBILBjmQ/viewform", "icon-church-group.png"));
    _menuList.add(new Menu.withValue("donation", DecLocalizations.of(context).donation, false, false, "https://dec4u.org/%e7%b7%9a%e4%b8%8a%e5%a5%89%e7%8d%bb/", "icon-offering-bag.png"));
    _menuList.add(new Menu.withValue("faith_confession", DecLocalizations.of(context).faithConfession, false, false,  "https://dec4u.org/%e4%bf%a1%e4%bb%b0%e5%91%8a%e7%99%bd/", "icon-fish.png"));
    _menuList.add(new Menu.withValue("our_vision", DecLocalizations.of(context).ourVision, false, false, "https://dec4u.org/%e6%88%91%e5%80%91%e7%9a%84%e7%95%b0%e8%b1%a1/", "icon-trinity.png"));
    //_menuList.add(new Menu.withValue("our_vision", DecLocalizations.of(context).ourVision, false, false, "http://52.53.193.119/", "icon-trinity.png"));
    // _menuList.add(new Menu.withValue("our_vision", DecLocalizations.of(context).ourVision, false, false, "https://firebasestorage.googleapis.com/v0/b/mydec-9160b.appspot.com/o/html%2Fnotification01.html?alt=media&token=c54292ce-0a6d-43f2-afaf-d3b537f220e8", "icon-trinity.png"));
    _menuList.add(new Menu.withValue("notification_history", DecLocalizations.of(context).notificationHistory, true, false, "notification_history", "icon-trinity.png"));
  }
  _initCarouselImageList(){
    _carouselImageList.clear();
    _carouselImageList.add("banner.png");
    _carouselImageList.add("card_sunday_service_kids.png");
    _carouselImageList.add("card_sunday_service_live.png");
    _carouselImageList.add("card_sunday_service_pray.png");

  }
  
  @override
  Widget build(BuildContext context) {
    _initMenuList();
    _initCarouselImageList();


    DecUser _currentUser = Global.getCurrentUser();

    String username = _currentUser.firstName.isNotEmpty ?
        _currentUser.firstName + " " + _currentUser.lastName
        :
        _currentUser.email;
    return Scaffold(
          extendBodyBehindAppBar: false,
          appBar: buildAppBar(context,
              DecLocalizations.of(context).greetingMessage(username),
              Image(image: AssetImage("assets/images/header_logo.png")),
              _hasNotification),
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
          // FlutterLogo(size: 150),
         // Image(image: AssetImage("assets/images/banner.png")),
          CarouselSlider(
            options: CarouselOptions(height: 250.0),
            items: _carouselImageList.map((item) => Container(
              margin: EdgeInsets.all(5.0),
              child: Center(
                  child: Image(image: AssetImage("assets/images/" + item), fit: BoxFit.cover, width: 1000)
              ),
            )).toList(),
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            padding: EdgeInsets.zero,
            children: _getTiles(_menuList),
          ),
        ], // 构建主页面
        // drawer: MyDrawer(), //抽屉菜单
      );

  }

  // Function to be called on click
  void _onTileClicked(Menu menu){

    if (menu.url.isEmpty) {
      return;
    }
    if (menu.openPage == true) {

      Navigator.of(context).pushNamed(menu.url);
    }
    else if (menu.zoomLink == true) {
      List<String> zoomLinkInfo = menu.url.split(":");
      String meetingId = zoomLinkInfo[0];
      String password = "";
      if (zoomLinkInfo.length > 1) {
        password = zoomLinkInfo[1];
      }
      _joinZoomMeeting(context, meetingId, password);

      
    }
    else {
      // we will use the web view to open the URL
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) {
        return new Browser(
          url: menu.url,
          title: menu.text,
        );
      }));
    }
  }

// Get grid tiles
  List<Widget> _getTiles(List<Menu> menuList) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < menuList.length; i++) {
      tiles.add(new GridTile(
          child: new InkResponse(
            enableFeedback: true,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("assets/images/${menuList[i].image}"), height: 55),
                  Text(menuList[i].text),
                ]),
            // Image(image: AssetImage("assets/images/$image"), height: 35),
            onTap: () => _onTileClicked(menuList[i]),
          )));
    }
    return tiles;
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

