import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/view_details_screen.dart';

class SentHistoryScreen extends StatefulWidget {
  const SentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SentHistoryScreen> createState() => _SentHistoryScreenState();
}

class _SentHistoryScreenState extends State<SentHistoryScreen> {
  bool isLoading = true;
  List<SearchProfileMessage> senthistory = [];
  List<MyProfileMessage> myprofiledata = [];
  @override
  void initState() {
    super.initState();
    myprofiledata.clear();
    senthistory.clear();
    Future<MyProfileData> values = ApiService.postprofilelist();
    values.then((value1) {
      myprofiledata.addAll(value1.message);
      SharedPrefs.userGender(value1.message[0].gender);
      SharedPrefs.profileSubscribeId(value1.message[0].subscribedPremiumId);
    });
    ApiService.getsenthistory().then((value) {
      senthistory.addAll(value.message);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
            child: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: 'Dear Member: \n',
                  style: GoogleFonts.rubik(
                      color: MyTheme.blackColor,
                      fontSize: 20,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600),
                  children: [
                    const WidgetSpan(
                        child: SizedBox(height: kToolbarHeight - 26.0)),
                    TextSpan(
                      text:
                          'You can view Photos and Contact number of the members who Accepts your Interest by Clicking ',
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: '"VIEW PROFILE"',
                      style: GoogleFonts.inter(
                          color: MyTheme.baseColor,
                          fontSize: 18,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: '.',
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
              ? MyComponents.fadeShimmerList(true)
              : senthistory.isEmpty
                  ? SizedBox(
                      width: MyComponents.widthSize(context),
                      height: MyComponents.heightSize(context) / 1.6,
                      child: MyComponents.emptyDatatoshow(
                          context,
                          MyComponents.emptySearch,
                          'Sent history is empty.',
                          '',
                          false,
                          () {}),
                    )
                  : ListView.builder(
                      itemCount: senthistory.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 30.0),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0.0,
                          color: MyTheme.backgroundBox,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: MyTheme.greyColor)),
                          margin: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: getCircularImage(senthistory[index]),
                              ),
                              const SizedBox(width: kToolbarHeight - 50.0),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        senthistory[index].profileNo,
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            letterSpacing: 0.8,
                                            color: MyTheme.baseColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        width: MyComponents.widthSize(context) /
                                            1.8,
                                        padding: const EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: Row(children: [
                                          Icon(Icons.cake_rounded,
                                              color: MyTheme.greyColor,
                                              size: 28),
                                          Expanded(
                                            child: Text(
                                              ' ${MyComponents.formattedDateString(senthistory[index].dateOfBirth, 'dd-MM-yyyy')}',
                                              style: GoogleFonts.inter(
                                                  color: MyTheme.blackColor,
                                                  fontSize: 18,
                                                  letterSpacing: 0.8),
                                            ),
                                          ),
                                        ]),
                                      ),
                                      Container(
                                        width: MyComponents.widthSize(context) /
                                            1.8,
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: Row(children: [
                                          Icon(Icons.account_circle_rounded,
                                              color: MyTheme.greyColor,
                                              size: 28),
                                          Expanded(
                                            child: Text(
                                              ' ${senthistory[index].gender == 'M' ? 'Male' : 'Female'}',
                                              style: GoogleFonts.inter(
                                                  color: MyTheme.blackColor,
                                                  fontSize: 18,
                                                  letterSpacing: 0.8),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ]),
                              )
                            ]),
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.all(8.0),
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_month_rounded,
                                        color: MyTheme.greyColor),
                                  ),
                                  TextSpan(
                                    text:
                                        ' ${MyComponents.formattedDateString(senthistory[index].sentAt, 'dd-MM-yyyy hh:mm:ss')}',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        fixedSize: const Size(
                                            kToolbarHeight + 84.0,
                                            kToolbarHeight - 16.0),
                                        backgroundColor: MyTheme.transparent,
                                      ),
                                      onPressed: null,
                                      child: Text(
                                        getTextData(
                                            senthistory[index].interestStatus),
                                        style: GoogleFonts.inter(
                                            color: getTextColor(
                                                senthistory[index]
                                                    .interestStatus),
                                            fontSize: 18,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: MyTheme.baseColor),
                                      onPressed: () {
                                        MyComponents.navPush(
                                            context,
                                            (p0) => ViewProfileScreen(
                                                myprofile: myprofiledata[0],
                                                profiledata: senthistory[index],
                                                returnPage: 'Interest',
                                                screenType: 'Viewed'));
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.visibility_rounded),
                                            Text(
                                              ' View Profile',
                                              style: GoogleFonts.rubik(
                                                  color: MyTheme.whiteColor,
                                                  fontSize: 18,
                                                  letterSpacing: 0.8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ]),
                                    ),
                                  ]),
                            ),
                          ]),
                        );
                      }),
        ]),
      ),
    );
  }

  String getTextData(interestStatus) {
    String data = '';
    if (interestStatus == '1') {
      data = 'Accepted';
    } else if (interestStatus == '-1' ||
        interestStatus == null ||
        interestStatus.toString().isEmpty) {
      data = 'Pending';
    } else if (interestStatus == '0') {
      data = 'Not Accepted';
    }
    return data;
  }

  getTextColor(interestStatus) {
    if (interestStatus == '1') {
      return MyTheme.greenColor;
    } else if (interestStatus == '-1' ||
        interestStatus == null ||
        interestStatus.toString().isEmpty) {
      return MyTheme.yellowColor;
    } else if (interestStatus == '0') {
      return MyTheme.redColor;
    }
  }

  getCircularImage(SearchProfileMessage senthistory) {
    if (SharedPrefs.getSubscribeId == '1') {
      if (senthistory.showInterestAcceptedProfile == '1' ||
          senthistory.visibleToAll == '1' ||
          senthistory.protectPhoto == '1') {
        if (senthistory.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image.network(
              senthistory.messageAvatar,
              fit: BoxFit.cover,
              width: kToolbarHeight + 64.0,
              height: kToolbarHeight + 64.0,
              errorBuilder: (context, error, stackTrace) {
                return MyComponents.assetImageHolder();
              },
            ),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    } else {
      if (senthistory.protectPhoto == '1') {
        if (senthistory.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return InkWell(
            onTap: () {
              MyComponents.showDialogPreview(context,
                  MyComponents.kImageNetwork, senthistory.messageAvatar);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                senthistory.messageAvatar,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
                  return MyComponents.assetImageHolder();
                },
              ),
            ),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    }
  }
}
