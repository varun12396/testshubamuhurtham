import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/view_details_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/subscription_screen.dart';

class ReceivedHistoryScreen extends StatefulWidget {
  const ReceivedHistoryScreen({Key? key}) : super(key: key);

  @override
  State<ReceivedHistoryScreen> createState() => _ReceivedHistoryScreenState();
}

class _ReceivedHistoryScreenState extends State<ReceivedHistoryScreen> {
  bool isLoading = true, isLoading2 = false, isLoadingButton = false;
  TextEditingController rejectReason = TextEditingController();
  List<SearchProfileMessage> receivedhistory = [];
  List<MyProfileMessage> myprofiledata = [];
  String selectedReason = '';
  List<String> rejectReasonsList = [
    "Horoscope isn't matching",
    "User profile isn't up to the expectation",
    "Already found a match",
    "Other reasons"
  ];
  @override
  void initState() {
    super.initState();
    myprofiledata.clear();
    receivedhistory.clear();
    Future<MyProfileData> values = ApiService.postprofilelist();
    values.then((value1) {
      myprofiledata.addAll(value1.message);
      SharedPrefs.userGender(value1.message[0].gender);
      SharedPrefs.profileSubscribeId(value1.message[0].subscribedPremiumId);
    });
    ApiService.getreceivehistory().then((value) {
      receivedhistory.addAll(value.message);
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
                left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
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
                    SharedPrefs.getSubscribeId == '1'
                        ? TextSpan(
                            text: 'Congrats, when you "ACCEPT" the interest '
                                'received you can view Photos and contact '
                                'number of the member who showed Interest.',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          )
                        : TextSpan(
                            text:
                                'Congrats, when you "ACCEPT" the interest received '
                                'your contact number will be sent to the member '
                                'who showed Interest and they might contact you directly.\n'
                                'To view the contact numbers, kindly upgrade to premium subscription.\n',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                    WidgetSpan(
                      child: SharedPrefs.getSubscribeId == '1'
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                MyComponents.navPush(context,
                                    (p0) => const SubscriptionScreen());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Click here to Get Subscription.',
                                  style: GoogleFonts.inter(
                                      color: MyTheme.baseColor,
                                      fontSize: 20,
                                      letterSpacing: 0.8,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                    ),
                  ]),
            ),
          ),
          isLoading
              ? MyComponents.fadeShimmerList(true)
              : receivedhistory.isEmpty
                  ? SizedBox(
                      width: MyComponents.widthSize(context),
                      height: MyComponents.heightSize(context) / 1.6,
                      child: MyComponents.emptyDatatoshow(
                          context,
                          MyComponents.emptySearch,
                          'Received history is empty.',
                          '',
                          false,
                          () {}),
                    )
                  : ListView.builder(
                      itemCount: receivedhistory.length,
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
                              left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                          child: Column(children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: getCircularImage(receivedhistory[index]),
                              ),
                              const SizedBox(width: kToolbarHeight - 50.0),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        receivedhistory[index].profileNo,
                                        style: GoogleFonts.inter(
                                            color: MyTheme.baseColor,
                                            fontSize: 20,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, bottom: 4.0),
                                        child: RichText(
                                          text: TextSpan(children: [
                                            WidgetSpan(
                                              child: Icon(Icons.cake_rounded,
                                                  color: MyTheme.greyColor),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${MyComponents.formattedDateString(receivedhistory[index].dateOfBirth, 'dd-MM-yyyy')}',
                                              style: GoogleFonts.inter(
                                                  color: MyTheme.blackColor,
                                                  fontSize: 18,
                                                  letterSpacing: 0.8,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ]),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(
                                                kToolbarHeight + 124.0,
                                                kToolbarHeight - 16.0),
                                            backgroundColor: MyTheme.baseColor),
                                        onPressed: () {
                                          MyComponents.navPush(
                                              context,
                                              (p0) => ViewProfileScreen(
                                                  myprofile: myprofiledata[0],
                                                  profiledata:
                                                      receivedhistory[index],
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
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ]),
                                      ),
                                    ]),
                              ),
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
                                        ' ${MyComponents.formattedDateString(receivedhistory[index].sentAt, 'dd-MM-yyyy hh:mm:ss')}',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                              ),
                            ),
                            isLoadingButton
                                ? SizedBox(
                                    height: kToolbarHeight - 6.0,
                                    child: MyComponents.circularLoader(
                                        MyTheme.whiteColor, MyTheme.baseColor),
                                  )
                                : Container(
                                    width: MyComponents.widthSize(context),
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, bottom: 10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          elevatedAcceptButton(
                                              receivedhistory[index]),
                                          elevatedRejectButton(
                                              receivedhistory[index]),
                                        ]),
                                  ),
                          ]),
                        );
                      }),
        ]),
      ),
    );
  }

  getCircularImage(SearchProfileMessage receivedhistory) {
    if (SharedPrefs.getSubscribeId == '1') {
      if (receivedhistory.showInterestAcceptedProfile == '1' ||
          receivedhistory.visibleToAll == '1' ||
          receivedhistory.protectPhoto == '1') {
        if (receivedhistory.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image.network(receivedhistory.messageAvatar,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
              return MyComponents.assetImageHolder();
            }),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    } else {
      if (receivedhistory.protectPhoto == '1') {
        if (receivedhistory.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return InkWell(
            onTap: () {
              MyComponents.showDialogPreview(context,
                  MyComponents.kImageNetwork, receivedhistory.messageAvatar);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(receivedhistory.messageAvatar,
                  fit: BoxFit.cover,
                  width: kToolbarHeight + 64.0,
                  height: kToolbarHeight + 64.0,
                  errorBuilder: (context, error, stackTrace) {
                return MyComponents.assetImageHolder();
              }),
            ),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    }
  }

  elevatedAcceptButton(SearchProfileMessage receivedhistory) {
    if (receivedhistory.interestStatus == '1') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(kToolbarHeight + 74.0, kToolbarHeight - 16.0),
          disabledBackgroundColor: MyTheme.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: null,
        child: Text(
          'Accepted',
          style: GoogleFonts.inter(
              color: MyTheme.whiteColor,
              fontSize: 18,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyTheme.greenColor,
          fixedSize: const Size(kToolbarHeight + 74.0, kToolbarHeight - 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: receivedhistory.interestStatus == '0'
            ? null
            : () {
                if (SharedPrefs.getSubscribeId == '1') {
                  ApiService.sendFcmNotification(SharedPrefs.fcmToken,
                      'Your Interest has been successfully Sent, Now you can view their contact details.');
                } else {
                  ApiService.sendFcmNotification(
                      SharedPrefs.fcmToken,
                      'Your Interest has been successfully Sent, User Might contact you soon To view contact details of this user,'
                      ' Please get Premium Subscription.');
                }
                setState(() {
                  receivedhistory.interestStatus == '1';
                });
                ApiService.postintereststatus(
                        receivedhistory.profileInterestId, '1', '')
                    .then((value) {
                  setState(() {
                    isLoadingButton = false;
                    MyComponents.toast(value.message);
                  });
                  if (value.status && value.fcmKeyToken.isNotEmpty) {
                    ApiService.sendFcmNotification(
                        value.fcmKeyToken, value.commentMessage);
                  }
                });
              },
        child: Text(
          'Accept',
          style: GoogleFonts.inter(
              color: MyTheme.whiteColor,
              fontSize: 18,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  elevatedRejectButton(SearchProfileMessage receivedhistory) {
    if (receivedhistory.interestStatus == '0') {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: MyTheme.redColor,
          fixedSize: const Size(kToolbarHeight + 74.0, kToolbarHeight - 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: null,
        child: Text(
          'Not Accepted',
          style: GoogleFonts.inter(
              color: MyTheme.whiteColor,
              fontSize: 18,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w500),
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyTheme.redColor,
          fixedSize: const Size(kToolbarHeight + 74.0, kToolbarHeight - 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: receivedhistory.interestStatus == '1'
            ? null
            : () {
                showRejectedDialog(context, receivedhistory);
              },
        child: Text(
          'Decline',
          style: GoogleFonts.inter(
              color: MyTheme.whiteColor,
              fontSize: 18,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w500),
        ),
      );
    }
  }

  showRejectedDialog(
      BuildContext context, SearchProfileMessage receivedhistory) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(8.0),
              child: Scaffold(
                appBar: MyComponents.appbarWithTitle(
                    context,
                    '',
                    false,
                    [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedReason = '';
                            rejectReason.clear();
                            MyComponents.navPop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            backgroundColor: MyTheme.transparent),
                        child: Text(
                          'Close',
                          style: GoogleFonts.inter(
                              color: MyTheme.baseColor,
                              fontSize: 18,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                    MyTheme.whiteColor),
                body: ListView.builder(
                    itemCount: rejectReasonsList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        RadioListTile<String>(
                            value: rejectReasonsList[index],
                            groupValue: selectedReason,
                            activeColor: MyTheme.baseColor,
                            title: Text(
                              rejectReasonsList[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  letterSpacing: 0.8,
                                  color: MyTheme.blackColor),
                            ),
                            onChanged: (String? index) {
                              setState(() {
                                selectedReason = index!;
                                if (selectedReason != 'Other reasons') {
                                  rejectReason.clear();
                                }
                              });
                            }),
                        if (selectedReason == 'Other reasons' &&
                            index == rejectReasonsList.length - 1)
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 40.0, right: 40.0, bottom: 10.0),
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: MyTheme.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: TextField(
                              controller: rejectReason,
                              keyboardType: TextInputType.text,
                              maxLines: 6,
                              minLines: 3,
                              style: GoogleFonts.inter(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.8,
                                  decoration: TextDecoration.none),
                              cursorColor: MyTheme.blackColor,
                              decoration: const InputDecoration(
                                  hintText:
                                      'Tell us!, why you reject this person?',
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                          ),
                      ]);
                    }),
                bottomNavigationBar: isLoading2
                    ? SizedBox(
                        height: kToolbarHeight - 6.0,
                        child: MyComponents.circularLoader(
                            MyTheme.whiteColor, MyTheme.baseColor),
                      )
                    : Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight + 4.0,
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                height: kToolbarHeight - 6.0,
                                width: MyComponents.widthSize(context) / 2.8,
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedReason = '';
                                      rejectReason.clear();
                                      MyComponents.navPop(context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.whiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.baseColor,
                                        fontSize: 18,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 10.0),
                                height: kToolbarHeight - 6.0,
                                width: MyComponents.widthSize(context) / 2.8,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (rejectReason.text.isNotEmpty) {
                                      selectedReason = rejectReason.text;
                                    }
                                    setState(() {
                                      isLoading2 = true;
                                    });
                                    setState(() {
                                      receivedhistory.interestStatus == '0';
                                    });
                                    ApiService.postintereststatus(
                                            receivedhistory.profileInterestId,
                                            '0',
                                            selectedReason)
                                        .then((value) {
                                      setState(() {
                                        isLoading2 = false;
                                        MyComponents.toast(value.message);
                                      });
                                      if (value.status &&
                                          value.fcmKeyToken.isNotEmpty) {
                                        ApiService.sendFcmNotification(
                                            value.fcmKeyToken,
                                            value.commentMessage);
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.baseColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.whiteColor,
                                        fontSize: 18,
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ]),
                      ),
              ),
            );
          });
        });
  }
}
