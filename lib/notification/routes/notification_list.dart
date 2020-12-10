
import 'dart:async';

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/i10n/localization_intl.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/notification/services/notification_info.dart';
import 'package:mydec/notification/widgets/notification_list_item.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:mydec/qt/services/qt_info.dart';
import 'package:mydec/qt/widgets/qt_list_item.dart';



class NotificationListPage extends StatefulWidget {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {

  String lastNotificationKey = "";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(DecLocalizations.of(context).notification)),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }

  Widget _buildBody() {
      return InfiniteListView<DecUserNotification>(
        onRetrieveData: (int page, List<DecUserNotification> items, bool refresh) async {
          // 列表下拉刷新，重新加载最新的N条记录
          if (refresh) {
            lastNotificationKey = "";

          }
          List<DecUserNotification> data = await NotificationInfoService.getAllDecUserNotificationByRange(
              page, 10, lastNotificationKey
          );
          //把请求到的新数据添加到items中
          items.addAll(data);
          lastNotificationKey = data.last.id;
          // return true if there's more data
          // return false if there's no more data
          return data.length > 0 && data.length % 10 == 0;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return UserNotificationListItem(list[index]);
        },
      );
  }



}

