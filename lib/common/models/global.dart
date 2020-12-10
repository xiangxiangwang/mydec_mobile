import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mydec/account/models/user.dart';
import 'package:mydec/common/models/profile.dart';
import 'package:mydec/notification/models/dec_notification.dart';
import 'package:mydec/notification/models/dec_user_notification.dart';
import 'package:mydec/notification/services/notification_info.dart';
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
  static bool _hasNotification = false;

  static EventBus eventBus = new EventBus();


  static Timer _repeatibleTimer;

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


    // refresh the has notification flag
    _repeatibleTimer = new Timer.periodic(new Duration(seconds: 60), (timer) async {
      bool newHasNotificationFlag = await NotificationInfoService.hasNonReadNotification(_currentUser.uid);
      _resetHasNotificationFlag(newHasNotificationFlag);


    });

  }

  static Future onSelectNotification(String payload) {

    Map<String, dynamic> result = new Map<String, dynamic>.from(json.decode(payload));
    DecUserNotification _decUserNotification = DecUserNotification.fromJson(result);
    MyApp.navigatorKey.currentState.pushNamed("notification", arguments: _decUserNotification);

  }

  static showNotification(DecUserNotification _decUserNotification) async {

    _resetHasNotificationFlag(true);
    var android = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',

        priority: Priority.high,
      importance: Importance.max,
      icon: "@mipmap/app_icon"

    );

    var iOS = new IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: iOS);

    await flutterLocalNotificationsPlugin.show(

        0, _decUserNotification.title, _decUserNotification.content, platform,

        payload: json.encode(_decUserNotification.toJson()));

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

  static bool hasNotification() {
    return _hasNotification;
  }

  static Future<void> recalculateHasNotificationFlag() async {

    bool newHasNotificationFlag = await NotificationInfoService.hasNonReadNotification(_currentUser.uid);

    _resetHasNotificationFlag(newHasNotificationFlag);
  }

  static void _resetHasNotificationFlag(bool hasNotificationFlag) {
    if (_hasNotification != hasNotificationFlag) {
      // we get a new flag value, let's change the value and
      // emit the event
      eventBus.emit("hasNotificationFlagChange", hasNotificationFlag);
      _hasNotification = hasNotificationFlag;
    }
  }

}


//订阅者回调签名
typedef void EventCallback(arg);

class EventBus {
  //私有构造函数
  EventBus._internal();

  //保存单例
  static EventBus _singleton = new EventBus._internal();

  //工厂构造函数
  factory EventBus()=> _singleton;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  //添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  //移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  //触发事件，事件触发后该事件所有订阅者会被调用
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    //反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](arg);
    }
  }
}
