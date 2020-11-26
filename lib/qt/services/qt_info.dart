

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:mydec/qt/models/qt_info.dart';

class QTInfoService {

  static QTInfo getQTInfoByDate(String date) {
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


  static Future<List<QTInfo>> getAllQTInfoByDateRange(DateTime startDate, DateTime endDate) async {
    if (startDate == null) {
      startDate = new DateTime(2020, 1, 1);
    }
    if (endDate == null) {
      endDate = new DateTime.now();
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    List<QTInfo> qtInfoList = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime qtDate = endDate.subtract(Duration(days: i));
      String date = formatter.format(qtDate);
      DataSnapshot snapshot = await FirebaseDatabase.instance.reference()
          .child("qt_info")
          .child(date)
          .once();

      if(snapshot.value != null) {


        qtInfoList.add(QTInfo.fromJson(new Map<String, dynamic>.from(snapshot.value)));
      }
    }

    return qtInfoList;

  }
}