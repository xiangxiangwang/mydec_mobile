

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mydec/common/models/global.dart';
import 'package:mydec/common/web_view_page.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/notification/services/notification_info.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:mydec/qt/routes/qt_info.dart';

class UserNotificationListItem extends StatefulWidget {
  UserNotificationListItem(this.decUserNotification) : super(key: ValueKey(decUserNotification.id));

  final DecUserNotification decUserNotification;

  @override
  _UserNotificationListItemState createState() => _UserNotificationListItemState();
}

class _UserNotificationListItemState extends State<UserNotificationListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: InkWell(
          onTap: () => _openNotificationInfoPage(),
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  dense: true,
                  /**
                      leading: gmAvatar(
                      //项目owner头像
                      widget.repo.owner.avatar_url,
                      width: 24.0,
                      borderRadius: BorderRadius.circular(12),
                      ),
                   **/
                  title: Text(
                    widget.decUserNotification.readDate == null ?
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.decUserNotification.date) + "(New!)"
                    :
                    DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.decUserNotification.date),
                    textScaleFactor: .9,
                  ),
                  subtitle: Text(
                    widget.decUserNotification.title,
                  ),
                  // trailing: Text(widget.repo.language ?? ""),
                ),
                // 构建项目标题和简介
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /***
                          Text(
                          widget.repo.fork
                          ? widget.repo.full_name
                          : widget.repo.name,
                          style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: widget.repo.fork
                          ? FontStyle.italic
                          : FontStyle.normal,
                          ),
                          ),
                       ***/
                      Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 12),
                        child:
                        Text(
                          widget.decUserNotification.content,
                          maxLines: 3,
                          style: TextStyle(
                            height: 1.15,
                            color: Colors.blueGrey[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // 构建卡片底部信息
                //_buildBottom()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _openNotificationInfoPage() {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationInfoPage()));
    // Navigator.of(context).pushNamed("qt_info", arguments: widget.qtInfo);

    // open the url instead of the notification page
    // Navigator.of(context).pushNamed("notification", arguments: widget.decUserNotification);
    print("will open : $widget.decUserNotification.url");
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (_) {
      return new Browser(
        url: widget.decUserNotification.url,
        title: widget.decUserNotification.title,
      );
    }));


    NotificationInfoService.markNotificationAsRead(Global.getCurrentUser().uid, widget.decUserNotification);

    setState(() {
      widget.decUserNotification.readDate = new DateTime.now();
    });
  }
  // 构建卡片底部信息
/***
  Widget _buildBottom() {
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15,
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey, fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context) {
            var children = <Widget>[
              Icon(Icons.star),
              Text(" " +
                  widget.repo.stargazers_count
                      .toString()
                      .padRight(paddingWidth)),
              Icon(Icons.info_outline),
              Text(" " +
                  widget.repo.open_issues_count
                      .toString()
                      .padRight(paddingWidth)),

              Icon(MyIcons.fork), //我们的自定义图标
              Text(widget.repo.forks_count.toString().padRight(paddingWidth)),
            ];

            if (widget.repo.fork) {
              children.add(Text("Forked".padRight(paddingWidth)));
            }

            if (widget.repo.private == true) {
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(" private".padRight(paddingWidth))
              ]);
            }
            return Row(children: children);
          }),
        ),
      ),
    );
  }

    **/
}
