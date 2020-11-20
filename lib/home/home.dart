
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';

import '../web_view_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Menu> _menuList = [];

  @override
  void initState() {
    super.initState();


  }
  
  @override
  Widget build(BuildContext context) {

    _menuList.add(new Menu.withValue("sunnay_service", DecLocalizations.of(context).sundayService, true, "sunday_service", "icon-worship-live.png"));
    _menuList.add(new Menu.withValue("daily_qt", DecLocalizations.of(context).dailyQt, true, "qt_list", "icon-bible-with-label.png"));
    _menuList.add(new Menu.withValue("morning_pray", DecLocalizations.of(context).morningPray, false, "https://zoom.us/j/3070131323", "icon-pray-hands.png"));
    _menuList.add(new Menu.withValue("class_learning", DecLocalizations.of(context).classLearning, false, "404", "icon-bible-study.png"));
    _menuList.add(new Menu.withValue("church_group", DecLocalizations.of(context).churchGroup, false, "404", "icon-church-group.png"));
    _menuList.add(new Menu.withValue("donation", DecLocalizations.of(context).donation, false, "https://dec4u.org/%e7%b7%9a%e4%b8%8a%e5%a5%89%e7%8d%bb/", "icon-offering-bag.png"));
    _menuList.add(new Menu.withValue("faith_confession", DecLocalizations.of(context).faithConfession, false, "https://dec4u.org/%e4%bf%a1%e4%bb%b0%e5%91%8a%e7%99%bd/", "icon-fish.png"));
    _menuList.add(new Menu.withValue("our_vision", DecLocalizations.of(context).ourVision, false, "https://dec4u.org/%e6%88%91%e5%80%91%e7%9a%84%e7%95%b0%e8%b1%a1/", "icon-trinity.png"));

    return Scaffold(

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
          Image(image: AssetImage("assets/images/banner.png")),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            children: _getTiles(_menuList),
          ),
        ], // 构建主页面
        // drawer: MyDrawer(), //抽屉菜单
      );

  }

  // Function to be called on click
  void _onTileClicked(Menu menu){
    print("menu ${menu.name} clicked with url: ${menu.url}, empty? ${menu.url.isEmpty}, menu.openPage? ${menu.openPage}");
    if (menu.url.isEmpty) {
      return;
    }
    if (menu.openPage == true) {

      Navigator.of(context).pushNamed(menu.url);
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



}

