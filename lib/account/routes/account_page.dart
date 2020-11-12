
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/funs.dart';
import 'package:mydec/common/google_sign_in.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/i10n/localization_intl.dart';
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
        appBar: AppBar(title: Text(DecLocalizations.of(context).accountDisplay)),
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

  Widget _buildAccountHeader() {
      return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            // padding: EdgeInsets.only(top: 40, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ClipOval(
                        child: Image(image: AssetImage("assets/images/empty_user.png"), height: 135.0),
                      ),
                    ),
                    Text(
                      getCurrentUser(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ]
            )

          ),
        );
  }


  // 构建菜单项
  Widget _buildAccountMenus() {

        return ListView(
          children: <Widget>[
            /***
            ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text(DecLocalizations.of(context).theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
                ***/
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(DecLocalizations.of(context).language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            ListTile(
              leading: const Icon(Icons.power_settings_new),
              title: Text(DecLocalizations.of(context).logout),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    //退出账号前先弹二次确认窗
                    return AlertDialog(
                      content: Text(DecLocalizations.of(context).logoutTip),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(DecLocalizations.of(context).cancel),
                          onPressed: () => Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text(DecLocalizations.of(context).yes),
                          onPressed: () {
                            // sign out and flow to the first page
                            signOutGoogle();
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        );

  }

}

