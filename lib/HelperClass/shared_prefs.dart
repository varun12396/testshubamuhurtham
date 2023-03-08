import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? prefs;

  static initialize() async {
    if (prefs != null) {
      return prefs;
    } else {
      prefs = await SharedPreferences.getInstance();
    }
  }

  static Future<Future<bool>> login(bool login) async {
    return prefs!.setBool('login', login);
  }

  static Future<Future<void>> userId(String userid) async {
    return prefs!.setString('userId', userid);
  }

  static Future<Future<void>> profileId(String profileid) async {
    return prefs!.setString('profileId', profileid);
  }

  static Future<Future<void>> profileSubscribeId(String subscribeId) async {
    return prefs!.setString('subscribeId', subscribeId);
  }

  static Future<Future<void>> fcmTokenKey(String? token) async {
    return prefs!.setString('fcmToken', token!);
  }

  static Future<Future<void>> userGender(String gender) async {
    return prefs!.setString('gender', gender);
  }

  static Future<Future<void>> dateOfbirth(String tempDateOfbirth) async {
    return prefs!.setString('tempdateofbirth', tempDateOfbirth);
  }

  static Future<Future<bool>> step1Complete(bool step1) async {
    return prefs!.setBool('step1', step1);
  }

  static Future<Future<bool>> step2Complete(bool step2) async {
    return prefs!.setBool('step2', step2);
  }

  static Future<Future<bool>> step3Complete(bool step3) async {
    return prefs!.setBool('step3', step3);
  }

  static Future<Future<bool>> step4Complete(bool step4) async {
    return prefs!.setBool('step4', step4);
  }

  static Future<Future<bool>> dashboard(bool dashboard) async {
    return prefs!.setBool('dashboard', dashboard);
  }

  static Future<Future<bool>> verified(bool isVerified) async {
    return prefs!.setBool('isVerified', isVerified);
  }

  static Future<Future<bool>> suspended(bool isSuspended) async {
    return prefs!.setBool('isSuspended', isSuspended);
  }

  static Future<Future<bool>> isEmailVerify(bool isEmailVerified) async {
    return prefs!.setBool('isEmailVerified', isEmailVerified);
  }

  static Future<Future<bool>> postCall(bool postCallback) async {
    return prefs!.setBool('postCallback', postCallback);
  }

  static Future<Future<void>> limitHoroscopeReached(
      int limitHoroscopeReached) async {
    return prefs!.setInt('limitHoroscopeReached', limitHoroscopeReached);
  }

  static Future<Future<void>> limitMatchReached(int limitMatchReached) async {
    return prefs!.setInt('limitMatchReached', limitMatchReached);
  }

  static Future<Future<void>> limitViewProfileReached(
      int limitProfileReached) async {
    return prefs!.setInt('limitProfileReached', limitProfileReached);
  }

  static Future<Future<void>> limitInterestReached(
      int limitInterestReached) async {
    return prefs!.setInt('limitInterestReached', limitInterestReached);
  }

  static Future<Future<void>> limitDaysReached(int limitDaysReached) async {
    return prefs!.setInt('limitDaysReached', limitDaysReached);
  }

  static Future<Future<void>> notificationCount(
      int notificationCountLength) async {
    return prefs!.setInt('notificationCount', notificationCountLength);
  }

  static Future<Future<void>> sharedClear() async {
    return prefs!.clear();
  }

  static Future<Future<void>> sharedRemove(String key) async {
    return prefs!.remove(key);
  }

  static bool get getLogin => prefs!.getBool('login') ?? false;

  static String get getUserId => prefs!.getString('userId') ?? '';

  static String get getProfileId => prefs!.getString('profileId') ?? '';

  static String get getDateOfbirth => prefs!.getString('tempdateofbirth') ?? '';

  static String get getSubscribeId => prefs!.getString('subscribeId') ?? '0';

  static String get fcmToken => prefs!.getString('fcmToken') ?? '';

  static String get getGender => prefs!.getString('gender') ?? '';

  static bool get getStep1Complete => prefs!.getBool('step1') ?? false;

  static bool get getStep2Complete => prefs!.getBool('step2') ?? false;

  static bool get getStep3Complete => prefs!.getBool('step3') ?? false;

  static bool get getStep4Complete => prefs!.getBool('step4') ?? false;

  static bool get getDashboard => prefs!.getBool('dashboard') ?? false;

  static bool get isVerified => prefs!.getBool('isVerified') ?? false;

  static bool get isSuspended => prefs!.getBool('isSuspended') ?? false;

  static bool get isEmailVerified => prefs!.getBool('isEmailVerified') ?? false;

  static bool get getpostCallback => prefs!.getBool('postCallback') ?? false;

  static int get getLimitHoroscopeReached =>
      prefs!.getInt('limitHoroscopeReached') ?? 0;

  static int get getLimitMatchReached =>
      prefs!.getInt('limitMatchReached') ?? 0;

  static int get getLimitViewProfileReached =>
      prefs!.getInt('limitProfileReached') ?? 0;

  static int get getLimitInterestReached =>
      prefs!.getInt('limitInterestReached') ?? 0;

  static int get getLimitDaysReached => prefs!.getInt('limitDaysReached') ?? 0;

  static int get getNotificationCount =>
      prefs!.getInt('notificationCount') ?? 0;
}
