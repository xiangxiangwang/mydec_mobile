
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/sunday_service/models/sunday_service_menu.dart';

import '../../web_view_page.dart';



class SundayServicePage extends StatefulWidget {
  @override
  _SundayServicePageState createState() => _SundayServicePageState();
}

class _SundayServicePageState extends State<SundayServicePage> {

  List<SundayServiceMenu> _sundayServiceMenus = [];

  @override
  void initState() {
    super.initState();

    _initListTiles();


  }

  void _initListTiles() {
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
      "youtube", "Youtube", "click here to see youtube channel", "youtube.png", "https://www.youtube.com/watch?v=Xqz_n3duoH0&feature=youtu.be"
    ));
    _sundayServiceMenus.add(SundayServiceMenu.withValue(
        "youtube2", "Youtube 2", "22 click here to see youtube channel", "youtube.png", "https://www.youtube.com/watch?v=DSjLDPXf514"
    ));

  }

  @override
  Widget build(BuildContext context) {
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

