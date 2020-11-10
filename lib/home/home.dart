import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login successfully!"),
      ),
      body: _buildBody(), // 构建主页面
      // drawer: MyDrawer(), //抽屉菜单
    );
  }

  Widget _buildBody() {
      //用户未登录，显示登录按钮
      return Center(
        child: RaisedButton(
          child: Text("You are logged in"),
        ),
      );

  }
}

