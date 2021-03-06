

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:mydec/qt/routes/qt_info.dart';

class QTListItem extends StatefulWidget {
  QTListItem(this.qtInfo) : super(key: ValueKey(qtInfo.date));

  final QTInfo qtInfo;

  @override
  _QTListItemState createState() => _QTListItemState();
}

class _QTListItemState extends State<QTListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          ),
        ),
        child: InkWell(
          onTap: () => _openQTInfoPage(),
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
                    widget.qtInfo.title,
                    textScaleFactor: .9,
                    style: TextStyle(
                      height: 1.15,
                      color: Colors.blueGrey[700],
                      fontSize: 17,
                    ),

                  ),
                  subtitle: Text(
                    widget.qtInfo.date,
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: 12,
                    ),
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
                        padding: const EdgeInsets.only(top: 1, bottom: 1),
                        child:
                        Text(
                          widget.qtInfo.content,
                          maxLines: 3,
                          style: TextStyle(
                            height: 1.15,
                            color: Colors.blueGrey[700],
                            fontSize: 13,
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

  _openQTInfoPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QTInfoPage(qtInfo: widget.qtInfo)));
    // Navigator.of(context).pushNamed("qt_info", arguments: widget.qtInfo);
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
