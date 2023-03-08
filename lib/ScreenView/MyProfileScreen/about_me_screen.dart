import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/setps_info.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class AboutMeScreen extends StatefulWidget {
  const AboutMeScreen({Key? key}) : super(key: key);

  @override
  State<AboutMeScreen> createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen> {
  TextEditingController aboutmecontroller = TextEditingController();
  bool isLoadingButton = false, isPageLoading = true;

  @override
  void initState() {
    super.initState();
    getAboutMeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Profile Details', true, [], MyTheme.whiteColor),
      body: isPageLoading
          ? MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor)
          : Container(
              width: MyComponents.widthSize(context),
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'About MySelf ',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                            text: '*',
                            style: GoogleFonts.rubik(
                                color: MyTheme.redColor, fontSize: 18),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      width: MyComponents.widthSize(context),
                      height: kToolbarHeight + 104.0,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border:
                            Border.all(color: MyTheme.greyColor, width: 2.0),
                      ),
                      child: TextField(
                        controller: aboutmecontroller,
                        keyboardType: TextInputType.multiline,
                        maxLines: 100,
                        style: TextStyle(
                            color: MyTheme.blackColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            decoration: TextDecoration.none),
                        cursorColor: MyTheme.blackColor,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Say something about yourself! ',
                          helperStyle: TextStyle(
                              color: MyTheme.greyColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                    Container(
                      width: MyComponents.widthSize(context),
                      padding: const EdgeInsets.only(
                          top: 4.0, right: 8.0, bottom: 10.0),
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        child: Text(
                          'Minimum 15 Words',
                          style: GoogleFonts.inter(
                              color: MyTheme.baseColor, letterSpacing: 0.4),
                        ),
                      ),
                    ),
                    isLoadingButton
                        ? SizedBox(
                            height: kToolbarHeight - 6.0,
                            child: MyComponents.circularLoader(
                                MyTheme.whiteColor, MyTheme.baseColor),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        aboutmecontroller.clear();
                                        MyComponents.navPop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: MyTheme.whiteColor,
                                          fixedSize: Size(
                                              MyComponents.widthSize(context) /
                                                  2.8,
                                              kToolbarHeight - 6.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: FittedBox(
                                        child: Text(
                                          'Cancel',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(
                                              color: MyTheme.baseColor,
                                              fontSize: 18,
                                              letterSpacing: 0.4,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (aboutmecontroller.text.isEmpty) {
                                        MyComponents.toast(
                                            'Please say something about yourself');
                                      } else if (MyComponents
                                          .wordsCountValidator(
                                              aboutmecontroller.text, 15)) {
                                        MyComponents.toast(
                                            'Please enter minimum 15 words.');
                                      } else {
                                        setState(() {
                                          isLoadingButton = true;
                                        });
                                        Future<AboutMe> values =
                                            ApiService.postprofileaboutme(
                                                aboutmecontroller.text);
                                        values.then((value) {
                                          setState(() {
                                            isLoadingButton = false;
                                            MyComponents.toast(value.message);
                                            isPageLoading = true;
                                            getAboutMeData();
                                          });
                                        });
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyTheme.baseColor,
                                        fixedSize: Size(
                                            MyComponents.widthSize(context) /
                                                2.8,
                                            kToolbarHeight - 6.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
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
                                ]),
                          ),
                  ]),
            ),
    );
  }

  getAboutMeData() {
    ApiService.postprofilelist().then((value) {
      if (!mounted) return;
      setState(() {
        if (value.message[0].aboutMe != null &&
            value.message[0].aboutMe.toString().isNotEmpty) {
          aboutmecontroller.text = value.message[0].aboutMe;
        }
        isPageLoading = false;
      });
    });
  }
}
