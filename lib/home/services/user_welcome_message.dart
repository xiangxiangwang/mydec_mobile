

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mydec/account/services/user_service.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/home/models/user_welcome_message.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/qt/models/qt_info.dart';

class UserWelcomeMessageService {


  static Future<void> markUserWelcomeMessageAsRead(String uid, UserWelcomeMessage userWelcomeMessage) async {

    print("will mark $uid - ${userWelcomeMessage.id} as read ");

    userWelcomeMessage.readDate = new DateTime.now();
    userWelcomeMessage.readFlag = true;

    FirebaseDatabase.instance.reference()
      .child("user_welcome_messages")
      .child(uid).child(userWelcomeMessage.welcomeMessageId).set(userWelcomeMessage.toJson());

  }

  static Future<void> markUserWelcomeMessagesAsRead(String uid, List<UserWelcomeMessage> userWelcomeMessages) async {

    userWelcomeMessages.forEach((userWelcomeMessage) async {
      await markUserWelcomeMessageAsRead(uid, userWelcomeMessage);
    });

  }


  static Future<List<UserWelcomeMessage>> getNonReadWelcomeMessages(String uid) async {

    List<UserWelcomeMessage> userWelcomeMessages = [];
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("user_welcome_messages")
        .child(uid)
        .orderByChild("readFlag")
        .equalTo(false)
        .once();

    print("getNonReadWelcomeMessages: ${snapshot.value}");
    if(snapshot.value != null) {
            // There should be only one notification item
            Map<String, Map<dynamic, dynamic>> userWelcomeMessageItems = new Map<String, Map<dynamic, dynamic>>.from(snapshot.value);

            userWelcomeMessageItems.forEach((key, value) {

              Map<String, dynamic> userWelcomeMessageItem = new Map<String, dynamic>.from(value);
              userWelcomeMessages.add(UserWelcomeMessage.fromJson(userWelcomeMessageItem));
            });

      // completer.complete(user);
    }

    return userWelcomeMessages;
  }
}