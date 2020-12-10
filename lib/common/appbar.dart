import 'package:flutter/material.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/notification/services/notification_info.dart';

import 'models/global.dart';


Widget buildAppBar(BuildContext context, String title,  Widget leading, bool hasNotification) {

  DecUser _currentUser = Global.getCurrentUser();


  return AppBar(
      iconTheme: IconThemeData(
          color: Colors.black26
      ),
      toolbarHeight: 30,
      backgroundColor: Colors.transparent,
      //  backgroundColor: Color(0x44000000),
      leading: leading,
      elevation: 0,
      title: Text(title,  style: TextStyle(fontSize: 14,
          color: Colors.black26, fontStyle: FontStyle.italic
      )),
      actions: <Widget>[
        InkWell(
          onTap: () => _showNotification(context),
          child: Container(
       //     child: Image.asset('assets/images/icon-alarm-bell-ring.png'),
            child: hasNotification ?
            Image(image:AssetImage('assets/images/notification_icon.png'), fit: BoxFit.contain,height:22, width:22 ):
            Image(image:AssetImage('assets/images/icon-alarm-bell-ring.png'), fit: BoxFit.contain,height:22, width:22 )
          ),
        ),
        InkWell(
          onTap: () => _showAccount(context),
          child: Container(
            child: ClipOval(
              child: _currentUser.imageNetworkPath == null || _currentUser.imageNetworkPath == ""
                  ? Image(image: AssetImage("assets/images/empty_user.png") , fit: BoxFit.contain, height:22, width:22 )
                  : Image.network(_currentUser.imageNetworkPath,  fit: BoxFit.fitWidth),
            ),
          ),
        ),
      ]
  );


}

_showNotification(BuildContext context){

  Navigator.of(context).pushNamed("notification_history");
}
_showAccount(BuildContext context){

  Navigator.of(context).pushNamed("account");
}

