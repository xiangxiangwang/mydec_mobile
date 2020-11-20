
import 'dart:async';

import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/common/bottom_navigation_bar.dart';
import 'package:mydec/qt/models/qt_info.dart';
import 'package:mydec/qt/services/qt_info.dart';
import 'package:mydec/qt/widgets/qt_list_item.dart';



class QTListPage extends StatefulWidget {
  @override
  _QTListPageState createState() => _QTListPageState();
}

class _QTListPageState extends State<QTListPage> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("qt")),
        body: _buildBody(),
        bottomNavigationBar: buildBottomNavigationBar(context)
    );
  }
/**
  Widget _buildBody(List<QTInfo> qtInfoList) {
    return ListView.separated(
      itemCount: qtInfoList.length,
      //列表项构造器
      itemBuilder: (BuildContext context, int index) {
        return _getListTile(qtInfoList[index]);
      },
      //分割器构造器
      separatorBuilder: (BuildContext context, int index) {
        return  Divider(color: Colors.blue);
      },
    );

  }
    ***/

  Widget _buildBody() {
      return InfiniteListView<QTInfo>(
        onRetrieveData: (int page, List<QTInfo> items, bool refresh) async {

          var data = await QTInfoService.getAllQTInfoByDateRange(
            new DateTime.now().subtract(Duration(days: (page) * 15)),
            new DateTime.now().subtract(Duration(days: (page-1) * 15)),
          );
          //把请求到的新数据添加到items中
          print("we get ${data.length} qt");
          items.addAll(data);
          return data.length > 0 && data.length % 15 == 0;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          // 项目信息列表项
          return QTListItem(list[index]);
        },
      );
  }



}

