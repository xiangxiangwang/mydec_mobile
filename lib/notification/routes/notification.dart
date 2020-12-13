
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:mydec/zoom/meeting_screen.dart';



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
/***
          Text(decUserNotification.content,
            style: TextStyle(wordSpacing: 10,
              fontSize: 14,
              letterSpacing: 2,
              fontStyle: FontStyle.italic,),  ),
    **/
          Html(
            data: decUserNotification.content,
            onLinkTap: (url) => _openUrl(decUserNotification.title, url),
          ),
        ]
    );
  }

  _openUrl(String title, String url) {
    print("open url: $url");
    if (url.startsWith("zoom://")) {
      List<String> zoomLinkInfo = url.substring(7).split(":");
      String meetingId = zoomLinkInfo[0];
      String password = "";
      if (zoomLinkInfo.length > 1) {
        password = zoomLinkInfo[1];
      }
      _joinZoomMeeting(context, meetingId, password);
    }
    /***
    else {
      // we will use the web view to open the URL
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (_) {
        return new Browser(
          url: url,
          title: "title",
        );
      }));
    }
        **/
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

