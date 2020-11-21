import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/zoom/join_screen.dart';
import 'package:mydec/zoom/meeting_screen.dart';
import 'package:mydec/zoom/start_meeting_screen.dart';

class ZoomTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Example Zoom SDK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [ ],
      initialRoute: '/',
      routes: {
        '/': (context) => JoinWidget(),
        '/meeting': (context) => MeetingWidget(),
        '/startmeeting': (context) => StartMeetingWidget(),
      },
    );
  }
}