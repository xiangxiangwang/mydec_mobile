
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mydec/page_404.dart';
import 'package:mydec/qt/routes/qt_list.dart';
import 'package:mydec/states/profile_change_notifier.dart';
import 'package:mydec/sunday_service/routes/sunday_service_page.dart';

import 'package:mydec/web_view_page.dart';
import 'package:mydec/zoom_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'account/routes/account_page.dart';
import 'account/routes/personal_info.dart';
import 'common/models/global.dart';
import 'common/routes/language.dart';
import 'google_login_page.dart';
import 'home/home.dart';
import 'i10n/localization_intl.dart';
import 'notification/routes/notification.dart';


void main() => Global.init().then((e) => runApp(MyApp()));
// void main() => runApp(ChewieTest());
// void main() => runApp(ZoomTestPage());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localeModel, Widget child) {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),
            navigatorKey: navigatorKey,
            onGenerateTitle: (context){
              return DecLocalizations.of(context).title;
            },
            home: GoogleLoginPage(),
            locale: localeModel.getLocale(),
            //我们只支持美国英语和中文简体
            supportedLocales: [
              const Locale('en', 'US'), // 美国英语
              const Locale('zh', 'CN'), // 中文简体
              //其它Locales
            ],
            localizationsDelegates: [
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              DecLocalizationsDelegate()
            ],
            localeResolutionCallback:
                (Locale _locale, Iterable<Locale> supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {
                //跟随系统
                Locale locale;
                if (supportedLocales.contains(_locale)) {
                  locale= _locale;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  locale= Locale('en', 'US');
                }
                return locale;
              }
            },
            // 注册路由表
            routes:{
              // "/":(context) => GoogleLoginPage(), //注册首页路由
              "login_page":(context) => GoogleLoginPage(),
              "home":(context) => HomePage(),
              "web_view_page":(context) => WebViewPage(),
              "sunday_service":(context) => SundayServicePage(),
              "account":(context) => AccountPage(),
              "language":(context) => LanguagePage(),
              "personalInfo":(context) => PersonalInfoPage(),
              "404":(context) => Page404(),
              "qt_list":(context) => QTListPage(),
              "notification":(context) => NotificationInfoPage(),
            },
          );
        },
      ),
    );
  }
}
/***
class GoogleAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 注册我们的Delegate
        DecLocalizationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
        //其它Locales
      ],
      title: 'Google Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:"/",
      // home: GoogleLoginPage(),//注册路由表
      routes:{
        "/":(context) => GoogleLoginPage(), //注册首页路由
        "login_page":(context) => GoogleLoginPage(),
        "home":(context) => HomePage(),
        "web_view_page":(context) => WebViewPage(),
        "sunday_service":(context) => SundayServicePage(),
        "account":(context) => AccountPage(),
        "language":(context) => LanguagePage(),

      },
    );

  }
}
**/
/**
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingPage(),
    );
  }
}
***/
