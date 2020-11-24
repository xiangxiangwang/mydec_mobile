
import 'dart:async';
import 'dart:ui';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:video_player/video_player.dart';




class NotificationInfoPage extends StatefulWidget {
  @override
  _NotificationInfoPageState createState() => _NotificationInfoPageState();
}

class _NotificationInfoPageState extends State<NotificationInfoPage> {

  @override
  Widget build(BuildContext context) {
    DecNotification decNotification = ModalRoute.of(context).settings.arguments;


    return Scaffold(
        appBar: AppBar(title: Text("Notification")),
        body: SingleChildScrollView(
            child: Stack(
                children: <Widget>[_buildBody(decNotification)]
            )
        ),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody(DecNotification decNotification) {

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(decNotification.title,
              style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)), //QT title bold
          Text(
              DateFormat('yyyy-MM-dd HH:mm:ss').format(decNotification.date),
          ),

          Text(decNotification.content,
            style: TextStyle(wordSpacing: 10,
              fontSize: 14,
              letterSpacing: 2,
              fontStyle: FontStyle.italic,),  ), // QT Main body
        ]
    );
  }

}

