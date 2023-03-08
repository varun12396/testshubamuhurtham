import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/astro_detail_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/information_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/partner_prefrence_screen.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/profile_preview_screen.dart';
import 'package:myshubamuhurtham/ScreenView/MyProfileScreen/profile_settings_screen.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class RequestOTP extends StatefulWidget {
  final String mobileNumber, titleHeader, emailAddress;
  const RequestOTP(
      {Key? key,
      required this.mobileNumber,
      required this.titleHeader,
      required this.emailAddress})
      : super(key: key);

  @override
  State<RequestOTP> createState() => _RequestOTPState();
}

class _RequestOTPState extends State<RequestOTP> {
  Timer? timer;
  int timerData = 60;
  bool isOtpLoad = true,
      isLoading = true,
      showPassword = false,
      showPassword2 = false;
  TextEditingController otpcontroller = TextEditingController(),
      passwordcontroller = TextEditingController(),
      confirmpasscontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getClockTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, '', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(
            MyComponents.otpVerify,
            width: MyComponents.widthSize(context),
            height: kToolbarHeight + 144.0,
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: widget.emailAddress.isNotEmpty
                      ? 'OTP sent to your email address '
                      : 'OTP sent to your mobile number ',
                  style: GoogleFonts.rubik(
                      fontSize: 18,
                      color: MyTheme.blackColor,
                      letterSpacing: 0.4),
                  children: [
                    TextSpan(
                      text: widget.mobileNumber,
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ', Please enter your 6 digit verification code.',
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4),
                    ),
                  ]),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight + 14.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: FittedBox(
              child: PinCodeTextField(
                controller: otpcontroller,
                maxLength: 6,
                defaultBorderColor: MyTheme.greyColor,
                highlightPinBoxColor: MyTheme.baseColor,
                keyboardType: TextInputType.number,
                onTextChanged: (p0) {
                  if (p0.isNotEmpty) {
                    setState(() {
                      isOtpLoad = false;
                      timer!.cancel();
                      timerData = 60;
                    });
                  }
                },
                pinTextStyle: GoogleFonts.rubik(
                    fontSize: 24,
                    color: MyTheme.whiteColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight + 14.0,
            margin: const EdgeInsets.all(20.0),
            alignment: Alignment.centerRight,
            child: isOtpLoad
                ? SizedBox(
                    width: kToolbarHeight + 4.0,
                    height: kToolbarHeight + 4.0,
                    child: Stack(children: [
                      MyComponents.circularLoader(
                          MyTheme.greyColor, MyTheme.baseColor),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 1.0),
                          child: Text(
                            timerData.toString(),
                            style: GoogleFonts.rubik(color: MyTheme.blackColor),
                          ),
                        ),
                      ),
                    ]),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        isOtpLoad = true;
                        timerData = 60;
                      });
                      getClockTimer();
                      if (widget.emailAddress.isNotEmpty) {
                        resendemailOtp();
                      } else {
                        resendOtp();
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: MyTheme.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        side: BorderSide(color: MyTheme.baseColor),
                      ),
                    ),
                    child: FittedBox(
                      child: Text(
                        'Resend OTP',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(
                            color: MyTheme.baseColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
          ),
          isLoading
              ? ElevatedButton(
                  onPressed: () {
                    if (otpcontroller.text.isEmpty) {
                      MyComponents.toast('Please enter 6 digit otp code');
                      return;
                    } else if (otpcontroller.text.length < 6) {
                      MyComponents.toast('Please enter valid 6 digit otp');
                      return;
                    }
                    MyComponents.unFocused(context);
                    if (widget.titleHeader == 'LoginRegister') {
                      getLoginData(context);
                    } else if (widget.titleHeader == 'Forgot Password') {
                      getForgotPassword(context);
                    } else if (widget.titleHeader == 'Email Verification') {
                      getEmailVerify(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.baseColor,
                    fixedSize: Size(MyComponents.widthSize(context) / 1.8,
                        kToolbarHeight - 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: MyTheme.whiteColor,
                          fontSize: 18,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : SizedBox(
                  height: kToolbarHeight - 6.0,
                  child: MyComponents.circularLoader(
                      MyTheme.whiteColor, MyTheme.baseColor),
                ),
        ]),
      ),
    );
  }

  getClockTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        --timerData;
        if (timerData == 0) {
          isOtpLoad = false;
          timer.cancel();
          timerData = 60;
        }
      });
    });
  }

  getLoginData(BuildContext context) {
    setState(() {
      isLoading = false;
    });
    try {
      Future<LoginOtpVerify> data = ApiService.postverifyotp(
          otpcontroller.text, widget.mobileNumber, 'otp');
      data.then((value) {
        if (value.status) {
          SharedPrefs.profileId(value.myProfileId);
          SharedPrefs.userId(value.userId);
          Future<MyProfileData> profileData = ApiService.postprofilelist();
          profileData.then((value1) {
            if (value1.status) {
              SharedPrefs.userGender(value1.message[0].gender);
              SharedPrefs.profileSubscribeId(
                  value1.message[0].subscribedPremiumId);
              MyComponents.toast(value.message);
              setState(() {
                isLoading = false;
              });
              if (value1.message[0].profileStep == '1') {
                if (value1.message[0].profileStep == '1' &&
                    value1.message[0].createdByColumn == '1') {
                  MyComponents.navPushAndRemoveUntil(
                      context,
                      (p0) => InformationScreen(
                          isProfileCreatedbyAdmin:
                              value1.message[0].createdByColumn),
                      false);
                } else {
                  MyComponents.navPushAndRemoveUntil(
                      context,
                      (p0) =>
                          const InformationScreen(isProfileCreatedbyAdmin: ''),
                      false);
                }
              } else if (value1.message[0].profileStep == '2') {
                SharedPrefs.step1Complete(true);
                MyComponents.navPush(
                    context,
                    (p0) =>
                        const AstroDetailScreen(isProfileCreatedbyAdmin: ''));
              } else if (value1.message[0].profileStep == '3') {
                SharedPrefs.step1Complete(true);
                SharedPrefs.step2Complete(true);
                MyComponents.navPush(
                    context,
                    (p0) => const PartnerPrefrenceScreen(
                        isProfileCreatedbyAdmin: ''));
              } else if (value1.message[0].profileStep == '4') {
                SharedPrefs.step1Complete(true);
                SharedPrefs.step2Complete(true);
                SharedPrefs.step3Complete(true);
                MyComponents.navPush(
                    context, (p0) => const ProfilePreviewScreen());
              } else if (value1.message[0].profileStep == '0') {
                value1.message[0].isVerified == '1'
                    ? SharedPrefs.verified(true)
                    : SharedPrefs.verified(false);
                SharedPrefs.step1Complete(true);
                SharedPrefs.step2Complete(true);
                SharedPrefs.step3Complete(true);
                SharedPrefs.step4Complete(true);
                MyComponents.navPushAndRemoveUntil(
                    context,
                    (p0) => const MainScreen(isVisible: true, pageIndex: 0),
                    false);
              }
            } else {
              setState(() {
                isLoading = false;
              });
              MyComponents.toast(MyComponents.kErrorMesage);
            }
          });
        } else {
          setState(() {
            isLoading = true;
          });
          MyComponents.toast(value.message);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  getForgotPassword(BuildContext context) {
    setState(() {
      isLoading = false;
    });
    try {
      Future<LoginOtpVerify> data =
          ApiService.postverifyotp(otpcontroller.text, widget.mobileNumber, '');
      data.then((value) {
        setState(() {
          isLoading = true;
        });
        if (value.status) {
          MyComponents.navPush(
              context,
              (p0) => ProfileSettingScreen(
                  userIdData: value.userId,
                  emailaddress: '',
                  isProtectPhoto: false,
                  isvisibleToAll: false,
                  titleHeader: 'Forgot Password'));
        }
        MyComponents.toast(value.message);
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  getEmailVerify(BuildContext context) {
    setState(() {
      isLoading = false;
    });
    try {
      Future<UpdateEmail> data = ApiService.postemailverifyotp(
          otpcontroller.text, widget.emailAddress);
      data.then((value) {
        if (value.status) {
          ApiService.postprofilelist().then((value1) {
            if (value1.status) {
              if (value1.message[0].isEmailVerified == '1') {
                SharedPrefs.isEmailVerify(true);
              } else {
                SharedPrefs.isEmailVerify(false);
              }
              setState(() {
                isLoading = true;
              });
              MyComponents.toast(value.message);
              MyComponents.navPushAndRemoveUntil(
                  context,
                  (p0) => MainScreen(
                      isVisible: false,
                      pageIndex: value1.message[0].isVerified == '1' ? 4 : 1),
                  false);
            } else {
              setState(() {
                isLoading = true;
              });
              MyComponents.toast(MyComponents.kErrorMesage);
            }
          });
        } else {
          setState(() {
            isLoading = true;
          });
          MyComponents.toast(value.message);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = true;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  resendemailOtp() {
    try {
      ApiService.postUpdateVerifyEmail(widget.emailAddress).then((value) {
        MyComponents.toast(value.message);
      });
    } catch (e) {
      setState(() {
        isOtpLoad = true;
        timer!.cancel();
        timerData = 60;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  resendOtp() {
    try {
      Future<LoginOtpVerify> data =
          ApiService.postloginmobileotp('otp', widget.mobileNumber, '');
      data.then((value) {
        MyComponents.toast(value.message);
      });
    } catch (e) {
      setState(() {
        isOtpLoad = true;
        timer!.cancel();
        timerData = 60;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }
}
