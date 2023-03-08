import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/astro_detail_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/forgot_password_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/information_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/partner_prefrence_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/profile_preview_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/request_otp_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/privacy_policy_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/terms_condition_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false, isLoading = false;
  TextEditingController mobilenumber = TextEditingController(),
      password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MyComponents.widthSize(context),
          height: MyComponents.heightSize(context),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MyComponents.loginRegisterBackground),
                fit: BoxFit.cover),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyComponents.appbarWithTitle(
                    context, '', false, [], MyTheme.transparent),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 8.0,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: MyTheme.backgroundBox,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                      controller: mobilenumber,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.rubik(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.4,
                          decoration: TextDecoration.none),
                      cursorColor: MyTheme.blackColor,
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        counterText: '',
                        hintText: 'Mobile No',
                        hintStyle: GoogleFonts.rubik(
                            color: MyTheme.greyColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            decoration: TextDecoration.none),
                        prefixIcon: Icon(
                          Icons.call_rounded,
                          color: MyTheme.greyColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 8.0,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: MyTheme.backgroundBox,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: showPassword ? false : true,
                      style: GoogleFonts.rubik(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.4,
                          decoration: TextDecoration.none),
                      cursorColor: MyTheme.blackColor,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: GoogleFonts.rubik(
                            color: MyTheme.greyColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            decoration: TextDecoration.none),
                        prefixIcon: Icon(Icons.password_rounded,
                            color: MyTheme.greyColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: MyTheme.greyColor,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: MyTheme.transparent),
                        onPressed: () {
                          MyComponents.navPush(
                              context, (p0) => const ForgotPasswordscreen());
                        },
                        child: Text(
                          'Forgot Password?',
                          style: GoogleFonts.inter(
                              color: MyTheme.whiteColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  isLoading
                      ? SizedBox(
                          height: kToolbarHeight - 6.0,
                          child: MyComponents.circularLoader(
                              MyTheme.transparent, MyTheme.redColor),
                        )
                      : Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, bottom: 10.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (mobilenumber.text.isEmpty) {
                                      MyComponents.toast(
                                          'Please enter mobile number');
                                      return;
                                    }
                                    if (password.text.isEmpty) {
                                      MyComponents.toast(
                                          'Please enter password');
                                      return;
                                    }
                                    if (mobilenumber.text.length < 10) {
                                      MyComponents.toast(
                                          'Please enter 10 digit mobile number');
                                      return;
                                    }
                                    MyComponents.unFocused(context);
                                    setState(() {
                                      isLoading = true;
                                    });
                                    userLogin(mobilenumber.text, password.text,
                                        'password');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.baseColor,
                                    fixedSize: Size(
                                        MyComponents.widthSize(context) / 3.4,
                                        kToolbarHeight - 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                          color: MyTheme.whiteColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    'Or',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (mobilenumber.text.isEmpty) {
                                      MyComponents.toast(
                                          'Please enter mobile number');
                                      return;
                                    }
                                    if (mobilenumber.text.length < 10) {
                                      MyComponents.toast(
                                          'Please enter 10 digit mobile number');
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    MyComponents.unFocused(context);
                                    userLogin(mobilenumber.text, '', 'otp');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.baseColor,
                                    fixedSize: Size(
                                        MyComponents.widthSize(context) / 2.4,
                                        kToolbarHeight - 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      'Request OTP',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                          color: MyTheme.whiteColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                  Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.only(
                        left: 40.0, top: 10.0, right: 38.0, bottom: 20.0),
                    child: FittedBox(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Are you a new member? ',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    clearData();
                                    MyComponents.navPush(context,
                                        (p0) => const RegisterScreen());
                                  },
                                  child: Text(
                                    'Register Now',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ]),
              ]),
        ),
      ),
    );
  }

  clearData() {
    mobilenumber.clear();
    password.clear();
  }

  userLogin(String mobile, String password, String loginType) {
    try {
      Future<LoginOtpVerify> data =
          ApiService.postloginmobileotp(loginType, mobile, password);
      data.then((value) {
        if (value.status) {
          if (loginType == 'password') {
            SharedPrefs.profileId(value.myProfileId);
            SharedPrefs.userId(value.userId);
            Future<MyProfileData> values = ApiService.postprofilelist();
            values.then((value1) {
              if (value1.status) {
                SharedPrefs.userGender(value1.message[0].gender);
                SharedPrefs.profileSubscribeId(
                    value1.message[0].subscribedPremiumId);
                MyComponents.toast('LoggedIn Sucessfully.');
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
                        (p0) => const InformationScreen(
                            isProfileCreatedbyAdmin: ''),
                        false);
                  }
                } else if (value1.message[0].profileStep == '2') {
                  SharedPrefs.step1Complete(true);
                  SharedPrefs.dateOfbirth(value1.message[0].dateOfBirth);
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
          } else if (loginType == 'otp') {
            setState(() {
              isLoading = false;
            });
            MyComponents.toast(value.message);
            MyComponents.navPush(
              context,
              (p0) => RequestOTP(
                  mobileNumber: mobile,
                  titleHeader: 'LoginRegister',
                  emailAddress: ''),
            );
          }
        } else {
          setState(() {
            isLoading = false;
          });
          MyComponents.toast(value.message);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController namecontroller = TextEditingController(),
      mobilenumber = TextEditingController();
  bool isLoading = false;
  String selectedgender = 'Select your gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MyComponents.widthSize(context),
          height: MyComponents.heightSize(context),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(MyComponents.loginRegisterBackground)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyComponents.appbarWithTitle(
                    context, '', false, [], MyTheme.transparent),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 8.0,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyTheme.backgroundBox,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: TextField(
                      controller: namecontroller,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.rubik(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.4,
                          decoration: TextDecoration.none),
                      cursorColor: MyTheme.blackColor,
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: 'Name',
                        hintStyle: GoogleFonts.rubik(
                            color: MyTheme.greyColor,
                            fontSize: 18,
                            letterSpacing: 0.4),
                        prefixIcon: Icon(
                          Icons.person_rounded,
                          color: MyTheme.greyColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 8.0,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10.0),
                    padding: const EdgeInsets.only(right: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: MyTheme.backgroundBox,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MyComponents.widthSize(context) / 1.6,
                            height: kToolbarHeight - 8.0,
                            child: TextField(
                              controller: mobilenumber,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  decoration: TextDecoration.none),
                              cursorColor: MyTheme.blackColor,
                              decoration: InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                counterText: '',
                                hintText: 'Mobile Number',
                                hintStyle: GoogleFonts.rubik(
                                    color: MyTheme.greyColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4),
                                prefixIcon: Icon(
                                  Icons.call_rounded,
                                  color: MyTheme.greyColor,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.info_outline_rounded,
                              color: MyTheme.greyColor,
                            ),
                            onPressed: () {
                              MyComponents.toast(
                                  'Your privacy is important to Us. After registration, Your Mobile Number will be only visible to person whose request are accepted from your end.');
                            },
                          ),
                        ]),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 8.0,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, bottom: 10.0),
                    padding: const EdgeInsets.only(left: 15.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyTheme.backgroundBox,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.wc_rounded,
                            color: MyTheme.greyColor,
                          ),
                          const SizedBox(width: kToolbarHeight - 46.0),
                          Expanded(
                            child: DropdownButton(
                                isExpanded: true,
                                hint: Text(
                                  selectedgender,
                                  style: GoogleFonts.rubik(
                                      color:
                                          selectedgender == 'Select your gender'
                                              ? MyTheme.greyColor
                                              : MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      decoration: TextDecoration.none),
                                ),
                                icon: Icon(Icons.keyboard_arrow_down,
                                    color: MyTheme.blackColor),
                                iconSize: 26.0,
                                underline: const SizedBox.shrink(),
                                items: HardCodeData.gender
                                    .map<DropdownMenuItem<String>>(
                                        (String values) {
                                  return DropdownMenuItem<String>(
                                    value: values,
                                    child: Text(
                                      values,
                                      style: GoogleFonts.rubik(
                                          color: MyTheme.blackColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          decoration: TextDecoration.none),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (Object? value) {
                                  setState(() {
                                    selectedgender = value.toString();
                                  });
                                }),
                          ),
                          const SizedBox(width: 14.0),
                        ]),
                  ),
                  isLoading
                      ? SizedBox(
                          height: kToolbarHeight - 8.0,
                          child: MyComponents.circularLoader(
                              MyTheme.whiteColor, MyTheme.baseColor),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                              left: 30.0, right: 30.0, bottom: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (mobilenumber.text.isEmpty) {
                                MyComponents.toast('Please enter full name');
                                return;
                              }
                              if (namecontroller.text.isEmpty) {
                                MyComponents.toast(
                                    'Please enter mobile number');
                                return;
                              }
                              if (mobilenumber.text.length < 10) {
                                MyComponents.toast(
                                    'Please enter 10 digit mobile number');
                                return;
                              }
                              if (selectedgender == 'Select your gender') {
                                MyComponents.toast('Please select your gender');
                                return;
                              }
                              MyComponents.unFocused(context);
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                Future<RegisterOtp> data =
                                    ApiService.postregister(
                                        namecontroller.text,
                                        mobilenumber.text,
                                        selectedgender.substring(0, 1));
                                data.then((value) {
                                  if (value.status) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    MyComponents.toast(value.message);
                                    MyComponents.navPush(
                                      context,
                                      (p0) => RequestOTP(
                                          mobileNumber: mobilenumber.text,
                                          titleHeader: 'LoginRegister',
                                          emailAddress: ''),
                                    );
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    MyComponents.toast(value.message);
                                  }
                                });
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                MyComponents.toast(MyComponents.kErrorMesage);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.redColor,
                              fixedSize: Size(
                                  MyComponents.widthSize(context) / 2.4,
                                  kToolbarHeight - 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: FittedBox(
                              child: Text(
                                'Register',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: MyTheme.whiteColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 26,
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    child: FittedBox(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'By clicking this register, you accept\nour ',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    MyComponents.navPush(context,
                                        (p0) => const TermsConditionScreen());
                                  },
                                  child: Text(
                                    'Terms and Conditions',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor: MyTheme.whiteColor,
                                        decorationThickness: 2.5),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Text(
                                  ' & ',
                                  style: GoogleFonts.inter(
                                      color: MyTheme.whiteColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    MyComponents.navPush(context,
                                        (p0) => const PrivacyPolicyScreen());
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        decorationColor: MyTheme.whiteColor,
                                        decorationThickness: 2.5),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.only(
                        left: 40.0, top: 10.0, right: 38.0, bottom: 20.0),
                    child: FittedBox(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Already you are a member? ',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    clearData();
                                    MyComponents.navPop(context);
                                  },
                                  child: Text(
                                    'Back to Login',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ]),
              ]),
        ),
      ),
    );
  }

  clearData() {
    namecontroller.clear();
    mobilenumber.clear();
    selectedgender = 'Male';
  }
}
