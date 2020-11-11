
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/sunday_service/models/sunday_service_menu.dart';

import '../../web_view_page.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Account")),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildAccountHeader(), //构建抽屉菜单头部
        Expanded(child: _buildAccountMenus()), //构建功能菜单
      ],
    )

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

  Widget _buildAccountHeader() {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                      Image.asset(
                      "assets/images/google_logo.png",
                      width: 80,
                    ),
                  ),
                ),
                Text(
                  value.isLogin
                      ? value.user.login
                      : GmLocalizations.of(context).login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) Navigator.of(context).pushNamed("login");
          },
        );
  }



}

