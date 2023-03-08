import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/email_validator.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/request_otp_screen.dart';

class ProfileSettingScreen extends StatefulWidget {
  final String titleHeader, emailaddress, userIdData;
  final bool isvisibleToAll, isProtectPhoto;
  const ProfileSettingScreen(
      {Key? key,
      required this.titleHeader,
      required this.emailaddress,
      required this.isvisibleToAll,
      required this.isProtectPhoto,
      required this.userIdData})
      : super(key: key);

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  String deletedprofile = 'Select delete reason', deleteProfileStatus = '';
  TextEditingController emailverify = TextEditingController(),
      currentpassword = TextEditingController(),
      newpassword = TextEditingController(),
      confirmpassword = TextEditingController(),
      deleteReason = TextEditingController();
  bool isLoadingButton = false,
      isLoadingEmail = false,
      showPassword = false,
      showPassword2 = false,
      showPassword3 = false,
      isvisible = false,
      isphoto = false,
      isdeleteVisible = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    setState(() {
      if (widget.titleHeader == 'Edit Email Address') {
        if (widget.emailaddress.isNotEmpty) {
          emailverify.text = widget.emailaddress;
        }
      } else if (widget.titleHeader == 'Profile Privacy') {
        isvisible = widget.isvisibleToAll;
        isphoto = widget.isProtectPhoto;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, widget.titleHeader, true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          if (widget.titleHeader == 'Edit Email Address')
            Column(children: [
              SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 26.0),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                margin: const EdgeInsets.only(
                    left: 10.0, top: 20.0, right: 10.0, bottom: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: MyTheme.blackColor),
                  color: MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: emailverify,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4),
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: SharedPrefs.isEmailVerified
                      ? Container(
                          width: kToolbarHeight + 120.0,
                          height: kToolbarHeight - 26.0,
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: MyTheme.greenColor),
                          child: FittedBox(
                            child: Text(
                              'Verified E-mail',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  color: MyTheme.whiteColor),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()),
            ]),
          if (widget.titleHeader == 'Profile Privacy')
            Column(children: [
              SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 26.0),
              CheckboxListTile(
                title: Text(
                  'Visible to paid members Only',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4),
                ),
                value: isvisible,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (newValue) {
                  setState(() {
                    isvisible = newValue!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Visible to Interest Accepted members Only',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4),
                ),
                value: isphoto,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (newValue) {
                  setState(() {
                    isphoto = newValue!;
                  });
                },
              ),
            ]),
          if (widget.titleHeader == 'Delete Profile')
            Column(children: [
              SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 26.0),
              Container(
                width: MyComponents.widthSize(context),
                padding: const EdgeInsets.only(
                    left: 15.0, bottom: 15.0, right: 15.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Please choose a reason for profile deletion.\n',
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: 'Note:',
                      style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: MyTheme.baseColor,
                          letterSpacing: 0.4),
                    ),
                    TextSpan(
                      text: ' *Cannot restored once your profile deleted.',
                      style: GoogleFonts.rubik(
                          fontSize: 14,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4),
                    ),
                  ]),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: MyTheme.greyColor,
                  ),
                ),
                child: DropdownSearch<String>(
                  items: HardCodeData.deleteprofile,
                  selectedItem: deletedprofile,
                  dropdownButtonProps: DropdownButtonProps(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 2.0),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 24,
                      color: MyTheme.blackColor,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      deletedprofile = value!;
                      for (var i = 0;
                          i < HardCodeData.deleteprofile.length;
                          i++) {
                        if (deletedprofile == HardCodeData.deleteprofile[i]) {
                          deleteProfileStatus = '${i + 1}';
                        }
                      }
                    });
                  },
                  popupProps: const PopupPropsMultiSelection.menu(
                      showSearchBox: false, fit: FlexFit.loose),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        hintText: 'Select delete reason',
                        hintStyle: TextStyle(
                            color: MyTheme.blackColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            decoration: TextDecoration.none),
                        border: InputBorder.none),
                  ),
                ),
              ),
              Visibility(
                visible: isdeleteVisible,
                child: Container(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight + 84.0,
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 5.0),
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: MyTheme.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: MyTheme.greyColor),
                  ),
                  child: TextField(
                    controller: deleteReason,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                        color: MyTheme.blackColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    cursorColor: MyTheme.blackColor,
                    decoration: InputDecoration(
                      hintText: 'Enter your delete profile reason',
                      hintStyle: TextStyle(
                          color: MyTheme.greyColor,
                          fontSize: 18,
                          letterSpacing: 0.4,
                          decoration: TextDecoration.none),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ]),
          if (widget.titleHeader == 'Change Password')
            Column(children: [
              SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 26.0),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  'Your password must have a minimum of 6 characters. '
                  'We recommend you choose an alphanumeric password. '
                  'E.g.: Matri123',
                  style: GoogleFonts.rubik(
                      color: MyTheme.blackColor, letterSpacing: 0.4),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: MyTheme.blackColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: currentpassword,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword ? false : true,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      decoration: TextDecoration.none),
                  cursorColor: MyTheme.blackColor,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter current password',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
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
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: MyTheme.blackColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: newpassword,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword2 ? false : true,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      decoration: TextDecoration.none),
                  cursorColor: MyTheme.blackColor,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter new password',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword2 ? Icons.visibility : Icons.visibility_off,
                        color: MyTheme.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword2 = !showPassword2;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: MyTheme.blackColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: confirmpassword,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword3 ? false : true,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      decoration: TextDecoration.none),
                  cursorColor: MyTheme.blackColor,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter confirm password',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword3 ? Icons.visibility : Icons.visibility_off,
                        color: MyTheme.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword3 = !showPassword3;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ]),
          if (widget.titleHeader == 'Forgot Password')
            Column(children: [
              SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 26.0),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                child: Text(
                  'Your password must have a minimum of 6 characters. '
                  'We recommend you choose an alphanumeric password. '
                  'E.g.: Matri123',
                  style: GoogleFonts.rubik(
                      color: MyTheme.blackColor, letterSpacing: 0.4),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: MyTheme.blackColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: newpassword,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword2 ? false : true,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      decoration: TextDecoration.none),
                  cursorColor: MyTheme.blackColor,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter new password',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword2 ? Icons.visibility : Icons.visibility_off,
                        color: MyTheme.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword2 = !showPassword2;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight - 6.0,
                margin: const EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: MyTheme.blackColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: confirmpassword,
                  keyboardType: TextInputType.text,
                  obscureText: showPassword3 ? false : true,
                  style: TextStyle(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.4,
                      decoration: TextDecoration.none),
                  cursorColor: MyTheme.blackColor,
                  decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter confirm password',
                    hintStyle: TextStyle(
                        color: MyTheme.greyColor,
                        fontSize: 18,
                        letterSpacing: 0.4,
                        decoration: TextDecoration.none),
                    suffixIcon: IconButton(
                      icon: Icon(
                        showPassword3 ? Icons.visibility : Icons.visibility_off,
                        color: MyTheme.greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          showPassword3 = !showPassword3;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ]),
          SizedBox(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 26.0),
          isLoadingButton
              ? SizedBox(
                  height: kToolbarHeight - 6.0,
                  child: MyComponents.circularLoader(
                      MyTheme.whiteColor, MyTheme.baseColor),
                )
              : SizedBox(
                  height: kToolbarHeight - 6.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, bottom: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              clearData();
                              MyComponents.navPop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyTheme.baseColor),
                            child: FittedBox(
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    color: MyTheme.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(bottom: 20.0, right: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.titleHeader == 'Edit Email Address') {
                                emailUpdate();
                              } else if (widget.titleHeader ==
                                  'Profile Privacy') {
                                setProfilePrivacy();
                              } else if (widget.titleHeader ==
                                  'Delete Profile') {
                                deleteProfileData();
                              } else if (widget.titleHeader ==
                                  'Change Password') {
                                passwordChange();
                              } else if (widget.titleHeader ==
                                  'Forgot Password') {
                                forgetPassword();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyTheme.whiteColor),
                            child: FittedBox(
                              child: Text(
                                setTextData(),
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    color: MyTheme.baseColor),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
        ]),
      ),
    );
  }

  clearData() {
    emailverify.clear();
    currentpassword.clear();
    newpassword.clear();
    confirmpassword.clear();
    deleteReason.clear();
    deletedprofile = 'Select delete reason';
  }

  String setTextData() {
    String dataText = '';
    if (widget.titleHeader == 'Edit Email Address') {
      dataText = 'Save & Verify';
    } else if (widget.titleHeader == 'Profile Privacy') {
      dataText = 'Apply';
    } else if (widget.titleHeader == 'Delete Profile') {
      dataText = 'Delete';
    } else if (widget.titleHeader == 'Change Password') {
      dataText = 'Change Password';
    } else if (widget.titleHeader == 'Forgot Password') {
      dataText = 'Reset Password';
    }
    return dataText;
  }

  emailUpdate() {
    if (emailverify.text.isEmpty) {
      MyComponents.toast('Please enter email address.');
      return;
    }
    if (!EmailValidator.validate(emailverify.text)) {
      MyComponents.toast('Please enter valid email address.');
      return;
    }
    setState(() {
      isLoadingButton = true;
    });
    ApiService.postUpdateVerifyEmail(emailverify.text).then((value) {
      setState(() {
        isLoadingButton = false;
      });
      MyComponents.toast(value.message);
      if (value.status) {
        MyComponents.navPush(
          context,
          (p0) => RequestOTP(
              titleHeader: 'Email Verification',
              mobileNumber: '',
              emailAddress: emailverify.text),
        );
      }
    });
  }

  setProfilePrivacy() {
    if (!isvisible && !isphoto) {
      MyComponents.toast('Please choose any one option.');
      return;
    }
    setState(() {
      isLoadingButton = true;
    });
    try {
      Future<ProfilePrivacy> profile = ApiService.postprofileprivacy(
          isvisible ? '1' : '0', isphoto ? '1' : '0');
      profile.then((value) {
        if (value.status) {
          setState(() {
            isLoadingButton = false;
            MyComponents.toast(value.message);
          });
        }
      });
    } catch (e) {
      setState(() {
        isLoadingButton = false;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  deleteProfileData() {
    if (deletedprofile == 'Select delete reason') {
      MyComponents.toast('Please choose anyone reason');
      return;
    }
    setState(() {
      isLoadingButton = true;
    });
    ApiService.deleteProfile(deleteProfileStatus).then((value) {
      if (value.status) {
        MyComponents.toast(value.message);
        setState(() {
          isLoadingButton = false;
        });
        SharedPrefs.sharedClear();
        MyComponents.navPushAndRemoveUntil(
            context, (p0) => const LoginScreen(), false);
      } else {
        setState(() {
          isLoadingButton = false;
        });
        MyComponents.toast(value.message);
      }
    }).onError((error, stackTrace) {
      setState(() {
        isLoadingButton = false;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    });
  }

  passwordChange() {
    if (currentpassword.text.isEmpty) {
      MyComponents.toast('Please enter current password.');
      return;
    }
    if (newpassword.text.isEmpty) {
      MyComponents.toast('Please enter new password.');
      return;
    }
    if (confirmpassword.text.isEmpty) {
      MyComponents.toast('Please enter confirm password.');
      return;
    }
    if (currentpassword.text == newpassword.text) {
      MyComponents.toast('New password same as old password.');
      return;
    }
    if (newpassword.text != confirmpassword.text) {
      MyComponents.toast('New password and confirm password is mismatched.');
      return;
    }
    if (newpassword.text.length < 6 && confirmpassword.text.length < 6) {
      MyComponents.toast('Please enter minimum 6 characters password.');
      return;
    }
    setState(() {
      isLoadingButton = true;
    });
    Future<ChangePassword> password = ApiService.postChangePassword(
        currentpassword.text, newpassword.text, confirmpassword.text);
    password.then((value) {
      setState(() {
        isLoadingButton = false;
      });
      if (value.status) {
        MyComponents.toast(value.message);
      } else {
        MyComponents.toast(MyComponents.kErrorMesage);
      }
    });
  }

  forgetPassword() {
    if (newpassword.text.isEmpty) {
      MyComponents.toast('Please enter new password.');
      return;
    }
    if (confirmpassword.text.isEmpty) {
      MyComponents.toast('Please enter confirm password.');
      return;
    }
    if (newpassword.text != confirmpassword.text) {
      MyComponents.toast('New password and confirm password is mismatched.');
      return;
    }
    if (newpassword.text.length < 6 && confirmpassword.text.length < 6) {
      MyComponents.toast('Please enter minimum 6 characters password.');
      return;
    }
    setState(() {
      isLoadingButton = true;
    });
    Future<ChangePassword> values = ApiService.postForgetPassword(
        widget.userIdData, newpassword.text, confirmpassword.text);
    values.then((value) {
      setState(() {
        isLoadingButton = false;
      });
      if (value.status) {
        MyComponents.toast(value.message);
        MyComponents.navPushAndRemoveUntil(
            context, (p0) => const LoginScreen(), false);
      } else {
        MyComponents.toast(MyComponents.kErrorMesage);
      }
    });
  }
}
