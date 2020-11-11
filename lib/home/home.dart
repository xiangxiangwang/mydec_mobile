
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/models/menu.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Menu> _menuList = [];

  @override
  void initState() {
    super.initState();
    // check if auto login
    Menu menu = new Menu.withValue("sunnay_service", "主日崇拜", "sunday_service", "sunday_service.png");

    print("menu: ${menu.image}");
    _menuList.add(menu);

  }
  
  @override
  Widget build(BuildContext context) {
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
            /***
            children: <Widget>[
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(image: AssetImage("assets/images/sunday_service.png"), height: 55),
                    Text("主日崇拜"),
                  ])
            ],
                ***/
          ),
        ], // 构建主页面
        // drawer: MyDrawer(), //抽屉菜单
      );

  }

  // Function to be called on click
  void _onTileClicked(Menu menu){
    debugPrint("You tapped on item ${menu.url}");
    Navigator.of(context).pushNamed(menu.url);
  }

// Get grid tiles
  List<Widget> _getTiles(List<Menu> menuList) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < menuList.length; i++) {
      print("start to get image ${menuList[i].image}");
      tiles.add(new GridTile(
          child: new InkResponse(
            enableFeedback: true,
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("assets/images/${menuList[i].image}"), height: 55),
                  Text("主日崇拜"),
                ]),
            // Image(image: AssetImage("assets/images/$image"), height: 35),
            onTap: () => _onTileClicked(menuList[i]),
          )));
    }
    return tiles;
  }



}

