import 'package:flutter/material.dart';
import 'package:mydec/i10n/localization_intl.dart';

import 'models/global.dart';


Widget buildBottomNavigationBar(BuildContext context) {

  List<String> urls= ["home", "404", "sunday_service", "account"];

  return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          // icon: Icon(Icons.home, color: Colors.blue),
            icon: new Image.asset("assets/images/icon-bottom-nav-home.png", height: 25),
            label:  DecLocalizations.of(context).home,
        ),
        BottomNavigationBarItem(
          // icon: Icon(Icons.account_circle, color: Colors.blue),
            icon: new Image.asset("assets/images/icon-bible-with-label.png", height: 25),
            label:   DecLocalizations.of(context).dailyQt,
        ),
        BottomNavigationBarItem(
          // icon: Icon(Icons.account_circle, color: Colors.blue),
            icon: new Image.asset("assets/images/icon-worship-live.png", height: 25),
            label:   DecLocalizations.of(context).sundayService,
        ),
        BottomNavigationBarItem(
          //   icon: Icon(Icons.account_circle, color: Colors.blue),
            icon: new Image.asset("assets/images/icon-bottom-nav-me.png", height: 25),
            label:   DecLocalizations.of(context).account,
        )
      ],
      currentIndex: 0,
      onTap: (int index) {


        Navigator.of(context).pushNamed(urls[index]);
      }
  );

}