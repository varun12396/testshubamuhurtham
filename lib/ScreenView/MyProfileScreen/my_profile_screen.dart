import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/login_activity_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/astro_detail_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/information_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/partner_prefrence_screen.dart';
import 'package:myshubamuhurtham/ScreenView/MyProfileScreen/about_me_screen.dart';
import 'package:myshubamuhurtham/ScreenView/MyProfileScreen/gallery_screen.dart';
import 'package:myshubamuhurtham/ScreenView/MyProfileScreen/profile_settings_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/about_us_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/blogs_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/customer_care_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/events_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/invoice_history_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/subscription_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool isPageLoading = true, isProfileComplete = true, isWidgetExpand = true;
  List<SettingList> settingList = [];
  double valueData = 0.9;
  int linearPercent = 90;
  String networkImage = '';
  List<MyProfileMessage> profilemessage = [];
  @override
  void initState() {
    super.initState();
    if (SharedPrefs.isVerified) {
      settingList = const [
        SettingList(textTitle: 'About MySelf', imageView: 'images/editing.png'),
        SettingList(
            textTitle: 'Basic Information', imageView: 'images/user_info.png'),
        SettingList(
            textTitle: 'Astrology Details', imageView: 'images/zodiac.png'),
        SettingList(
            textTitle: 'Partner Preference',
            imageView: 'images/partner_pref.png'),
        SettingList(
            textTitle: 'Profile Settings',
            imageView: 'images/profile_setting.png'),
        SettingList(textTitle: 'Blogs', imageView: 'images/blog.png'),
        SettingList(textTitle: 'Events', imageView: 'images/events.png'),
        SettingList(textTitle: 'Subscription', imageView: 'images/renew.png'),
        SettingList(
            textTitle: 'Invoice History', imageView: 'images/invoice.png'),
        SettingList(
            textTitle: 'Login Activity', imageView: 'images/activity.png'),
        SettingList(
            textTitle: 'Customer Care', imageView: 'images/customer_care.png'),
        SettingList(textTitle: 'App info', imageView: 'images/info.png'),
        SettingList(textTitle: 'Log Out', imageView: 'images/logout.png'),
      ];
    } else {
      settingList = const [
        SettingList(textTitle: 'About MySelf', imageView: 'images/editing.png'),
        SettingList(
            textTitle: 'Basic Information', imageView: 'images/user_info.png'),
        SettingList(
            textTitle: 'Astrology Details', imageView: 'images/zodiac.png'),
        SettingList(
            textTitle: 'Partner Preference',
            imageView: 'images/partner_pref.png'),
        SettingList(
            textTitle: 'Profile Settings',
            imageView: 'images/profile_setting.png'),
        SettingList(textTitle: 'Blogs', imageView: 'images/blog.png'),
        SettingList(textTitle: 'Events', imageView: 'images/events.png'),
        SettingList(
            textTitle: 'Login Activity', imageView: 'images/activity.png'),
        SettingList(
            textTitle: 'Customer Care', imageView: 'images/customer_care.png'),
        SettingList(textTitle: 'App info', imageView: 'images/info.png'),
        SettingList(textTitle: 'Log Out', imageView: 'images/logout.png'),
      ];
    }
    try {
      Future<MyProfileData> profiledata = ApiService.postprofilelist();
      profiledata.then((value) {
        if (value.status) {
          if (!mounted) return;
          setState(() {
            profilemessage.addAll(value.message);
            if (profilemessage[0].isEmailVerified == '1') {
              linearPercent = linearPercent + 10;
              valueData = linearPercent / 100;
            }
          });
          ApiService.getgalleryphotolist().then((value) {
            for (var i = 0; i < value.message.length; i++) {
              if (value.message[i].deleteStatus != '1') {
                if (value.message[i].isPrimary == '1') {
                  networkImage =
                      '${MyComponents.imageBaseUrl}${profilemessage[0].hasEncode}/${value.message[i].photoUrl}';
                }
              }
            }
            if (!mounted) return;
            setState(() {
              isPageLoading = false;
            });
          });
        }
      });
    } catch (e) {
      setState(() {
        isPageLoading = false;
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          isPageLoading
              ? fadeShimmer()
              : Column(children: [
                  Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.only(top: 10.0, left: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getProfilePic(),
                          Container(
                            width: MyComponents.widthSize(context) / 1.7,
                            margin: const EdgeInsets.only(right: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      profilemessage[0].profileNo,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.baseColor,
                                          letterSpacing: 0.4),
                                    ),
                                  ),
                                  SharedPrefs.getSubscribeId == '1'
                                      ? Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text:
                                                    '${profilemessage[0].userName} ',
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: MyTheme.blackColor,
                                                    letterSpacing: 0.4),
                                                children: [
                                                  WidgetSpan(
                                                    child: Image.asset(
                                                        MyComponents.crownImage,
                                                        width: 28.0,
                                                        height: 28.0),
                                                  )
                                                ]),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            profilemessage[0].userName,
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: MyTheme.blackColor,
                                                letterSpacing: 0.4),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      getProfession(),
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 16.0,
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        var result = await MyComponents.navPush(
                            context,
                            (p0) => GalleryScreen(
                                hashData: profilemessage[0].hasEncode));
                        if (result != null || result.toString().isNotEmpty) {
                          setState(() {
                            networkImage = result.toString();
                          });
                        }
                      },
                      child: Text(
                        'Add/Edit Photos',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w400,
                            color: MyTheme.linearGreenColor),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: MyComponents.widthSize(context),
                      padding: EdgeInsets.only(
                          bottom: linearPercent == 100 ? 30.0 : 0.0),
                      color: MyTheme.backgroundColor,
                      child: Column(children: [
                        ListTile(
                          title: Text(
                            linearPercent == 100
                                ? 'Profile Completed'
                                : 'Complete your profile',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                letterSpacing: 0.4,
                                color: MyTheme.blackColor),
                          ),
                          trailing: Container(
                            width: MyComponents.widthSize(context) / 3.0,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, bottom: 8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '$linearPercent%',
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        color: MyTheme.blackColor),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          padding: EdgeInsets.only(
                              right: linearPercent == 100 ? 0.0 : 20.0),
                          decoration: BoxDecoration(
                              color: MyTheme.greyColor,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: FadeShimmer(
                            width: MyComponents.widthSize(context),
                            height: kToolbarHeight - 42.0,
                            radius: 10.0,
                            baseColor: MyTheme.linearGreenColor,
                            highlightColor: MyTheme.lightGreenColor,
                          ),
                        ),
                        linearPercent == 100
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onPressed: () {
                                    MyComponents.navPush(
                                        context,
                                        (p0) => ProfileSettingScreen(
                                            userIdData: '',
                                            emailaddress:
                                                profilemessage[0].email.isEmpty
                                                    ? ''
                                                    : profilemessage[0].email,
                                            isProtectPhoto: false,
                                            isvisibleToAll: false,
                                            titleHeader: 'Edit Email Address'));
                                  },
                                  child: Text(
                                    'Verify Mail +10%',
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
                ]),
          ListView.builder(
              itemCount: settingList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(children: [
                  ListTile(
                    tileColor: MyTheme.whiteColor,
                    onTap: () {
                      if (SharedPrefs.isVerified) {
                        switch (index) {
                          case 0:
                            MyComponents.navPush(
                                context, (p0) => const AboutMeScreen());
                            break;
                          case 1:
                            MyComponents.navPush(
                              context,
                              (p0) => const InformationScreen(
                                  isProfileCreatedbyAdmin: ''),
                            );
                            break;
                          case 2:
                            MyComponents.navPush(
                                context,
                                (p0) => const AstroDetailScreen(
                                    isProfileCreatedbyAdmin: ''));
                            break;
                          case 3:
                            MyComponents.navPush(
                                context,
                                (p0) => const PartnerPrefrenceScreen(
                                    isProfileCreatedbyAdmin: ''));
                            break;
                          case 4:
                            setState(() {
                              isWidgetExpand = !isWidgetExpand;
                            });
                            break;
                          case 5:
                            MyComponents.navPush(
                                context, (p0) => const BlogScreen());
                            break;
                          case 6:
                            MyComponents.navPush(
                                context, (p0) => const EventScreen());
                            break;
                          case 7:
                            MyComponents.navPush(
                                context, (p0) => const SubscriptionScreen());
                            break;
                          case 8:
                            MyComponents.navPush(
                                context, (p0) => const InvoiceHistoryScreen());
                            break;
                          case 9:
                            MyComponents.navPush(
                                context, (p0) => const LoginActivityScreen());
                            break;
                          case 10:
                            MyComponents.navPush(
                                context, (p0) => const CustomerCareScreen());
                            break;

                          case 11:
                            MyComponents.navPush(
                                context, (p0) => const AppInfoScreen());
                            break;
                          case 12:
                            try {
                              SharedPrefs.sharedClear();
                              MyComponents.navPushAndRemoveUntil(
                                  context, (p0) => const LoginScreen(), false);
                              MyComponents.toast('Logout Sucessfully.');
                              Future<ProfileDeleteLogout> logout =
                                  ApiService.getlogout();
                              logout.then((value) {});
                            } catch (e) {
                              MyComponents.toast(MyComponents.kErrorMesage);
                            }
                            break;
                        }
                      } else {
                        switch (index) {
                          case 0:
                            MyComponents.navPush(
                                context, (p0) => const AboutMeScreen());
                            break;
                          case 1:
                            MyComponents.navPush(
                              context,
                              (p0) => const InformationScreen(
                                  isProfileCreatedbyAdmin: ''),
                            );
                            break;
                          case 2:
                            MyComponents.navPush(
                                context,
                                (p0) => const AstroDetailScreen(
                                    isProfileCreatedbyAdmin: ''));
                            break;
                          case 3:
                            MyComponents.navPush(
                                context,
                                (p0) => const PartnerPrefrenceScreen(
                                    isProfileCreatedbyAdmin: ''));
                            break;
                          case 4:
                            setState(() {
                              isWidgetExpand = !isWidgetExpand;
                            });
                            break;
                          case 5:
                            MyComponents.navPush(
                                context, (p0) => const BlogScreen());
                            break;
                          case 6:
                            MyComponents.navPush(
                                context, (p0) => const EventScreen());
                            break;
                          case 7:
                            MyComponents.navPush(
                                context, (p0) => const LoginActivityScreen());
                            break;
                          case 8:
                            MyComponents.navPush(
                                context, (p0) => const CustomerCareScreen());
                            break;
                          case 9:
                            MyComponents.navPush(
                                context, (p0) => const AppInfoScreen());
                            break;
                          case 10:
                            try {
                              SharedPrefs.sharedClear();
                              MyComponents.navPushAndRemoveUntil(
                                  context, (p0) => const LoginScreen(), false);
                              MyComponents.toast('Logout Sucessfully.');
                              Future<ProfileDeleteLogout> logout =
                                  ApiService.getlogout();
                              logout.then((value) {});
                            } catch (e) {
                              MyComponents.toast(MyComponents.kErrorMesage);
                            }
                            break;
                        }
                      }
                    },
                    leading: Image.asset(
                      settingList[index].imageView,
                      width: 30.0,
                      height: 30.0,
                    ),
                    title: Text(
                      settingList[index].textTitle,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4),
                    ),
                    trailing: settingList[index].textTitle == 'Log Out'
                        ? const SizedBox.shrink()
                        : index == 4 && !isWidgetExpand
                            ? Icon(Icons.keyboard_arrow_down_rounded,
                                color: MyTheme.blackColor)
                            : Icon(Icons.keyboard_arrow_right_rounded,
                                color: MyTheme.blackColor),
                  ),
                  if (index == 4 && !isWidgetExpand)
                    ListTile(
                        leading: Image.asset(MyComponents.emailVerifyImage,
                            width: 30.0, height: 30.0),
                        tileColor: MyTheme.whiteColor,
                        title: Text(
                          'Edit Email Address',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,
                            color: MyTheme.blackColor),
                        onTap: () {
                          MyComponents.navPush(
                              context,
                              (p0) => ProfileSettingScreen(
                                  userIdData: '',
                                  emailaddress: profilemessage[0].email.isEmpty
                                      ? ''
                                      : profilemessage[0].email,
                                  isProtectPhoto: false,
                                  isvisibleToAll: false,
                                  titleHeader: 'Edit Email Address'));
                        }),
                  if (index == 4 && !isWidgetExpand)
                    ListTile(
                        leading: Image.asset(MyComponents.changePasswordImage,
                            width: 30.0, height: 30.0),
                        tileColor: MyTheme.whiteColor,
                        title: Text(
                          'Change Password',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,
                            color: MyTheme.blackColor),
                        onTap: () {
                          MyComponents.navPush(
                              context,
                              (p0) => const ProfileSettingScreen(
                                  userIdData: '',
                                  emailaddress: '',
                                  isProtectPhoto: false,
                                  isvisibleToAll: false,
                                  titleHeader: 'Change Password'));
                        }),
                  if (index == 4 &&
                      !isWidgetExpand &&
                      SharedPrefs.getSubscribeId == '1')
                    ListTile(
                        leading: Image.asset(MyComponents.privacyProfileImage,
                            width: 30.0, height: 30.0),
                        tileColor: MyTheme.whiteColor,
                        title: Text(
                          'Profile Privacy',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,
                            color: MyTheme.blackColor),
                        onTap: () {
                          MyComponents.navPush(
                              context,
                              (p0) => ProfileSettingScreen(
                                  userIdData: '',
                                  emailaddress: '',
                                  isProtectPhoto:
                                      profilemessage[0].protectPhoto == '0',
                                  isvisibleToAll:
                                      profilemessage[0].visibleToAll == '0',
                                  titleHeader: 'Profile Privacy'));
                        }),
                  if (index == 4 && !isWidgetExpand)
                    ListTile(
                        leading: Image.asset(MyComponents.deleteProfileImage,
                            width: 30.0, height: 30.0),
                        tileColor: MyTheme.whiteColor,
                        title: Text(
                          'Delete Profile',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded,
                            color: MyTheme.blackColor),
                        onTap: () {
                          MyComponents.navPush(
                              context,
                              (p0) => const ProfileSettingScreen(
                                  userIdData: '',
                                  emailaddress: '',
                                  isProtectPhoto: false,
                                  isvisibleToAll: false,
                                  titleHeader: 'Delete Profile'));
                        }),
                ]);
              }),
        ]),
      ),
    );
  }

  getProfession() {
    String profession = '';
    for (var element in MyComponents.occupationData) {
      if (element.occupationId == profilemessage[0].professionId) {
        profession = element.occupationName;
      }
    }
    return profession;
  }

  getProfilePic() {
    if (networkImage.isEmpty) {
      if (profilemessage[0].gender == 'M') {
        return CircleAvatar(
          radius: 60,
          backgroundColor: MyTheme.whiteColor,
          backgroundImage: NetworkImage(MyComponents.maleNetPicture),
        );
      } else {
        return CircleAvatar(
          radius: 60,
          backgroundColor: MyTheme.whiteColor,
          backgroundImage: NetworkImage(MyComponents.femaleNetPicture),
        );
      }
    } else {
      return CircleAvatar(
        radius: 60,
        backgroundColor: MyTheme.whiteColor,
        backgroundImage: NetworkImage(networkImage),
      );
    }
  }

  fadeShimmer() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FadeShimmer.round(
                size: 100,
                baseColor: MyTheme.greyColor,
                highlightColor: MyTheme.whiteColor,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeShimmer(
                    baseColor: MyTheme.greyColor,
                    highlightColor: MyTheme.whiteColor,
                    height: kToolbarHeight - 46.0,
                    radius: 8,
                    width: MyComponents.widthSize(context) / 2.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FadeShimmer(
                    baseColor: MyTheme.greyColor,
                    highlightColor: MyTheme.whiteColor,
                    height: kToolbarHeight - 46.0,
                    radius: 8,
                    width: MyComponents.widthSize(context) / 2.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FadeShimmer(
                    baseColor: MyTheme.greyColor,
                    highlightColor: MyTheme.whiteColor,
                    height: kToolbarHeight - 26.0,
                    radius: 8,
                    width: MyComponents.widthSize(context) / 2.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class SettingList {
  final String textTitle;
  final String imageView;
  const SettingList({required this.textTitle, required this.imageView});
}
