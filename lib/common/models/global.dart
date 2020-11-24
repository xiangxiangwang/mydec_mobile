import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/models/profile.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'cacheConfig.dart';

// 提供四套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // static FirebaseApp firebaseApp;
  // 网络缓存对象
  static DecUser _currentUser;

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();


    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    // 如果没有缓存策略，设置默认缓存策略
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;


    // initial notification flugin
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var androidNotificationsPlugin = new AndroidInitializationSettings('@mipmap/app_icon');

    var iOSNotificationsPlugin = new IOSInitializationSettings();
    var macNotificationsPlugin = new MacOSInitializationSettings();

    var initSetttings = new InitializationSettings(android: androidNotificationsPlugin, iOS: iOSNotificationsPlugin, macOS: macNotificationsPlugin);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

  }

  static Future onSelectNotification(String payload) {

    Map<String, dynamic> result = new Map<String, dynamic>.from(json.decode(payload));
    DecNotification _decNotification = DecNotification.fromJson(result);
    MyApp.navigatorKey.currentState.pushNamed("notification", arguments: _decNotification);

  }

  static showNotification(DecNotification _decNotification) async {

    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',

        priority: Priority.high,
      importance: Importance.max,
      icon: "@mipmap/app_icon"

    );

    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(

        0, _decNotification.title, _decNotification.content, platform,

        payload: json.encode(_decNotification.toJson()));

  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));

  static void setCurrentUser(DecUser user) {
    _currentUser = user;
  }
  static DecUser getCurrentUser() {
    return _currentUser;
  }

}
