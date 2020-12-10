

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mydec/account/services/user_service.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/qt/models/qt_info.dart';

class NotificationInfoService {

  /***
  static DecNotification getQTInfoByDate(String date) {
    FirebaseDatabase.instance.reference()
        .child("qt_info")
        .child(date)
        .once()
        .then((DataSnapshot snapshot) {
      if(snapshot.value == null) {
        return null;
      }
      return QTInfo.fromJson(snapshot.value);
    });

    return null;
  }
**/

  static Future<List<DecUserNotification>> getAllDecUserNotificationByRange(
      int pageNubmer, int pageSize, String lastUserNotificationKey) async {

    List<DecUserNotification> notificationList = [];

    String userKey = Global.getCurrentUser().uid;

    // Please note that in firebase, we are supposed to use 'push' to create a new notification
    // in the user_notifications/user_id bucket, which will result the nofications being sort
    // by the 'insert date' in ascend sequence.
    // So in order to get the first page data, we will need to get the last (page size) records
    // To get page N's data(support page number start from 1 instead of 0), we will need to get
    // 1. last (N + 1) * PageSize records
    // 2. from those records get the first PageSize records
    DataSnapshot snapshot;
    if (lastUserNotificationKey.isEmpty) {
      snapshot = await FirebaseDatabase.instance.reference()
          .child("user_notifications")
          .child(userKey)
           .orderByKey()
          .limitToLast(pageSize)
          .once();
    }
    else {

      snapshot = await FirebaseDatabase.instance.reference()
          .child("user_notifications")
          .child(userKey)
          .orderByKey()
          .endAt(lastUserNotificationKey)
          .limitToLast(pageSize+1)
          .once();
    }

    if(snapshot.value != null) {
      Map<String, Map<dynamic, dynamic>> notificationItems = new Map<String, Map<dynamic, dynamic>>.from(snapshot.value);

        notificationItems.forEach((key, value) {
          // if the lastUserNotificationKey is passed in, then our result probably include the notification with
          // this specific key, which should already returned in the previous call
          // we will ignore this notification at this moment
          if (lastUserNotificationKey.isEmpty ||
              lastUserNotificationKey.compareTo(key) != 0) {

            Map<String, dynamic> notificationItem = new Map<String, dynamic>.from(value);
            DecUserNotification decUserNotification = DecUserNotification.fromJson(notificationItem);
            decUserNotification.id = key;
            notificationList.add(decUserNotification);
          }
        });
    }

    notificationList.sort((a, b) => b.date.compareTo(a.date));

    return notificationList;


  }


  static Future<void> markNotificationAsRead(String uid, DecUserNotification notification) async {

    //print("will mark $uid - ${notification.id} as read ");
    FirebaseDatabase.instance.reference()
      .child("user_notifications")
      .child(uid).child(notification.id).child("readDate").set(DateFormat('yyyy-MM-dd HH:mm:ss').format(new DateTime.now()));

    // Every time after the user read a notification, let' s recalculate the has new notification flag
    Global.recalculateHasNotificationFlag();

  }

  static Future<bool> hasNonReadNotification(String uid) async{
    DecUserNotification userNotification = await getNonReadNotification(uid);
    return userNotification != null;

  }

  static Future<DecUserNotification> getNonReadNotification(String uid) async {
    DecUserNotification userNotification;
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child("user_notifications")
        .child(uid)
        .orderByChild("readDate") // Not null value already come first
        .limitToFirst(1)
        .once();

    if(snapshot.value != null) {
            // There should be only one notification item
            Map<String, Map<dynamic, dynamic>> notificationItems = new Map<String, Map<dynamic, dynamic>>.from(snapshot.value);

            notificationItems.forEach((key, value) {

              Map<String, dynamic> notificationItem = new Map<String, dynamic>.from(value);
              userNotification = DecUserNotification.fromJson(notificationItem);

              if (userNotification.readDate != null) {
                // the notification has already been read
                userNotification = null;
              }
            });

      // completer.complete(user);
    }

    return userNotification;
  }
}