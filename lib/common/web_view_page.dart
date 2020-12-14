import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mydec/zoom/meeting_screen.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/***
class Browser extends StatelessWidget {
  const Browser({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}



    */

class Browser extends StatefulWidget {
  String url;
  String title;

  Browser({Key key, @required this.url, @required this.title});

  @override
  createState() => _BrowserState(url: url, title: title);
}

class _BrowserState extends State<Browser> {
  _BrowserState({Key key, @required this.url, @required this.title});

  String url;
  String title;
  FlutterWebviewPlugin _webViewPlugin = FlutterWebviewPlugin();

  double lineProgress = 0.0;

  initState() {
    super.initState();
    _webViewPlugin.onProgressChanged.listen((progress) {
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });
    /***
    _webViewPlugin.onUrlChanged.listen((String url) async {
      print("will flow to $url");
      // for zoom meeting, the url will be
      // zoomus://id:password
      String zoomLinkPrefix = "https://firebasestorage.googleapis.com/v0/b/mydec-9160b.appspot.com/o/html%2Floading_zoom.html";
      if (url.startsWith(zoomLinkPrefix)) {
        await _webViewPlugin.stopLoading();
        await _webViewPlugin.goBack();
        // Let's open the zoom meeting

        List<String> zoomLinkInfo = url.substring(zoomLinkPrefix.length + 1).split("&");
        print("zoomLinkInfo: $zoomLinkInfo");
        String meetingId = "";
        String password = "";

        zoomLinkInfo.forEach((element) {
          List<String> keyPair = element.split("=");
          if (keyPair.length == 2) {
            if (keyPair[0] == "meetingid") {
              meetingId = keyPair[1];
            }
            else if (keyPair[0] == "password") {
              password = keyPair[1];
            }
          }
        });
        print("start to connect to zoom meeting: $meetingId , $password");
        _joinZoomMeeting(context, meetingId, password);

      }
    });
        ***/
  }

  _joinZoomMeeting(BuildContext context, String meetingId, String password) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MeetingWidget(meetingId: meetingId, meetingPassword: password);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: _setTitle(context),
      url: widget.url,
      mediaPlaybackRequiresUserGesture: false,
      withZoom: false,
      withLocalStorage: true,
      hidden: true,
    );
  }

  _progressBar(double progress, BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        backgroundColor: Colors.blueAccent.withOpacity(0),
        value: progress == 1.0 ? 0 : progress,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.lightBlue),
      ),
      height: 1,
    );
  }

  _setTitle(context) {
    return AppBar(
      brightness: Brightness.light,
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
      elevation: 1,
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context)),
      backgroundColor: Colors.white,
      centerTitle: true,
      bottom: PreferredSize(
        child: _progressBar(lineProgress, context),
        preferredSize: Size.fromHeight(0.1),
      ),
    );
  }

  @override
  void dispose() {
    _webViewPlugin.dispose();
    super.dispose();
  }
}


class WebViewPage extends StatefulWidget {
  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    String url  = ModalRoute.of(context).settings.arguments;
    print("start to show in web view: $url");
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted

    );
  }
}