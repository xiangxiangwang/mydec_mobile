
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/appbar.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/common/models/menu.dart';
import 'package:mydec/home/models/user_welcome_message.dart';
import 'package:mydec/home/services/user_welcome_message.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/zoom/meeting_screen.dart';

import '../../common/web_view_page.dart';
import 'package:carousel_slider/carousel_slider.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<UserWelcomeMessage> _userWelcomeMessage = Global.getUserWelcomeMessage();

    return Scaffold(
        body:
              Builder(
                  builder: (context) {
                    final double height = MediaQuery
                        .of(context)
                        .size
                        .height;
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: height,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }
                        // autoPlay: false,
                      ),
                      items: _userWelcomeMessage.map((item) {

                          return Container(
                            margin: EdgeInsets.all(5.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage(
                                      "assets/images/onboarding_image.png"),
                                      fit: BoxFit.cover,
                                      width: 1000),
                                  Text(item.title),
                                  Text(item.subtitle),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: _userWelcomeMessage.map((item1) {
                                      int index = _userWelcomeMessage.indexOf(item1);

                                      return Container(
                                        width: 8.0,
                                        height: 8.0,
                                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _currentIndex == index
                                              ? Color.fromRGBO(0, 0, 0, 0.9)
                                              : Color.fromRGBO(0, 0, 0, 0.4),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  _currentIndex == (_userWelcomeMessage.length - 1) ?
                                  OutlineButton(
                                    child: Text(DecLocalizations.of(context).nextStep),
                                    onPressed: () => _goToHomePage(),
                                  )
                                    : Text("")
                                ]
                            ),
                          );
                      }).toList(),
                    );

                  }
              )
    );
  }

  _goToHomePage(){

    // mark all the welcome message as read
    UserWelcomeMessageService.markUserWelcomeMessagesAsRead(Global.getCurrentUser().uid, Global.getUserWelcomeMessage());
    Navigator.of(context).pushNamed("home");
  }
}

