import 'dart:io';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myshubamuhurtham/ApiSection/api_connection.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/drop_list_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/notification_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class MyComponents {
  static String appName = 'My Shubamuhurtham';
  static String timeSlot = '10:00 AM - 07.00 PM';
  static String contactNumber = '7339332315';
  static String emailAddress = 'info@myshubamuhurtham.com';
  static String cancelEmailAddress = 'MyShubamuhurtham@gmail.com';
  static int pageIndex = 0;
  static String kErrorMesage = 'Something went wrong!,Please try again';
  static String kCouponMesage = 'Apply either one of the code.';
  static String merchantKeyTest = 'gtKFFx';
  static String merchantSaltTest = '4R38IvwiV57FwVpsgOvTXBdLE4tHUXFW';
  static String merchantKeyLive = 'Qyt9lG';
  static String merchantSaltLive = 'i2v5MTBWJEX82J0G0bASv7QqpmgzFTjB';
  static String fcmServerKey = 'AAAA8q9SiOI:APA91bG-uFgrGWw2vmdk3yzbfIXYS7HZ62l'
      'vaMdipUAap9hZkyi-gAQOuz9wEjMqBFqf8_C5KGRZq860MMTJ0DnhN8pboYaolQnjaNR3wvvlPca'
      'xorLwaO1zP7RudjcDBR8aPU0T4Ph_';
  static double maxWidth = 150.0;
  static double maxHeight = 150.0;
  static int imageQuality = 100;
  static double responsiveMinWidth = 450.0;
  static double responsiveMaxWidth = 1200.0;
  static double mobile = 450;
  static double tablet = 800;
  static double tablet2 = 1000;
  static double desktop = 1200;
  static double size4K = 2460;
  static String sIZE4K = '4K';
  static int listLength = 10;
  static int galleryLength = 6;
  static int notificationLength = 0;
  static bool isLabelVisible = false;
  static List<Country> countryData = [];
  static List<States> stateData = [];
  static List<Location> locationData = [];
  static List<Height> heightData = [];
  static List<Mothertongue> mothertongueData = [];
  static List<Religion> religionData = [];
  static List<Caste> casteData = [];
  static List<SubCaste> subcasteData = [];
  static List<Education> educationData = [];
  static List<Occupation> occupationData = [];
  static String kImageAssets = 'assets';
  static String kImageFile = 'file';
  static String kImageNetwork = 'network';
  static String appIcon = 'images/app_icon.png';
  static String appInfoBG = 'images/appinfo_background.png';
  static String splashTopImage = 'images/splash_top.png';
  static String splashCenterImage = 'images/splash_center.png';
  static String crownImage = 'images/crown.png';
  static String loginRegisterBackground = 'images/background.jpg';
  static String noConnection = 'images/noconnection.png';
  static String profilePicture = 'images/user_profile.png';
  static String malePicture = 'images/male_user.png';
  static String femalePicture = 'images/female_user.png';
  static String emailVerifyImage = 'images/email.png';
  static String changePasswordImage = 'images/reset_password.png';
  static String privacyProfileImage = 'images/profile_privacy.png';
  static String deleteProfileImage = 'images/delete_user.png';
  static String maleNetPicture =
      'https://myshubamuhurtham.com/assets/img/profile-pic-m.png';
  static String femaleNetPicture =
      'https://myshubamuhurtham.com/assets/img/profile-pic-fm.png';
  static String warningPicture = 'images/warning.png';
  static String sucessMark = 'images/check_mark.png';
  static String sucessPicture = 'images/check.png';
  static String cancelPicture = 'images/cancel.png';
  static String discountImage = 'images/discount.png';
  static String appLogo = 'images/logo.png';
  static String otpVerify = 'images/otpVerify.png';
  static String noInternet = 'images/noconnection.png';
  static String emptySearch = 'images/nosearch.png';
  static String notification = 'images/notification.png';
  static String viewUserImage = 'images/view_user.png';
  static String pdfImage = 'images/pdf.png';
  static String pdfTopImage = 'images/pdf_logo.png';
  static String pdfFooterImage = 'images/footer_logo.png';
  static String toEnablenotification = '';
  static String imageBaseUrl =
      'https://${ApiConnection.baseurl}/uploads/avatar/';
  static String horoBaseUrl =
      'https://${ApiConnection.baseurl}/uploads/horoscope/';

  static List<ResponsiveBreakpoint> responsiveView = [
    ResponsiveBreakpoint.resize(mobile, name: MOBILE),
    ResponsiveBreakpoint.autoScale(tablet, name: TABLET),
    ResponsiveBreakpoint.autoScale(tablet2, name: TABLET),
    ResponsiveBreakpoint.resize(desktop, name: DESKTOP),
    ResponsiveBreakpoint.autoScale(size4K, name: sIZE4K),
  ];

  static secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  static widthSize(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static heightSize(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static orientation() {
    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static bool wordsCountValidator(String validateData, int countData) {
    if (RegExp(r"[\w-._]+").allMatches(validateData).length < countData) {
      return true;
    }
    return false;
  }

  static bool isAdultValidator(String birthDateString, String datePattern) {
    DateTime birthDate = DateFormat(datePattern).parse(birthDateString);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > 18 || yearDiff == 18 && monthDiff >= 0 && dayDiff >= 0;
  }

  static bool isDateValidator(String date, String format) {
    int day = 0, month = 0, year = 0;
    try {
      String separator = RegExp("([-/.])").firstMatch(date)!.group(0)![0];

      var frSplit = format.split(separator);
      var dtSplit = date.split(separator);

      for (int i = 0; i < frSplit.length; i++) {
        var frm = frSplit[i].toLowerCase();
        var vl = dtSplit[i];

        if (frm == "dd") {
          day = int.parse(vl);
        } else if (frm == "mm") {
          month = int.parse(vl);
        } else if (frm == "yyyy") {
          year = int.parse(vl);
        }
      }
      var now = DateTime.now();
      if (month > 12 ||
          month < 1 ||
          day < 1 ||
          day > daysInMonth(month, year) ||
          year < 1810 ||
          (year > now.year && day > now.day && month > now.month)) {
        throw Exception("Date birth invalid.");
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  static int daysInMonth(int month, int year) {
    int days = 28 +
        (month + (month / 8).floor()) % 2 +
        2 % month +
        2 * (1 / month).floor();
    return (isLeapYear(year) && month == 2) ? 29 : days;
  }

  static bool isLeapYear(int year) =>
      ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0);

  static stringDateFormat(String currentStringDate, String formatPattern) {
    String dateFormat =
        '${currentStringDate.substring(6, 10)}-${currentStringDate.substring(3, 5)}-${currentStringDate.substring(0, 2)}';
    DateTime? formattedDate = DateTime.tryParse(dateFormat);
    String formattedPattern = formattedDateTime(formattedDate!, formatPattern);
    return formattedPattern;
  }

  static formattedDateTime(DateTime currentTime, String newPattern) {
    final DateFormat formatter = DateFormat(newPattern);
    String formattedPattern = formatter.format(currentTime);
    return formattedPattern;
  }

  static formattedDateString(String currentTime, String newPattern) {
    final DateFormat formatter = DateFormat(newPattern);
    String formattedPattern = formatter.format(DateTime.parse(currentTime));
    return formattedPattern;
  }

  static Future<void> launchInPhone(String phoneNumber) async {
    final Uri launch = Uri(
      scheme: 'tel',
      path: '+91 $phoneNumber',
    );
    await launchUrl(launch);
  }

  static Future<void> launchInEmail(String mailAddress) async {
    final Uri launch = Uri(scheme: 'mailto', path: mailAddress);
    await launchUrl(launch);
  }

  static Future<void> launchInBrowser(String urlLink) async {
    if (!await launchUrl(
      Uri.parse(urlLink),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $urlLink';
    }
  }

  static void requestPermission() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        provisional: false,
        sound: true);
  }

  static Future<String?> getTokenKey() {
    return FirebaseMessaging.instance.getToken();
  }

  static showNotification(String messageNotification) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      appName,
      messageNotification,
      const NotificationDetails(
        android: AndroidNotificationDetails('1', 'App Notification',
            color: Colors.blue, icon: "@mipmap/launcher_icon"),
      ),
    );
  }

  static onNotificationOpenApp(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      debugPrint(event.toString());
      navPush(context, (p0) => const NotificationScreen());
    });
  }

  static deleteFcmToken() {
    FirebaseMessaging.instance.deleteToken();
  }

  static toast(String msgData) {
    return Fluttertoast.showToast(
        msg: msgData,
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        webShowClose: true,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: MyTheme.blackColor,
        textColor: MyTheme.whiteColor,
        fontSize: 16.0);
  }

  static unFocused(BuildContext context) {
    return FocusScope.of(context).unfocus();
  }

  static navPop(BuildContext context) {
    return Navigator.pop(context);
  }

  static navPush(
      BuildContext context, Widget Function(BuildContext) navScreen) {
    return Navigator.push(context, MaterialPageRoute(builder: navScreen));
  }

  static navPopWithResult(BuildContext context, dynamic result) {
    return Navigator.pop(context, result);
  }

  static navPushAndRemoveUntil(BuildContext context,
      Widget Function(BuildContext) navScreen, bool routes) {
    return Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: navScreen), (route) => routes);
  }

  static appbarWithTitle(BuildContext context, String titleHeader,
      bool autoLead, List<Widget>? actions, Color backgroundColor) {
    return AppBar(
      automaticallyImplyLeading: autoLead,
      backgroundColor: backgroundColor,
      title: Text(
        titleHeader,
        style: GoogleFonts.rubik(
          fontSize: 18,
          letterSpacing: 0.4,
          fontWeight: FontWeight.w500,
          color: MyTheme.blackColor,
        ),
      ),
      iconTheme: IconThemeData(color: MyTheme.blackColor),
      elevation: 0.0,
      actions: actions,
    );
  }

  static alertDialogBox(BuildContext context, bool barrierDismissible,
      Widget titleWidget, Widget contentWidget, List<Widget> actionsWidget) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: titleWidget,
          content: contentWidget,
          actions: actionsWidget,
        );
      },
    );
  }

  static bottomCircularLoader(Color? backgroundColor, Color? color) {
    return SizedBox(
      height: kToolbarHeight - 6.0,
      child: circularLoader(backgroundColor, color),
    );
  }

  static circularLoader(Color? backgroundColor, Color? color) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: backgroundColor,
        color: color,
      ),
    );
  }

  static showDialogPreview(
      BuildContext context, String imageType, String imageFile) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: imageChild(imageType, imageFile),
          );
        });
  }

  static imageChild(String imageType, String imageFile) {
    if (imageType == kImageAssets) {
      return Image.asset(imageFile);
    } else if (imageType == kImageFile) {
      return Image.file(
        File(imageFile),
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(profilePicture);
        },
      );
    } else if (imageType == kImageNetwork) {
      return Image.network(
        imageFile,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(profilePicture);
        },
      );
    }
  }

  static emptyDatatoshow(BuildContext context, String images, String fieldData,
      String contentData, bool isVisible, void Function() onPressed) {
    return SizedBox(
      width: widthSize(context),
      height: heightSize(context),
      child: Center(
        child: RichText(
          text: TextSpan(children: [
            WidgetSpan(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      images,
                      width: kToolbarHeight + 94,
                      height: kToolbarHeight + 94,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '\n$fieldData',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            letterSpacing: 0.4,
                            color: MyTheme.blackColor),
                      ),
                    ),
                    isVisible
                        ? ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: MyTheme.baseColor, width: 2.0),
                                    borderRadius: BorderRadius.circular(8.0)),
                                backgroundColor: MyTheme.whiteColor),
                            child: FittedBox(
                              child: Text(
                                contentData,
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    color: MyTheme.baseColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }

  static fadeShimmerList(bool isVisibile) {
    return ListView.builder(
        itemCount: MyComponents.listLength,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 10.0),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MyComponents.widthSize(context),
            margin:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: MyTheme.backgroundBox,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: MyTheme.greyColor)),
            child: Container(
              width: MyComponents.widthSize(context),
              padding: const EdgeInsets.all(2.0),
              child: Column(children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FadeShimmer.round(
                          size: isVisibile ? 120 : 40.0,
                          baseColor: MyTheme.greyColor,
                          highlightColor: MyTheme.whiteColor,
                        ),
                      ),
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FadeShimmer(
                            baseColor: MyTheme.greyColor,
                            highlightColor: MyTheme.whiteColor,
                            height: kToolbarHeight - 46.0,
                            radius: 8,
                            width: MyComponents.widthSize(context) / 2.2,
                          ),
                        ),
                        isVisibile
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeShimmer(
                                  baseColor: MyTheme.greyColor,
                                  highlightColor: MyTheme.whiteColor,
                                  height: kToolbarHeight - 46.0,
                                  radius: 8,
                                  width: MyComponents.widthSize(context) / 2.2,
                                ),
                              )
                            : const SizedBox.shrink(),
                        isVisibile
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FadeShimmer(
                                  baseColor: MyTheme.greyColor,
                                  highlightColor: MyTheme.whiteColor,
                                  height: kToolbarHeight - 26.0,
                                  radius: 8,
                                  width: MyComponents.widthSize(context) / 2.2,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ]),
                    ]),
              ]),
            ),
          );
        });
  }

  static assetImageHolder() {
    if (SharedPrefs.getGender == 'M') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: Image.network(
          MyComponents.femaleNetPicture,
          fit: BoxFit.cover,
          width: kToolbarHeight + 64.0,
          height: kToolbarHeight + 64.0,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: Image.network(
          MyComponents.maleNetPicture,
          fit: BoxFit.cover,
          width: kToolbarHeight + 64.0,
          height: kToolbarHeight + 64.0,
        ),
      );
    }
  }

  static delayLoader(BuildContext context, String contentData) {
    return SizedBox(
      width: MyComponents.widthSize(context),
      height: MyComponents.heightSize(context),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: kToolbarHeight - 6.0,
              height: kToolbarHeight - 6.0,
              child: CircularProgressIndicator(
                backgroundColor: MyTheme.transparent,
                color: MyTheme.baseColor,
                strokeWidth: 4.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              contentData,
              style: GoogleFonts.inter(
                  fontSize: 18,
                  letterSpacing: 0.4,
                  color: MyTheme.blackColor,
                  fontWeight: FontWeight.w500),
            ),
          ]),
    );
  }
}
