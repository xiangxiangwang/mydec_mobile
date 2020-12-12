
import 'dart:async';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/notification/services/notification_info.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:video_player/video_player.dart';




class NotificationInfoPage extends StatefulWidget {
  @override
  _NotificationInfoPageState createState() => _NotificationInfoPageState();
}

class _NotificationInfoPageState extends State<NotificationInfoPage> {

  @override
  Widget build(BuildContext context) {
    DecUserNotification decUserNotification = ModalRoute.of(context).settings.arguments;



    return Scaffold(
        appBar: AppBar(title: Text("Notification")),
        body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[_buildBody(decUserNotification)]
            )
        ),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody(DecUserNotification decUserNotification) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(decUserNotification.title,
              style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)), //QT title bold
          Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(decUserNotification.date),
          ),

          Text(decUserNotification.content,
            style: TextStyle(wordSpacing: 10,
              fontSize: 14,
              letterSpacing: 2,
              fontStyle: FontStyle.italic,),  ), // QT Main body
        ]
    );
  }

}

