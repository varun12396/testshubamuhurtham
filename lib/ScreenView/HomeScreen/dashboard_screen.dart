import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isLoading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    ApiService.countListDetails().then((value) {
      if (!mounted) return;
      setState(() {
        SharedPrefs.limitHoroscopeReached(value.message.noOfHoroscopeViews);
        SharedPrefs.limitMatchReached(value.message.horoscopeCompatibility);
        SharedPrefs.limitViewProfileReached(value.message.detailViewCount);
        SharedPrefs.limitInterestReached(value.message.noOfSendInterest);
        if (value.message.balanceDays <= 0) {
          SharedPrefs.limitDaysReached(0);
          SharedPrefs.profileSubscribeId('0');
        } else {
          SharedPrefs.limitDaysReached(value.message.balanceDays);
          SharedPrefs.profileSubscribeId('1');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SharedPrefs.isVerified
          ? SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: MyComponents.widthSize(context),
                  margin: const EdgeInsets.only(
                      left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: 'Dear Member please Note:\n',
                        style: GoogleFonts.rubik(
                            color: MyTheme.blackColor,
                            fontSize: 20,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w600),
                        children: [
                          const WidgetSpan(
                              child: SizedBox(height: kToolbarHeight - 26.0)),
                          SharedPrefs.getSubscribeId == '1'
                              ? TextSpan(
                                  text:
                                      'If "DETAILED PROFILE" reaches its maximum limit (75 nos) before the validity period ,then your premium subscription automatically converts into a standard subscription without further reminders and all unutilised services becomes void and cannot be carry forwarded.',
                                  style: GoogleFonts.inter(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.w400),
                                )
                              : TextSpan(
                                  text:
                                      'If "DETAILED PROFILE" reaches its maximum limit (5 nos) then your Allowed "FREE TRIAL PACK" OFFER such as View Horoscope and Horoscope Match automatically expires without further reminders and all unutilised services becomes void and cannot be carry forwarded.\n'
                                      'To continue with premium services, kindly upgrade to premium subscription.',
                                  style: GoogleFonts.inter(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.w400),
                                ),
                        ]),
                  ),
                ),
                SharedPrefs.getSubscribeId == '1'
                    ? Container(
                        margin:
                            const EdgeInsets.only(right: 20.0, bottom: 20.0),
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor: MyTheme.redColor),
                          onPressed: () {
                            MyComponents.showNotification(
                                'messageNotification');
                          },
                          child: Text(
                            'Remaining : ${SharedPrefs.getLimitDaysReached} Days',
                            style: GoogleFonts.rubik(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  width: MyComponents.widthSize(context),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MyComponents.widthSize(context) / 2.2,
                          margin: const EdgeInsets.only(left: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.greyColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(children: [
                            Image.asset('images/user_account.png',
                                width: 80.0, height: 80.0),
                            Text(
                              'Detailed\nProfile',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 20,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Remaining (${SharedPrefs.getLimitViewProfileReached})',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: MyTheme.greenColor,
                                    fontSize: 18,
                                    letterSpacing: 0.8),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: MyComponents.widthSize(context) / 2.2,
                          margin: const EdgeInsets.only(right: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.greyColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(children: [
                            Image.asset('images/astrology.png',
                                width: 80.0, height: 80.0),
                            Text(
                              'View\nHoroscope',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 20,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Remaining (${SharedPrefs.getLimitHoroscopeReached})',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: MyTheme.greenColor,
                                    fontSize: 18,
                                    letterSpacing: 0.8),
                              ),
                            ),
                          ]),
                        ),
                      ]),
                ),
                SizedBox(
                  width: MyComponents.widthSize(context),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MyComponents.widthSize(context) / 2.2,
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 20.0, bottom: 20.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.greyColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(children: [
                            Image.asset('images/heart_2.png',
                                width: 80.0, height: 80.0),
                            Text(
                              'Horoscope\nMatch',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 20,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Remaining (${SharedPrefs.getLimitMatchReached})',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: MyTheme.greenColor,
                                    fontSize: 18,
                                    letterSpacing: 0.8),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: MyComponents.widthSize(context) / 2.2,
                          margin: const EdgeInsets.only(
                              top: 20.0, bottom: 20.0, right: 10.0),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: MyTheme.greyColor, width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(children: [
                            Image.asset('images/love_interest.png',
                                width: 80.0, height: 80.0),
                            Text(
                              'Sent\nInterest',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 20,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w400),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Remaining (${SharedPrefs.getLimitInterestReached})',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: MyTheme.greenColor,
                                    fontSize: 18,
                                    letterSpacing: 0.8),
                              ),
                            ),
                          ]),
                        ),
                      ]),
                ),
              ]),
            )
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.all(10.0),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                      text: 'Dear Member please Note:\n',
                      style: GoogleFonts.rubik(
                          color: MyTheme.blackColor,
                          fontSize: 20,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600),
                      children: [
                        const WidgetSpan(
                            child: SizedBox(height: kToolbarHeight - 26.0)),
                        TextSpan(
                          text: 'Your profile is under verfication.',
                          style: GoogleFonts.inter(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
              ),
              isLoading
                  ? MyComponents.bottomCircularLoader(
                      MyTheme.transparent, MyTheme.baseColor)
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          ApiService.postprofilelist().then((value) {
                            if (SharedPrefs.getDashboard) {
                              if (value.message[0].isVerified == '1') {
                                SharedPrefs.verified(true);
                              } else {
                                SharedPrefs.verified(false);
                              }
                              setState(() {
                                isLoading = false;
                              });
                              MyComponents.navPushAndRemoveUntil(
                                  context,
                                  (p0) => const MainScreen(
                                      isVisible: false, pageIndex: 0),
                                  false);
                            } else {
                              MyComponents.navPushAndRemoveUntil(
                                  context, (p0) => const LoginScreen(), false);
                            }
                          });
                        },
                        child: Text(
                          'Refresh now',
                          style: GoogleFonts.inter(
                              color: MyTheme.whiteColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
            ]),
    );
  }
}
