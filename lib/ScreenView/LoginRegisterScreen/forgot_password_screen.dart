import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/request_otp_screen.dart';

class ForgotPasswordscreen extends StatefulWidget {
  const ForgotPasswordscreen({super.key});

  @override
  State<ForgotPasswordscreen> createState() => _ForgotPasswordscreenState();
}

class _ForgotPasswordscreenState extends State<ForgotPasswordscreen> {
  TextEditingController mobilenumber = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, '', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 46.0),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0),
            alignment: Alignment.center,
            child: Text(
              'Forgot your password?',
              style: GoogleFonts.rubik(
                  fontSize: 20, color: MyTheme.blackColor, letterSpacing: 0.4),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            alignment: Alignment.center,
            child: Text(
              'Enter your registered mobile number below\nto receive password reset instruction.',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 14, color: MyTheme.greyColor, letterSpacing: 0.4),
            ),
          ),
          Image.asset(MyComponents.otpVerify,
              width: MyComponents.widthSize(context),
              height: kToolbarHeight + 184.0),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 6.0,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: MyTheme.transparent,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: MyTheme.greyColor),
            ),
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
                hintText: 'Mobile No',
                hintStyle: GoogleFonts.rubik(
                    color: MyTheme.greyColor,
                    fontSize: 18,
                    letterSpacing: 0.4,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 36.0,
            margin: const EdgeInsets.only(
                left: 40.0, top: 10.0, right: 40.0, bottom: 20.0),
            child: FittedBox(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Remember password? ',
                    style: GoogleFonts.inter(
                        color: MyTheme.blackColor,
                        fontSize: 18,
                        letterSpacing: 0.4),
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            mobilenumber.clear();
                            MyComponents.navPop(context);
                          },
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: MyTheme.baseColor,
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
          isLoading
              ? SizedBox(
                  height: kToolbarHeight - 6.0,
                  child: MyComponents.circularLoader(
                      MyTheme.transparent, MyTheme.redColor),
                )
              : ElevatedButton(
                  onPressed: () {
                    if (mobilenumber.text.isEmpty) {
                      MyComponents.toast('Please enter mobile number.');
                      return;
                    }
                    if (mobilenumber.text.length < 10) {
                      MyComponents.toast(
                          'Please enter 10 digit mobile number.');
                      return;
                    }
                    MyComponents.unFocused(context);
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      Future<LoginOtpVerify> data =
                          ApiService.postloginmobileotp(
                              'otp', mobilenumber.text, '');
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
                                titleHeader: 'Forgot Password',
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
                    backgroundColor: MyTheme.baseColor,
                    fixedSize: Size(MyComponents.widthSize(context) / 2.4,
                        kToolbarHeight - 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: FittedBox(
                    child: Text(
                      'Send',
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
    );
  }
}
