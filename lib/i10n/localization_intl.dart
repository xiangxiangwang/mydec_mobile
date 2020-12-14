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
      desc: 'Title for the Demo application',
    );
  }
  String get home => Intl.message('Home', name: 'home');

  String get language => Intl.message('Language', name: 'language');

  String get login => Intl.message('Login', name: 'login');

  String get account => Intl.message('Account', name: 'account');

  String get accountDisplay => Intl.message('Account Display', name: 'accountDisplay');

  String get personalInfo => Intl.message('Personal Info', name: 'personalInfo');

  String get firstName => Intl.message('First Name', name: 'firstName');

  String get lastName => Intl.message('Last Name', name: 'lastName');

  String get firstNameRequired => Intl.message('First Name Required', name: 'firstNameRequired');

  String get lastNameRequired => Intl.message('Last Name Required', name: 'lastNameRequired');


  String get pastoralZone => Intl.message('Pastoral Zone', name: 'pastoralZone');

  String get pastoralGroup => Intl.message('Pastoral Group', name: 'pastoralGroup');

  String get pastoralRole => Intl.message('Pastoral Role', name: 'pastoralRole');
  String get shepherdPosition => Intl.message('Shepherd Position', name: 'shepherdPosition');
  String get churchPosition => Intl.message('Church Position', name: 'churchPosition');

  String get certifiedMember => Intl.message('Certified Member', name: 'certifiedMember');
  String get fullTimeEmployee => Intl.message('Full Time Employee', name: 'fullTimeEmployee');

  String get save => Intl.message('Save', name: 'save');


  String get result => Intl.message('Result', name: 'result');
  String get dataSaved => Intl.message('Data Saved', name: 'dataSaved');


  String get sundayServiceLive => Intl.message('Sunday Service Live', name: 'sundayServiceLive');
  String get sundayServiceLiveSubtitle => Intl.message('Sunday Service Live Subtitle', name: 'sundayServiceLiveSubtitle');

  String get sundayServiceYouth => Intl.message('Sunday Service Youth', name: 'sundayServiceYouth');
  String get sundayServiceYouthSubtitle => Intl.message('Sunday Service South Subtitle', name: 'sundayServiceYouthSubtitle');

  String get sundayServiceKids => Intl.message('Sunday Service Kids', name: 'sundayServiceKids');
  String get sundayServiceKidsSubtitle => Intl.message('Sunday Service Kids Subtitle', name: 'sundayServiceKidsSubtitle');

  String get sundayServicePray => Intl.message('Sunday Service Pray', name: 'sundayServicePray');
  String get sundayServicePraySubtitle => Intl.message('Sunday Service Pray Subtitle', name: 'sundayServicePraySubtitle');

  String get sundayServiceWeeklyReport => Intl.message('Sunday Service Weekly Report', name: 'sundayServiceWeeklyReport');
  String get sundayServiceWeeklyReportSubtitle => Intl.message('Sunday Service Weekly Report Subtitle', name: 'sundayServiceWeeklyReportSubtitle');


  String get signInWithGoogle => Intl.message('Sign In With Google', name: 'signInWithGoogle');
  String get signInWithFacebook => Intl.message('Sign In With Facebook', name: 'signInWithFacebook');
  String get signInWithLinkedIn => Intl.message('Sign In With LinkedIn', name: 'signInWithLinkedIn');
  String get signInWithApple => Intl.message('Sign In With Apple', name: 'signInWithApple');

  String get sundayService => Intl.message('Sunday Service', name: 'sundayService');
  String get dailyQt => Intl.message('Daily QT', name: 'dailyQt');
  String get morningPray => Intl.message('Morning Pray', name: 'morningPray');
  String get classLearning => Intl.message('Class Learning', name: 'classLearning');
  String get churchGroup => Intl.message('Church Group', name: 'churchGroup');
  String get donation => Intl.message('Donation', name: 'donation');
  String get faithConfession => Intl.message('Faith Confession', name: 'faithConfession');
  String get ourVision => Intl.message('Our Vision', name: 'ourVision');

  String get notification => Intl.message('Notification', name: 'notification');
  String get notificationHistory => Intl.message('Notification History', name: 'notificationHistory');

  String get sundayServiceChinese => Intl.message('Sunday Service - Chinese', name: 'sundayServiceChinese');
  String get sundayServiceTime => Intl.message('Sunday 11:00 AM PDT', name: 'sundayServiceTime');
  String get sundayServiceLiveZoom => Intl.message('Join Zoom Meeting', name: 'sundayServiceLiveZoom');
  String get sundayServiceLiveYoutube => Intl.message('Youtube Live', name: 'sundayServiceLiveYoutube');
  String get password => Intl.message('Password', name: 'password');

  String greetingMessage(Object name) {
    return Intl.message(
      'Hi $name, Jesus Loves You',
      name: 'greetingMessage',
      desc: '',
      args: [name],
    );
  }

  ///////////////////////////////////////////////////////////////////////////////

  String get auto => Intl.message('Auto', name: 'auto');

  String get setting => Intl.message('Setting', name: 'setting');

  String get theme => Intl.message('Theme', name: 'theme');

  String get noDescription =>
      Intl.message('No description yet !', name: 'noDescription');

  String get userName => Intl.message('User Name', name: 'userName');
  String get userNameRequired => Intl.message("User name required!" , name: 'userNameRequired');
  String get passwordRequired => Intl.message('Password required!', name: 'passwordRequired');
  String get userNameOrPasswordWrong=>Intl.message('User name or password is not correct!', name: 'userNameOrPasswordWrong');
  String get logout => Intl.message('logout', name: 'logout');
  String get logoutTip => Intl.message('Are you sure you want to quit your current account?', name: 'logoutTip');
  String get yes => Intl.message('yes', name: 'yes');
  String get cancel => Intl.message('cancel', name: 'cancel');
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