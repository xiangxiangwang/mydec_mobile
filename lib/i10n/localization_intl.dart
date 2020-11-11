import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //1

class DecLocalizations {
  static Future<DecLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new DecLocalizations();
    });
  }

  static DecLocalizations of(BuildContext context) {
    return Localizations.of<DecLocalizations>(context, DecLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the application',
    );
  }
  String get home => Intl.message('Home', name: 'home');
  String get account => Intl.message('Account', name: 'account');
}

//Locale代理类
class DecLocalizationsDelegate extends LocalizationsDelegate<DecLocalizations> {
  const DecLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DecLocalizations> load(Locale locale) {
    //3
    return  DecLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(DecLocalizationsDelegate old) => false;
}