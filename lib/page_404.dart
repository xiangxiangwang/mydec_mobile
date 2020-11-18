import 'package:flutter/material.dart';



class Page404 extends StatefulWidget {
  @override
  _Page404State createState() => _Page404State();
}

class _Page404State extends State<Page404> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        //child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // FlutterLogo(size: 150),
            Image(image: AssetImage("assets/images/page_come_soon.png"), height: 350),
          ],
        ),
        //),
      ),
    );
  }



}