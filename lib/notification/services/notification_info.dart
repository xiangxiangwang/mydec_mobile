

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:mydec/account/services/user_service.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/qt/models/qt_info.dart';

class NotificationInfoService {

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


  static Future<List<DecNotification>> getAllDecNotificationByRange(
      int pageNubmer, int pageSize, String lastUserNotificationKey) async {

    List<DecNotification> notificationList = [];

    String userKey = UserService.encodeUserEmail(Global.getCurrentUser().email);

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
            DecNotification decNotification = DecNotification.fromJson(notificationItem);
            decNotification.id = key;
            notificationList.add(decNotification);
          }
        });
    }

    notificationList.sort((a, b) => b.date.compareTo(a.date));

    return notificationList;


  }
}