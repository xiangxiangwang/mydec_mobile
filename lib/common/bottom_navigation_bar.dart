import 'package:flutter/material.dart';
import 'package:mydec/i10n/localization_intl.dart';


Widget buildBottomNavigationBar(BuildContext context) {

  List<String> urls= ["home", "account"];

  return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label:  DecLocalizations.of(context).home
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.blue,
            ),
            label:   DecLocalizations.of(context).account
        )
      ],
      currentIndex: 0,
      onTap: (int index) {

        Navigator.of(context).pushNamed(urls[index]);
      }
  );

}