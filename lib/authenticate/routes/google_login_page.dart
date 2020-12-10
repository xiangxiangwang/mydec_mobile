import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';

import '../../account/services/user_service.dart';
import '../../common/google_sign_in.dart';
import '../../common/models/global.dart';
import '../../i10n/localization_intl.dart';
import '../../notification/models/dec_notification.dart';

class GoogleLoginPage extends StatefulWidget {
  @override
  _GoogleLoginPageState createState() => _GoogleLoginPageState();
}

class _GoogleLoginPageState extends State<GoogleLoginPage> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _unameController = new TextEditingController();


  DatabaseReference _dbNotificationRef;
  StreamSubscription<Event> _notificationSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        //child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // FlutterLogo(size: 150),
              Image(image: AssetImage("assets/images/login_page_church_logo.png")),
              // )
              // SizedBox(height: 50),
              _signInButton()
            ],
          ),
        //),
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.only( left: 16.0, right: 16.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  hintText: DecLocalizations.of(context).userName,
                ),
                // 校验用户名（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : DecLocalizations.of(context).userNameRequired;
                }),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: RaisedButton(
                  color: Color(0xff723F8C),
                  onPressed: _onLogin,
                  textColor: Colors.white,
                  child: Text(DecLocalizations.of(context).login),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 3.0,
      children: <Widget>[
        _signInWithGoogleButton()
      ]
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
    );
  }
  Widget _signInWithFacebookButton() {

    Function signInFunction = null;
    return _signInWithThirdPartyButton(
        signInFunction,
        "assets/images/facebook_logo.png",
        DecLocalizations.of(context).signInWithFacebook
    );

  }
  Widget _signInWithLinkedInButton() {
    Function signInFunction = null;
    return _signInWithThirdPartyButton(
        signInFunction,
        "assets/images/linkedin_logo.png",
        DecLocalizations.of(context).signInWithLinkedIn
    );

  }
  Widget _signInWithAppleButton() {
    Function signInFunction = null;
    return _signInWithThirdPartyButton(
        signInFunction,
        "assets/images/apple_logo.png",
        DecLocalizations.of(context).signInWithApple
    );

  }
  Widget _signInWithGoogleButton() {

    Function signInFunction = () =>
    {
      signInWithGoogle().then((result) {
        if (result != null) {
          _postActionAfterLogin(result);
          Navigator.of(context).pushNamed("home");
        }
      })
    };
    return _signInWithThirdPartyButton(
        signInFunction,
        "assets/images/google_logo.png",
        DecLocalizations.of(context).signInWithGoogle
    );
  }


  Widget _signInWithThirdPartyButton(Function signInFunction, String imageUrl, String text) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: signInFunction,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.grey),
      borderSide: BorderSide.none,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Image(image: AssetImage(imageUrl), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                // DecLocalizations.of(context).signInWithGoogle,
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,

                ),

              ),
            )
          ],
        ),
      ),
    );
  }


  _onLogin() {

  }

  // anything needed after the user login
  _postActionAfterLogin(String uid) {
    // start to listen to the notification
    _dbNotificationRef = FirebaseDatabase.instance.reference().child('user_notifications').child(uid);

    //   StreamSubscription<Event> _notificationSubscription;
    _dbNotificationRef.keepSynced(true);
    _notificationSubscription = _dbNotificationRef.onChildAdded.listen((Event event) {
      // print("_postActionAfterLogin: ${event.snapshot.value}");
      if (event.snapshot.value != null) {


        Map<String, dynamic> result = new Map<String, dynamic>.from(event.snapshot.value);

        DecUserNotification _decUserNotification = DecUserNotification.fromJson(result);
        if (_decUserNotification.readDate == null) {
          Global.showNotification(_decUserNotification);

        }


      }
    });

  }
}