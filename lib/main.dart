import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyComponents.orientation();
  SharedPrefs.initialize();
  MyComponents.secureScreen();
  await Firebase.initializeApp(
      name: MyComponents.appName,
      options: const FirebaseOptions(
          apiKey: "AIzaSyB7BHFu4dcslVtCBKr5lno4qgBEd_SZKCc",
          appId: "1:1042323507426:android:28412c68cf559d17db36bb",
          messagingSenderId: "1042323507426",
          projectId: "myshubamuhurtham-73982",
          androidClientId:
              "1042323507426-a15pf3qv9jdudvjcitcklmrk8t7gr29p.apps.googleusercontent.com",
          storageBucket: "myshubamuhurtham-73982.appspot.com"));
  MyComponents.requestPermission();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      MyComponents.toEnablenotification = notification.title!;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails('1', 'App Notification',
              color: Colors.blue,
              icon: "@mipmap/launcher_icon",
              fullScreenIntent: true),
        ),
      );
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: MyComponents.appName,
        builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: MyComponents.responsiveMaxWidth,
              minWidth: MyComponents.responsiveMinWidth,
              breakpoints: MyComponents.responsiveView,
              background: Container(color: MyTheme.whiteColor),
            ),
        theme: ThemeData(primarySwatch: MyTheme.primaryColor),
        home: const GoSplashScreen(),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ta', 'IN'),
        ]);
  }
}

class GoSplashScreen extends StatefulWidget {
  const GoSplashScreen({Key? key}) : super(key: key);
  @override
  State<GoSplashScreen> createState() => _GoSplashScreenState();
}

class _GoSplashScreenState extends State<GoSplashScreen>
    with SingleTickerProviderStateMixin {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  late ConnectivityResult result;
  bool isWidgetChange = false, isLoading = false;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    MyComponents.onNotificationOpenApp(context);
    MyComponents.getTokenKey().then((token) {
      SharedPrefs.fcmTokenKey(token);
    }).onError((error, stackTrace) {});
    getInfoData();
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      MyComponents.toast(e.message.toString());
      return;
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isWidgetChange
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(MyComponents.noConnection),
              Container(
                width: MyComponents.widthSize(context),
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: Text(
                  'No Internet Connection',
                  style: GoogleFonts.rubik(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                alignment: Alignment.center,
                child: Text(
                  'You are not connected to the internet.\nMake sure Wi-Fi/Mobile Data is on.',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: isLoading
                    ? MyComponents.circularLoader(
                        MyTheme.transparent, MyTheme.baseColor)
                    : ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          getInfoData();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(
                              kToolbarHeight + 104.0, kToolbarHeight - 16.0),
                          backgroundColor: MyTheme.baseColor,
                        ),
                        child: Text(
                          'Retry',
                          style: GoogleFonts.inter(
                              color: MyTheme.whiteColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
              ),
            ])
          : Scaffold(
              body: SizedBox(
                width: MyComponents.widthSize(context),
                height: MyComponents.heightSize(context),
                child: Column(children: [
                  Image.asset(MyComponents.splashTopImage),
                  Expanded(
                    child: Center(
                      child: Image.asset(MyComponents.splashCenterImage,
                          height: kToolbarHeight + 144.0, fit: BoxFit.contain),
                    ),
                  ),
                ]),
              ),
            ),
    );
  }

  getInfoData() {
    Future.delayed(const Duration(seconds: 1), () {
      if (connectionStatus == ConnectivityResult.none) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isWidgetChange = true;
            isLoading = false;
          });
        });
      } else {
        if (SharedPrefs.getDashboard) {
          ApiService.postprofilelist().then((value) {
            if (value.message.isNotEmpty) {
              if (value.message[0].isVerified == '1') {
                SharedPrefs.verified(true);
              } else {
                SharedPrefs.verified(false);
              }
              if (value.message[0].isEmailVerified == '1') {
                SharedPrefs.isEmailVerify(true);
              } else {
                SharedPrefs.isEmailVerify(false);
              }
              setState(() {
                isLoading = false;
              });
              MyComponents.navPushAndRemoveUntil(
                  context,
                  (p0) => const MainScreen(isVisible: true, pageIndex: 0),
                  false);
            } else if (value.message[0].fcmToken.isEmpty) {
              ApiService.getlogout().then((value) {});
              SharedPrefs.sharedClear();
              MyComponents.toast('Session Timeout.');
              MyComponents.navPushAndRemoveUntil(
                  context, (p0) => const LoginScreen(), false);
            } else {
              MyComponents.toast('Session Timeout.');
              MyComponents.navPushAndRemoveUntil(
                  context, (p0) => const LoginScreen(), false);
            }
          });
        } else {
          setState(() {
            isLoading = false;
          });
          Future.delayed(const Duration(seconds: 2), () {
            MyComponents.navPushAndRemoveUntil(
                context, (p0) => const LoginScreen(), false);
          });
        }
      }
    });
  }
}
