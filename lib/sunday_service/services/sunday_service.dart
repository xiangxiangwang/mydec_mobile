

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:mydec/qt/models/qt_info.dart';

class SundayServiceService {



  static Future<Map<String,String>> getAllSundayServiceLinks() async {
    Map<String, String> sundayServiceLinks = new Map<String, String>();
    /***
    sundayServiceLinks = {
      "sundayServiceLive": "https://youtu.be/Xqz_n3duoH0",
      "sundayServiceYouth": "https://www.youtube.com/watch?v=xvBB6xvtCgc&t=15s",
      "sundayServiceKids": "https://zoom.us/j/4981601988",
      "sundayServicePray": "https://zoom.us/j/99357666623",
      "sundayServiceWeeklyReport": "https://drive.google.com/drive/folders/18cUJaVuZZakia5bDKjI97fpSnzfttAGJ"
    };
        ***/

      DataSnapshot snapshot = await FirebaseDatabase.instance.reference()
          .child("app_config")
          .child("sunday_service")
          .once();


      if(snapshot.value != null) {
        Map<String, Map<dynamic, dynamic>> sundayServiceItems = new Map<String, Map<dynamic, dynamic>>.from(snapshot.value);
        sundayServiceItems.forEach((key, value) {

          Map<String, String> sundayServiceConfig = new Map<String, String>.from(value);
          sundayServiceLinks[key] = sundayServiceConfig["link"];

        });

      }

      return sundayServiceLinks;

  }
}