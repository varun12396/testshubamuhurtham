import 'dart:async';
import 'dart:convert';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/horoscope_gallery_class.dart';
import 'package:myshubamuhurtham/ModelClass/interest_class.dart';
import 'package:myshubamuhurtham/ModelClass/payment_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/invoice_history_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/subscription_screen.dart';

class ViewProfileScreen extends StatefulWidget {
  final SearchProfileMessage profiledata;
  final MyProfileMessage myprofile;
  final String returnPage, screenType;
  const ViewProfileScreen(
      {Key? key,
      required this.profiledata,
      required this.myprofile,
      required this.returnPage,
      required this.screenType})
      : super(key: key);

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  bool isLoading = false,
      isLoading2 = false,
      isLoading3 = false,
      isLoading4 = false,
      isSaved = false,
      isMatchLoading = false,
      isGeneratedLoading = false,
      isImageLoading = false;
  String imageUrl = '',
      uploadHoroscope = '',
      generatedHoroscope = '',
      showInterestData = '',
      selectedReport = '',
      sendReport1 = '',
      sendReport2 = '';
  TextEditingController reportReason = TextEditingController();
  List<GalleryPhotoListMessage> galleryPhoto = [];
  List<String> getMotherData = [],
      getCastesData = [],
      getEducationData = [],
      getOccupationData = [],
      getCountriesData = [],
      getStatesData = [],
      getPlacesData = [],
      getwrkLocationData = [],
      getwrkAbLocationData = [],
      getMaritalData = [],
      profileReportList = [
        "Incorrect details",
        "Already found a match",
        "Other reasons"
      ];
  TextEditingController rejectReason = TextEditingController();
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
    if (widget.profiledata.isInterestSent == 1 &&
        widget.profiledata.interestStatus == '-1') {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        sentInterestDialogBox(context);
      });
    }
    if (!mounted) return;
    setState(() {
      isSaved = widget.profiledata.isSaved == 1 ? true : false;
      showInterestData = widget.profiledata.interestStatus;
      getGalleryPhotos(widget.profiledata.hasEncode);
      if (widget.profiledata.uploadedHoroscope.toString().isNotEmpty) {
        uploadHoroscope =
            '${MyComponents.horoBaseUrl}${widget.profiledata.hasEncode}/${widget.profiledata.uploadedHoroscope}';
      }
    });
  }

  Future<bool> onWillPop() {
    MyComponents.navPopWithResult(context, widget.myprofile.profileId);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MyComponents.appbarWithTitle(
            context, 'Detailed Profile', true, [], MyTheme.whiteColor),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              width: MyComponents.widthSize(context),
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
                  child: Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isImageLoading
                              ? getCircularImage(0, imageUrl)
                              : FadeShimmer.round(
                                  size: 100,
                                  baseColor: MyTheme.greyColor,
                                  highlightColor: MyTheme.whiteColor,
                                ),
                          Container(
                            width: MyComponents.widthSize(context) / 2.0,
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SharedPrefs.getSubscribeId == '1'
                                      ? SizedBox(
                                          width:
                                              MyComponents.widthSize(context) /
                                                  2.2,
                                          child: Text(
                                            widget.profiledata.userName,
                                            style: GoogleFonts.inter(
                                                fontSize: 20,
                                                color: MyTheme.blackColor,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.2,
                                    child: Text(
                                      widget.profiledata.profileNo,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.redColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  widget.profiledata.educationText.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          width:
                                              MyComponents.widthSize(context) /
                                                  2.2,
                                          child: Text(
                                            widget.profiledata.educationText,
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: MyTheme.blackColor,
                                                letterSpacing: 0.8),
                                          ),
                                        ),
                                  widget.profiledata.zodiac.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          width:
                                              MyComponents.widthSize(context) /
                                                  2.2,
                                          child: Text(
                                            getZodiac(0),
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: MyTheme.blackColor,
                                                letterSpacing: 0.8),
                                          ),
                                        ),
                                  widget.profiledata.star.isEmpty
                                      ? const SizedBox.shrink()
                                      : SizedBox(
                                          width:
                                              MyComponents.widthSize(context) /
                                                  2.2,
                                          child: Text(
                                            getStar(0),
                                            style: GoogleFonts.inter(
                                                fontSize: 18,
                                                color: MyTheme.blackColor,
                                                letterSpacing: 0.8),
                                          ),
                                        ),
                                ]),
                          ),
                        ]),
                    getProfession(0).isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 20.0),
                            child: Row(children: [
                              const Icon(Icons.work_rounded),
                              Text(
                                ' ${getProfession(0)}',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    letterSpacing: 0.8,
                                    color: MyTheme.blackColor),
                              ),
                            ]),
                          ),
                    widget.profiledata.districtName.isEmpty &&
                            widget.profiledata.stateCode.isEmpty &&
                            widget.profiledata.countryCode.toString().isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 20.0),
                            child: Row(children: [
                              const Icon(Icons.location_on_sharp),
                              Text(
                                getLocationData(
                                    widget.profiledata.districtName,
                                    widget.profiledata.stateCode,
                                    widget.profiledata.countryCode),
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    letterSpacing: 0.8,
                                    color: MyTheme.blackColor),
                              ),
                            ]),
                          ),
                  ]),
                ),
              ),
            ),
            widget.profiledata.aboutMe.isEmpty
                ? const SizedBox.shrink()
                : Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.only(
                        left: 10.0, top: 20.0, right: 10.0),
                    child: Column(children: [
                      SizedBox(
                        width: MyComponents.widthSize(context),
                        child: Text(
                          SharedPrefs.getSubscribeId == '1'
                              ? 'About ${widget.profiledata.userName}'
                              : 'About him',
                          style: GoogleFonts.rubik(
                              fontSize: 20,
                              color: MyTheme.baseColor,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0),
                        child: Text(
                          widget.profiledata.aboutMe,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.8),
                        ),
                      ),
                    ]),
                  ),
            Container(
              width: MyComponents.widthSize(context),
              margin: const EdgeInsets.only(
                  left: 10.0, top: 20.0, right: 10.0, bottom: 10.0),
              child: Column(children: [
                widget.profiledata.primaryHoroscope == 'G'
                    ? generateElevatedButton()
                    : uploadHoroscope.isEmpty
                        ? generateElevatedButton()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.transparent,
                              elevation: 0.0,
                              fixedSize: Size(MyComponents.widthSize(context),
                                  kToolbarHeight - 6.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                side: BorderSide(color: MyTheme.baseColor),
                              ),
                            ),
                            onPressed: () {
                              if (SharedPrefs.getLimitHoroscopeReached <= 0) {
                                getViewHoroDialog(context);
                              } else {
                                if (uploadHoroscope.isNotEmpty) {
                                  ApiService.addViewHoroscopeDetails(
                                          widget.profiledata.profileId,
                                          widget
                                              .myprofile.subscribedPremiumCount)
                                      .then((value) {});
                                  SharedPrefs.limitHoroscopeReached(
                                      SharedPrefs.getLimitHoroscopeReached - 1);
                                  if (uploadHoroscope.contains('.pdf')) {
                                    MyComponents.navPush(
                                        context,
                                        (p0) => PdfPreviewScreen(
                                            pdfDocFile: uploadHoroscope,
                                            titleHeader: 'Uploaded Horoscope',
                                            fileFormat: 'UrlData'));
                                  } else {
                                    MyComponents.showDialogPreview(
                                        context,
                                        MyComponents.kImageNetwork,
                                        uploadHoroscope);
                                  }
                                } else {
                                  MyComponents.toast(
                                      'There is no uploaded Horoscope.');
                                }
                              }
                            },
                            child: Text(
                              'View Uploaded Horoscope',
                              style: GoogleFonts.inter(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.8,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                const SizedBox(height: kToolbarHeight - 38.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.transparent,
                    elevation: 0.0,
                    fixedSize: Size(
                        MyComponents.widthSize(context), kToolbarHeight - 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      side: BorderSide(color: MyTheme.baseColor),
                    ),
                  ),
                  onPressed: () {
                    if (SharedPrefs.getLimitMatchReached <= 0) {
                      getMatchDialog(context);
                    } else {
                      showMatchLang(context);
                    }
                  },
                  child: Text(
                    'Match Horoscope',
                    style: GoogleFonts.inter(
                        color: MyTheme.blackColor,
                        fontSize: 18,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                showElevetedButton(),
                if (widget.profiledata.interestStatus == '1')
                  const SizedBox(height: kToolbarHeight - 38.0),
                if (widget.profiledata.interestStatus == '1')
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.transparent,
                      elevation: 0.0,
                      fixedSize: Size(MyComponents.widthSize(context),
                          kToolbarHeight - 6.0),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        side: BorderSide(color: MyTheme.baseColor),
                      ),
                    ),
                    onPressed: () {
                      showReportDialog(context);
                    },
                    child: Text(
                      'Report Profile',
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                const SizedBox(height: kToolbarHeight - 38.0),
              ]),
            ),
            SizedBox(
              width: MyComponents.widthSize(context),
              child: Card(
                child: Column(children: [
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        'Basic Information',
                        style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: MyTheme.baseColor,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                      childrenPadding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 10.0),
                      children: [
                        widget.profiledata.dateOfBirth.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Date of Birth',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${MyComponents.formattedDateString(widget.profiledata.dateOfBirth, 'dd-MM-yyyy')}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.age.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Age',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.age} Years',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getMarital(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Marital Status',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getMarital(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getPhysical(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Physical Status',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getPhysical(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getMotherTongue(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Mother Tongue',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getMotherTongue(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getReligion(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Religion',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getReligion(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getCasteData(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Caste',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getCasteData(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getSubcaste(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Sub Caste',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getSubcaste(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getJobType(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Job Type',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getJobType(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getProfession(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Profession',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getProfession(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.companyName.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Company',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.companyName}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getSalary(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Salary',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getSalary(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getWorkLocation(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Work Location',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getWorkLocation(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getAbroadLocation(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Specify the Location',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getAbroadLocation(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.educationText.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Higher Education',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.educationText}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getCountryData(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Nationality',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getCountryData(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getStateData(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Native State',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getStateData(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getDistrictData(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Native District',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getDistrictData(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getHeight(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Height',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getHeight(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.weight.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Weight',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.weight} Kg',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getFamilyValue(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Family Values',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getFamilyValue(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getFamilyType(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Family Type',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getFamilyType(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.fatherName.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Father Name',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.fatherName}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.motherName.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Mother Name',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.motherName}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.sibiling.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Sibilings',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.sibiling}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.mobileNumber.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Mobile Number',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      SharedPrefs.getSubscribeId == '1' &&
                                              showInterestData == '1'
                                          ? ': ${widget.profiledata.mobileNumber}'
                                          : ': xxxxxxxxxx',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.email.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Email',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      SharedPrefs.getSubscribeId == '1' &&
                                              showInterestData == '1'
                                          ? ': ${widget.profiledata.email}'
                                          : ': xxxxxxxxxxxxxxx',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                      ]),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        'Astrology Details',
                        style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: MyTheme.baseColor,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                      childrenPadding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 10.0),
                      children: [
                        widget.profiledata.birthPlace.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Birth Place',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.birthPlace}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.dateOfBirth.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Birth Date',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${MyComponents.formattedDateString(widget.profiledata.dateOfBirth, 'dd-MM-yyyy')}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.birthTime.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Birth Time',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.birthTime}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.gothram.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Gothram',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.gothram}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getZodiac(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Raasi/Zodiac',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getZodiac(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getStar(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Nakshathram/Star',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getStar(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.dosham.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Dosham',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.dosham}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                      ]),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        'Partner Preference',
                        style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: MyTheme.baseColor,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                      childrenPadding: const EdgeInsets.only(
                          left: 14.0, right: 14.0, bottom: 10.0),
                      children: [
                        widget.profiledata.partnerPreferencesFromAge.isEmpty &&
                                widget
                                    .profiledata.partnerPreferencesToAge.isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Age',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.partnerPreferencesFromAge} to ${widget.profiledata.partnerPreferencesToAge}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getHeight1(0).isEmpty && getHeight2(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Height',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getHeight1(0)} to ${getHeight2(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getPhysicalStatus(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Physical Status',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getPhysicalStatus(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getFamilyType2(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Family Type',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getFamilyType2(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getMotherTongueData(widget.profiledata
                                    .partnerPreferencesMotherTongues)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Mother Tongue ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getMotherTongueData(widget.profiledata.partnerPreferencesMotherTongues)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getAnnualIncome(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Annual Income',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getAnnualIncome(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getReligionData(0).isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Religion',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getReligionData(0)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getSubCaste(widget
                                    .profiledata.partnerPreferencesSubCastes)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Caste / Denomination ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getSubCaste(widget.profiledata.partnerPreferencesSubCastes)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getEducation(widget
                                    .profiledata.partnerPreferencesEducations)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Education ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getEducation(widget.profiledata.partnerPreferencesEducations)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getOccupations(widget
                                    .profiledata.partnerPreferencesOccupations)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Occupation ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getOccupations(widget.profiledata.partnerPreferencesOccupations)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getCountries(widget
                                    .profiledata.partnerPreferencesCountries)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Nationality ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getCountries(widget.profiledata.partnerPreferencesCountries)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getStates(widget.profiledata.partnerPreferencesStates)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Native State :',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getStates(widget.profiledata.partnerPreferencesStates)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getNativePlaces(widget
                                    .profiledata.partnerPreferencesNativePlaces)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Native Place ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getNativePlaces(widget.profiledata.partnerPreferencesNativePlaces)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getWorkPlaces(widget
                                    .profiledata.partnerPreferencesWrkLocations)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Work Location ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getWorkPlaces(widget.profiledata.partnerPreferencesWrkLocations)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getWorkAbPlaces(
                                    widget.profiledata
                                        .partnerPreferencesWrkLocations,
                                    widget.profiledata
                                        .partnerPreferencesWrkAbrLocations)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Work Abroad Location ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getWorkAbPlaces(widget.profiledata.partnerPreferencesWrkLocations, widget.profiledata.partnerPreferencesWrkAbrLocations)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        getMaritalStatus(widget.profiledata
                                    .partnerPreferencesMaritalStatuses)
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'Marital Status ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${getMaritalStatus(widget.profiledata.partnerPreferencesMaritalStatuses)}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                        widget.profiledata.partnerPreferencesAboutPartner
                                .isEmpty
                            ? const SizedBox.shrink()
                            : Container(
                                width: MyComponents.widthSize(context),
                                margin: const EdgeInsets.only(bottom: 8.0),
                                child: Row(children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.8,
                                    child: Text(
                                      'About My Partner',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      ': ${widget.profiledata.partnerPreferencesAboutPartner}',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.8),
                                    ),
                                  ),
                                ]),
                              ),
                      ]),
                  ExpansionTile(
                      initiallyExpanded: true,
                      title: Text(
                        'Images',
                        style: GoogleFonts.rubik(
                            fontSize: 20,
                            color: MyTheme.blackColor,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                      children: [
                        isImageLoading
                            ? galleryPhoto.isNotEmpty
                                ? GridView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        top: 10.0,
                                        right: 8.0,
                                        bottom: 40.0),
                                    shrinkWrap: true,
                                    itemCount: galleryPhoto.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: kToolbarHeight + 144.0,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                MyComponents.showDialogPreview(
                                                    context,
                                                    MyComponents.kImageNetwork,
                                                    galleryPhoto[index]
                                                        .photoUrl);
                                              },
                                              child: Container(
                                                width: kToolbarHeight + 104,
                                                height: kToolbarHeight + 104,
                                                decoration: BoxDecoration(
                                                  color: MyTheme.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        galleryPhoto[index]
                                                            .photoUrl),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]);
                                    },
                                  )
                                : const SizedBox.shrink()
                            : MyComponents.circularLoader(
                                MyTheme.transparent, MyTheme.baseColor),
                      ]),
                ]),
              ),
            ),
          ]),
        ),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: MyComponents.widthSize(context) / 2.4,
            height: kToolbarHeight - 16.0,
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  side: BorderSide(color: MyTheme.baseColor),
                ),
              ),
              onPressed: () {
                chatDialogBox(context);
              },
              child: FittedBox(
                child: Text(
                  'Chat Now',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context) / 2.4,
            height: kToolbarHeight - 16.0,
            margin: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyTheme.transparent,
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  side: BorderSide(color: MyTheme.baseColor),
                ),
              ),
              onPressed: () {
                setState(() {
                  isSaved = !isSaved;
                });
                try {
                  Future<AddRemoveFavorite> favorite =
                      ApiService.postaddremovefavorite(
                          widget.profiledata.profileId);
                  favorite.then((value) {});
                } catch (e) {
                  MyComponents.toast(MyComponents.kErrorMesage);
                }
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                isSaved
                    ? Icon(Icons.favorite_rounded, color: MyTheme.baseColor)
                    : Icon(Icons.favorite_border_rounded,
                        color: MyTheme.baseColor),
                Text(
                  isSaved ? ' Saved' : ' Save',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  getCircularImage(int index, String imageUrl) {
    setState(() {
      isImageLoading = true;
    });
    if (SharedPrefs.getSubscribeId == '1') {
      if (widget.profiledata.showInterestAcceptedProfile == '1' ||
          widget.profiledata.visibleToAll == '1' ||
          widget.profiledata.protectPhoto == '1') {
        if (widget.profiledata.messageAvatar.isEmpty) {
          return assetImageHolder();
        } else {
          return InkWell(
            onTap: () {
              MyComponents.showDialogPreview(
                  context, MyComponents.kImageNetwork, imageUrl);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
                  return assetImageHolder();
                },
              ),
            ),
          );
        }
      } else {
        return assetImageHolder();
      }
    } else {
      if (widget.profiledata.protectPhoto == '1') {
        if (widget.profiledata.messageAvatar.isEmpty) {
          return assetImageHolder();
        } else {
          return InkWell(
            onTap: () {
              MyComponents.showDialogPreview(
                  context, MyComponents.kImageNetwork, imageUrl);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
                  return assetImageHolder();
                },
              ),
            ),
          );
        }
      } else {
        return assetImageHolder();
      }
    }
  }

  assetImageHolder() {
    if (SharedPrefs.getGender == 'M') {
      return InkWell(
        onTap: () {
          MyComponents.showDialogPreview(context, MyComponents.kImageNetwork,
              MyComponents.femaleNetPicture);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Image.network(MyComponents.femaleNetPicture,
              fit: BoxFit.cover,
              width: kToolbarHeight + 64.0,
              height: kToolbarHeight + 64.0),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          MyComponents.showDialogPreview(
              context, MyComponents.kImageNetwork, MyComponents.maleNetPicture);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80.0),
          child: Image.network(MyComponents.maleNetPicture,
              fit: BoxFit.cover,
              width: kToolbarHeight + 64.0,
              height: kToolbarHeight + 64.0),
        ),
      );
    }
  }

  generateHoroscope(StateSetter setState4, String language) {
    setState4(() {
      isGeneratedLoading = true;
    });
    try {
      ApiService.postgeneratehoroscope(widget.profiledata.userId, language)
          .then((value) {
        ApiService.addViewHoroscopeDetails(widget.profiledata.profileId,
                widget.myprofile.subscribedPremiumCount)
            .then((value) {});
        setState4(() {
          isGeneratedLoading = false;
          MyComponents.navPop(context);
          SharedPrefs.limitHoroscopeReached(
              SharedPrefs.getLimitHoroscopeReached - 1);
          MyComponents.launchInBrowser(value.message);
        });
      });
    } catch (e) {
      setState4(() {
        isGeneratedLoading = false;
        MyComponents.navPop(context);
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  horoscopeMatchList(StateSetter setState2, String language) {
    setState2(() {
      isMatchLoading = true;
    });
    try {
      Future<HoroscopeMatchList> values = ApiService.posthoroscopematchlist(
        language,
        widget.myprofile.userId,
        widget.myprofile.userName,
        widget.myprofile.dateOfBirth,
        widget.myprofile.birthTime,
        widget.myprofile.birthPlace,
        widget.profiledata.userId,
        widget.profiledata.userName,
        widget.profiledata.dateOfBirth,
        widget.profiledata.birthTime,
        widget.profiledata.birthPlace,
      );
      values.then((value) {
        setState2(() {
          isMatchLoading = false;
          MyComponents.navPop(context);
          ApiService.addMatchHoroscopeDetails(widget.profiledata.profileId,
                  widget.myprofile.subscribedPremiumCount)
              .then((value) {});
          String matchUrl = value.message.replaceAll('Location: ', '');
          SharedPrefs.limitMatchReached(SharedPrefs.getLimitMatchReached - 1);
          MyComponents.launchInBrowser(matchUrl);
        });
      });
    } catch (e) {
      setState2(() {
        isMatchLoading = false;
        MyComponents.navPop(context);
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  sendInterestRequest(StateSetter setState3, String interestData) {
    setState3(() {
      isLoading = true;
    });
    try {
      ApiService.postinterestsend(widget.profiledata.profileId, interestData,
              widget.myprofile.subscribedPremiumCount)
          .then((value) {
        setState3(() {
          isLoading = false;
        });
        MyComponents.navPop(context);
        if (value.status && value.fcmKeyToken.isNotEmpty) {
          ApiService.sendFcmNotification(
              value.fcmKeyToken, value.commentMessage);
        }
        if (value.status) {
          setState(() {
            showInterestData = '-1';
          });
          sentInterestDialogBox(context);
        } else {
          MyComponents.toast(value.message);
        }
      });
    } catch (e) {
      setState3(() {
        isLoading = false;
        MyComponents.navPop(context);
      });
      MyComponents.toast(MyComponents.kErrorMesage);
    }
  }

  String getZodiac(int index) {
    String zodiac = '';
    for (var element in HardCodeData.zodiaclist) {
      if (element.id == widget.profiledata.zodiac) {
        zodiac = element.textName;
      }
    }
    return zodiac;
  }

  String getStar(int index) {
    String star = '';
    for (var element in HardCodeData.startypedata) {
      if (element.id == widget.profiledata.star) {
        star = element.textName;
      }
    }
    return star;
  }

  String getProfession(int index) {
    String occupationName = '';
    for (var element in MyComponents.occupationData) {
      if (element.occupationId == widget.profiledata.professionId) {
        occupationName = element.occupationName;
      }
    }
    return occupationName;
  }

  String getHeight(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.heightData.length; i++) {
      if (MyComponents.heightData[i].id == widget.profiledata.height) {
        data = MyComponents.heightData[i].name;
      }
    }
    return data;
  }

  String getMotherTongue(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.mothertongueData.length; i++) {
      if (MyComponents.mothertongueData[i].id ==
          widget.profiledata.motherTongueId) {
        data = MyComponents.mothertongueData[i].name;
      }
    }
    return data;
  }

  String getPhysical(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
      if (HardCodeData.physicalStatusData[i].id ==
          widget.profiledata.physicalStatus) {
        data = HardCodeData.physicalStatusData[i].textName;
      }
    }
    return data;
  }

  String getPhysicalStatus(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
      if (HardCodeData.physicalStatusData[i].id ==
          widget.profiledata.partnerPreferencesPhysicalStatus) {
        data = HardCodeData.physicalStatusData[i].textName;
      }
    }
    return data;
  }

  String getReligion(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.religionData.length; i++) {
      if (MyComponents.religionData[i].id == widget.profiledata.religionId) {
        data = MyComponents.religionData[i].name;
      }
    }
    return data;
  }

  String getCasteData(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.casteData.length; i++) {
      if (MyComponents.casteData[i].casteId == widget.profiledata.casteId) {
        data = MyComponents.casteData[i].casteName;
      }
    }
    return data;
  }

  String getSubcaste(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.subcasteData.length; i++) {
      if (MyComponents.subcasteData[i].subCasteId ==
          widget.profiledata.subCasteId) {
        data = MyComponents.subcasteData[i].subCasteName;
      }
    }
    return data;
  }

  String getMarital(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.maritalData.length; i++) {
      if (HardCodeData.maritalData[i].id == widget.profiledata.maritalStatus) {
        data = HardCodeData.maritalData[i].textName;
      }
    }
    return data;
  }

  String getSalary(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.salaryData.length; i++) {
      if (HardCodeData.salaryData[i].id == widget.profiledata.salary) {
        data = HardCodeData.salaryData[i].textName;
      }
    }
    return data;
  }

  String getJobType(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.jobTypeList.length; i++) {
      if (HardCodeData.jobTypeList[i].id == widget.profiledata.jobTitle) {
        data = HardCodeData.jobTypeList[i].textName;
      }
    }
    return data;
  }

  String getCountryData(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.countryData.length; i++) {
      if (widget.profiledata.countryId == '85') {
        data = 'India';
      } else if (MyComponents.countryData[i].countryId ==
          widget.profiledata.countryId) {
        data = MyComponents.countryData[i].countryText;
      }
    }
    return data;
  }

  String getStateData(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.stateData.length; i++) {
      if (MyComponents.stateData[i].stateId == widget.profiledata.stateId) {
        data = MyComponents.stateData[i].stateName;
      }
    }
    return data;
  }

  String getDistrictData(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.locationData.length; i++) {
      if (MyComponents.locationData[i].districtId ==
          widget.profiledata.districtId) {
        data =
            '${MyComponents.locationData[i].districtName},${getStateData(0)}';
      }
    }
    return data;
  }

  String getWorkLocation(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.stateData.length; i++) {
      if (widget.profiledata.countryId == '999') {
        data = 'Working Abroad';
      } else if (MyComponents.stateData[i].stateId ==
          widget.profiledata.wrkLocationId) {
        data = MyComponents.stateData[i].stateName;
      }
    }
    return data;
  }

  String getAbroadLocation(int index) {
    String data = '';
    if (widget.profiledata.wrkLocationId == '999') {
      for (var i = 0; i < MyComponents.countryData.length; i++) {
        if (MyComponents.countryData[i].countryId ==
            widget.profiledata.wrkAbrLocationId) {
          data = MyComponents.countryData[i].countryText;
        }
      }
    } else {
      if (widget.profiledata.wrkLocationId.isNotEmpty) {
        for (var i = 0; i < MyComponents.locationData.length; i++) {
          if (MyComponents.locationData[i].districtId ==
              widget.profiledata.wrkAbrLocationId) {
            data =
                '${MyComponents.locationData[i].districtName},${getWorkLocation(0)}';
          }
        }
      }
    }
    return data;
  }

  String getFamilyValue(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.familyValueData.length; i++) {
      if (HardCodeData.familyValueData[i].id ==
          widget.profiledata.familyValues) {
        data = HardCodeData.familyValueData[i].textName;
      }
    }
    return data;
  }

  String getFamilyType(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
      if (HardCodeData.familyTypeData[i].id == widget.profiledata.familyType) {
        data = HardCodeData.familyTypeData[i].textName;
      }
    }
    return data;
  }

  String getHeight1(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.heightData.length; i++) {
      if (MyComponents.heightData[i].id ==
          widget.profiledata.partnerPreferencesFromHeight) {
        data = MyComponents.heightData[i].name;
      }
    }
    return data;
  }

  String getHeight2(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.heightData.length; i++) {
      if (MyComponents.heightData[i].id ==
          widget.profiledata.partnerPreferencesToHeight) {
        data = MyComponents.heightData[i].name;
      }
    }
    return data;
  }

  String getFamilyType2(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
      if (HardCodeData.familyTypeData[i].id ==
          widget.profiledata.partnerPreferencesFamilyType) {
        data = HardCodeData.familyTypeData[i].textName;
      }
    }
    return data;
  }

  String getAnnualIncome(int index) {
    String data = '';
    for (var i = 0; i < HardCodeData.annualincomedata.length; i++) {
      if (HardCodeData.annualincomedata[i].id ==
          widget.profiledata.partnerPreferencesAnnualIncome) {
        data = HardCodeData.annualincomedata[i].textName;
      }
    }
    return data;
  }

  String getReligionData(int index) {
    String data = '';
    for (var i = 0; i < MyComponents.religionData.length; i++) {
      if (MyComponents.religionData[i].id ==
          widget.profiledata.partnerPreferencesReligionId) {
        data = MyComponents.religionData[i].name;
      }
    }
    return data;
  }

  String getMotherTongueData(String partnerPreferencesMotherTongues) {
    getMotherData.clear();
    if (partnerPreferencesMotherTongues != '[]' &&
        partnerPreferencesMotherTongues != 'null' &&
        partnerPreferencesMotherTongues.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesMotherTongues)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '11') {
          getMotherData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.mothertongueData) {
              if (element1 == element2.id) {
                getMotherData.add(element2.name);
              }
            }
          }
        }
      }
    }
    return getMotherData.toList().join(', ').toString();
  }

  String getSubCaste(String partnerPreferencesSubCastes) {
    getCastesData.clear();
    if (partnerPreferencesSubCastes != '[]' &&
        partnerPreferencesSubCastes != 'null' &&
        partnerPreferencesSubCastes.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesSubCastes)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '125') {
          getCastesData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.subcasteData) {
              if (element1 == element2.subCasteId) {
                getCastesData.add(element2.subCasteName);
              }
            }
          }
        }
      }
    }
    return getCastesData.toList().join(', ').toString();
  }

  String getEducation(String partnerPreferencesEducations) {
    getEducationData.clear();
    if (partnerPreferencesEducations != '[]' &&
        partnerPreferencesEducations != 'null' &&
        partnerPreferencesEducations.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesEducations)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '187') {
          getEducationData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.educationData) {
              if (element1 == element2.id) {
                getEducationData.add(element2.name);
              }
            }
          }
        }
      }
    }
    return getEducationData.toList().join(', ').toString();
  }

  String getOccupations(String partnerPreferencesOccupations) {
    getOccupationData.clear();
    if (partnerPreferencesOccupations != '[]' &&
        partnerPreferencesOccupations != 'null' &&
        partnerPreferencesOccupations.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesOccupations)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '130') {
          getOccupationData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.occupationData) {
              if (element1 == element2.occupationId) {
                getOccupationData.add(element2.occupationName);
              }
            }
          }
        }
      }
    }
    return getOccupationData.toList().join(', ').toString();
  }

  String getCountries(String partnerPreferencesCountries) {
    getCountriesData.clear();
    if (partnerPreferencesCountries != '[]' &&
        partnerPreferencesCountries != 'null' &&
        partnerPreferencesCountries.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesCountries)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '209') {
          getCountriesData.add('Any');
        } else if (dataList[0] == '85') {
          getCountriesData.add('India');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.educationData) {
              if (element1 == element2.id) {
                getCountriesData.add(element2.name);
              }
            }
          }
        }
      }
    }
    return getCountriesData.toList().join(', ').toString();
  }

  String getStates(String partnerPreferencesState) {
    getStatesData.clear();
    if (partnerPreferencesState != '[]' &&
        partnerPreferencesState != 'null' &&
        partnerPreferencesState.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesState)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '39') {
          getStatesData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.stateData) {
              if (element1 == element2.stateId) {
                getStatesData.add(element2.stateName);
              }
            }
          }
        }
      }
    }
    return getStatesData.toList().join(', ').toString();
  }

  String getNativePlaces(String partnerPreferencesNativePlaces) {
    getPlacesData.clear();
    if (partnerPreferencesNativePlaces != '[]' &&
        partnerPreferencesNativePlaces != 'null' &&
        partnerPreferencesNativePlaces.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesNativePlaces)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '736') {
          getPlacesData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.locationData) {
              if (element1 == element2.districtId) {
                for (var element3 in MyComponents.stateData) {
                  if (element2.stateId == element3.stateId) {
                    getPlacesData
                        .add('${element2.districtName},${element3.stateName}');
                  }
                }
              }
            }
          }
        }
      }
    }
    return getPlacesData.toList().join(', ').toString();
  }

  String getWorkPlaces(String partnerPreferencesWorkPlaces) {
    getwrkLocationData.clear();
    if (partnerPreferencesWorkPlaces != '[]' &&
        partnerPreferencesWorkPlaces != 'null' &&
        partnerPreferencesWorkPlaces.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesWorkPlaces)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '50') {
          getwrkLocationData.add('Any');
        } else if (dataList[0] == '999') {
          getwrkLocationData.add('Working Abroad');
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.stateData) {
              if (element1 == element2.stateId) {
                getwrkLocationData.add(element2.stateName);
              }
            }
          }
        }
      }
    }
    return getwrkLocationData.toList().join(', ').toString();
  }

  String getWorkAbPlaces(String partnerPreferencesWorkPlaces,
      String partnerPreferencesWorkAbPlaces) {
    getwrkAbLocationData.clear();
    if (partnerPreferencesWorkAbPlaces != '[]' &&
        partnerPreferencesWorkAbPlaces != 'null' &&
        partnerPreferencesWorkAbPlaces.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesWorkPlaces)
          .map((e) => e.toString())
          .toList());
      List<String> dataList1 = List<String>.from(json
          .decode(partnerPreferencesWorkAbPlaces)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty && dataList1.isNotEmpty) {
        if (dataList[0] == '999' && dataList1[0] == '210') {
          getwrkAbLocationData.add('Any');
        } else if (dataList[0] == '999' && dataList1[0] != '210') {
          for (var element1 in dataList1) {
            for (var element2 in MyComponents.countryData) {
              if (element1 == element2.countryId) {
                getwrkAbLocationData.add(element2.countryText);
              }
            }
          }
        } else {
          for (var element1 in dataList1) {
            for (var element2 in MyComponents.locationData) {
              if (element1 == element2.districtId) {
                for (var element3 in MyComponents.stateData) {
                  if (element2.stateId == element3.stateId) {
                    getwrkAbLocationData
                        .add('${element2.districtName},${element3.stateName}');
                  }
                }
              }
            }
          }
        }
      }
    }
    return getwrkAbLocationData.toList().join(', ').toString();
  }

  String getMaritalStatus(String partnerPreferencesMartialStatus) {
    getMaritalData.clear();
    if (partnerPreferencesMartialStatus != '[]' &&
        partnerPreferencesMartialStatus != 'null' &&
        partnerPreferencesMartialStatus.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesMartialStatus)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == 'A') {
          getMaritalData.add('Any');
        } else {
          for (var element1 in dataList) {
            for (var element2 in HardCodeData.maritalData) {
              if (element1.contains(element2.id)) {
                getMaritalData.add(element2.textName);
              }
            }
          }
        }
      }
    }
    return getMaritalData.toList().join(', ').toString();
  }

  showRejectedDialog(BuildContext context, SearchProfileMessage profiledata) {
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
                bottomNavigationBar: isLoading4
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
                                      isLoading4 = true;
                                    });
                                    ApiService.postintereststatus(
                                            profiledata.profileInterestId,
                                            '0',
                                            selectedReason)
                                        .then((value) {
                                      setState(() {
                                        isLoading4 = false;
                                        MyComponents.toast(value.message);
                                      });
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

  showElevetedButton() {
    if (showInterestData == '1') {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight - 38.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: MyTheme.greenColor,
              fixedSize:
                  Size(MyComponents.widthSize(context), kToolbarHeight - 6.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            onPressed: null,
            child: Text(
              'Interest Accepted',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    } else if (showInterestData == '0') {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight - 38.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: MyTheme.baseColor,
              fixedSize:
                  Size(MyComponents.widthSize(context), kToolbarHeight - 6.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            onPressed: null,
            child: Text(
              'Interest Not Accepted',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    } else if (showInterestData == '-1') {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight - 38.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              disabledBackgroundColor: MyTheme.yellowColor,
              fixedSize:
                  Size(MyComponents.widthSize(context), kToolbarHeight - 6.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            onPressed: null,
            child: Text(
              'Pending Interest',
              style: GoogleFonts.inter(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    } else if (showInterestData.isEmpty &&
        widget.profiledata.isOppInterestSent == 0) {
      return Column(
        children: [
          const SizedBox(height: kToolbarHeight - 38.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.transparent,
              elevation: 0.0,
              fixedSize:
                  Size(MyComponents.widthSize(context), kToolbarHeight - 6.0),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: MyTheme.baseColor),
              ),
            ),
            onPressed: () {
              if (SharedPrefs.getSubscribeId == '1') {
                if (SharedPrefs.getLimitInterestReached <= 0) {
                  showDialogSent(context);
                } else {
                  showDialogOption(context);
                }
              } else {
                showDialogSentInterest(context);
              }
            },
            child: Text(
              'Sent Interest',
              style: GoogleFonts.inter(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  showGeneratedLang(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState4) {
            return Dialog(
              child: Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight + 144.0,
                margin: const EdgeInsets.all(10.0),
                child: isGeneratedLoading
                    ? MyComponents.delayLoader(context, 'Loading...')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Select Language',
                                style: GoogleFonts.rubik(
                                    fontSize: 18.0,
                                    letterSpacing: 0.8,
                                    color: MyTheme.blackColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                generateHoroscope(setState4, 'ENG');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                    kToolbarHeight * 2, kToolbarHeight - 16.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'English',
                                  style: GoogleFonts.inter(
                                      fontSize: 18.0,
                                      letterSpacing: 0.8,
                                      color: MyTheme.whiteColor),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                generateHoroscope(setState4, 'TAM');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                    kToolbarHeight * 2, kToolbarHeight - 16.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Tamil',
                                  style: GoogleFonts.inter(
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                      color: MyTheme.whiteColor),
                                ),
                              ),
                            ),
                          ]),
              ),
            );
          });
        });
  }

  showMatchLang(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState2) {
            return Dialog(
              child: Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight + 204.0,
                margin: const EdgeInsets.all(10.0),
                child: isMatchLoading
                    ? MyComponents.delayLoader(context, 'Loading...')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Select Language',
                                style: GoogleFonts.rubik(
                                    fontSize: 18.0,
                                    letterSpacing: 0.8,
                                    color: MyTheme.blackColor),
                              ),
                            ),
                            SizedBox(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight,
                              child: Text(
                                'Horoscope Matches Generated are based on Computer horoscopes only.',
                                maxLines: 2,
                                style: GoogleFonts.breeSerif(
                                    fontSize: 18.0,
                                    letterSpacing: 0.8,
                                    color: MyTheme.blackColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                horoscopeMatchList(setState2, 'ENG');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                    kToolbarHeight * 2, kToolbarHeight - 16.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'English',
                                  style: GoogleFonts.inter(
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                      color: MyTheme.whiteColor),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                horoscopeMatchList(setState2, 'TAM');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                    kToolbarHeight * 2, kToolbarHeight - 16.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Tamil',
                                  style: GoogleFonts.inter(
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                      color: MyTheme.whiteColor),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                horoscopeMatchList(setState2, 'KAN');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(
                                    kToolbarHeight * 2, kToolbarHeight - 16.0),
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Kanada',
                                  style: GoogleFonts.inter(
                                      letterSpacing: 0.8,
                                      fontSize: 18.0,
                                      color: MyTheme.whiteColor),
                                ),
                              ),
                            ),
                          ]),
              ),
            );
          });
        });
  }

  getMatchDialog(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 344.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.cancelPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Horoscope match checking limit crossed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    letterSpacing: 0.8,
                    color: MyTheme.blackColor,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  getViewHoroDialog(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 344.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.cancelPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                'View horoscope limit crossed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    color: MyTheme.blackColor,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  showReportDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(8.0),
              child: Scaffold(
                appBar: MyComponents.appbarWithTitle(
                    context,
                    'Report Profile',
                    false,
                    [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selectedReport = '';
                            sendReport1 = '';
                            sendReport2 = '';
                            reportReason.clear();
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
                    itemCount: profileReportList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        RadioListTile<String>(
                            value: profileReportList[index],
                            groupValue: selectedReport,
                            activeColor: MyTheme.baseColor,
                            title: Text(
                              profileReportList[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  letterSpacing: 0.8,
                                  color: MyTheme.blackColor),
                            ),
                            onChanged: (String? index) {
                              setState(() {
                                selectedReport = index!;
                                if (selectedReport == profileReportList[0]) {
                                  sendReport1 = selectedReport;
                                  sendReport2 = '';
                                  reportReason.clear();
                                } else if (selectedReport ==
                                    profileReportList[1]) {
                                  sendReport1 = '';
                                  sendReport2 = selectedReport;
                                  reportReason.clear();
                                } else {
                                  sendReport1 = '';
                                  sendReport2 = '';
                                }
                              });
                            }),
                        if (selectedReport == 'Other reasons' &&
                            index == profileReportList.length - 1)
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
                              controller: reportReason,
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
                                      'Tell us!, why you report this person?',
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
                                      selectedReport = '';
                                      sendReport1 = '';
                                      sendReport2 = '';
                                      reportReason.clear();
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
                                    setState(() {
                                      isLoading2 = true;
                                    });
                                    try {
                                      Future<ReportPaymentData> values =
                                          ApiService.reportDetails(
                                              widget.myprofile.profileNo,
                                              widget.profiledata.profileNo,
                                              sendReport1,
                                              sendReport2,
                                              reportReason.text);
                                      values.then((value) {
                                        setState(() {
                                          isLoading2 = false;
                                          selectedReport = '';
                                          sendReport1 = '';
                                          sendReport2 = '';
                                          reportReason.clear();
                                          MyComponents.toast(value.message);
                                        });
                                        MyComponents.navPop(context);
                                      }).onError((error, stackTrace) {
                                        setState(() {
                                          isLoading2 = false;
                                          selectedReport = '';
                                          sendReport1 = '';
                                          sendReport2 = '';
                                          reportReason.clear();
                                        });
                                        MyComponents.toast(
                                            MyComponents.kErrorMesage);
                                        MyComponents.navPop(context);
                                      });
                                    } catch (e) {
                                      setState(() {
                                        isLoading2 = false;
                                        selectedReport = '';
                                        sendReport1 = '';
                                        sendReport2 = '';
                                        reportReason.clear();
                                      });
                                      MyComponents.navPop(context);
                                      MyComponents.toast(
                                          MyComponents.kErrorMesage);
                                    }
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

  showDialogOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: StatefulBuilder(builder: (context, setState3) {
              return Container(
                width: MyComponents.widthSize(context),
                height: MyComponents.heightSize(context) / 4.8,
                padding: const EdgeInsets.all(20.0),
                child: isLoading
                    ? MyComponents.delayLoader(context, 'Loading...')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            ElevatedButton(
                              onPressed: () {
                                sendInterestRequest(setState3, '1');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.image_rounded),
                                    Text(
                                      ' Send with photo',
                                      style: GoogleFonts.inter(
                                          color: MyTheme.whiteColor,
                                          fontSize: 18,
                                          letterSpacing: 0.8),
                                    ),
                                  ]),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                sendInterestRequest(setState3, '2');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                        Icons.image_not_supported_rounded),
                                    Text(
                                      ' Send without photo',
                                      style: GoogleFonts.inter(
                                          color: MyTheme.whiteColor,
                                          fontSize: 18,
                                          letterSpacing: 0.8),
                                    ),
                                  ]),
                            ),
                          ]),
              );
            }),
          );
        });
  }

  chatDialogBox(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 344.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.warningPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Currently this feature is not available',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  showDialogSent(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 344.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.cancelPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Sent interest limit crossed.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  showDialogSentInterest(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        Text(
          MyComponents.appName,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              color: MyTheme.baseColor,
              fontSize: 20,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500),
        ),
        Container(
          width: MyComponents.widthSize(context),
          margin: const EdgeInsets.only(
              left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
          child: Text(
            'To Send interest. Please Get Premium Subscription.',
            style: GoogleFonts.inter(
                color: MyTheme.blackColor,
                fontSize: 18,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w400),
          ),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
              MyComponents.navPush(context, (p0) => const SubscriptionScreen());
            },
            child: Text(
              'Get Subscription',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  sentInterestDialogBox(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 344.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.sucessPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                'Your interest has been successfully sent.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
              MyComponents.navPushAndRemoveUntil(
                  context,
                  (p0) => const MainScreen(isVisible: false, pageIndex: 1),
                  false);
            },
            child: Text(
              'Back to Search',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                  color: MyTheme.whiteColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  getGalleryPhotos(String hasEncode) {
    galleryPhoto.clear();
    ApiService.getgalleryphotolist().then((value) {
      for (var i = 0; i < value.message.length; i++) {
        if (value.message[i].deleteStatus != '1') {
          if (SharedPrefs.getSubscribeId == '1') {
            galleryPhoto.add(
              GalleryPhotoListMessage(
                  profilePhotoId: value.message[i].profilePhotoId,
                  profileId: value.message[i].profileId,
                  photoUrl:
                      '${MyComponents.imageBaseUrl}$hasEncode/${value.message[i].photoUrl}',
                  isPrimary: value.message[i].isPrimary,
                  uploadedAt: value.message[i].uploadedAt,
                  verifiedAt: value.message[i].verifiedAt,
                  isSuspended: value.message[i].isSuspended,
                  galleryLine: value.message[i].galleryLine,
                  deleteStatus: value.message[i].deleteStatus),
            );
          }

          if (value.message[i].isPrimary == '1') {
            if (!mounted) return;
            setState(() {
              if (widget.profiledata.avatar.isNotEmpty) {
                imageUrl =
                    '${MyComponents.imageBaseUrl}$hasEncode/${widget.profiledata.messageAvatar}';
              }
            });
          }
        }
      }
      if (!mounted) return;
      setState(() {
        isImageLoading = true;
      });
    });
  }

  generateElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.transparent,
        elevation: 0.0,
        fixedSize: Size(MyComponents.widthSize(context), kToolbarHeight - 6.0),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          side: BorderSide(color: MyTheme.baseColor),
        ),
      ),
      onPressed: () {
        if (SharedPrefs.getLimitHoroscopeReached <= 0) {
          getViewHoroDialog(context);
        } else {
          showGeneratedLang(context);
        }
      },
      child: FittedBox(
        child: Text(
          'View Generated Horoscope',
          style: GoogleFonts.inter(
              color: MyTheme.blackColor,
              fontSize: 18,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  String getLocationData(
      String districtName, String stateCode, String countryCode) {
    String data = '';
    if (districtName.isNotEmpty &&
        stateCode.isNotEmpty &&
        countryCode.isNotEmpty) {
      data = '$districtName, $stateCode, $countryCode';
    } else if (districtName.isNotEmpty && stateCode.isNotEmpty) {
      data = '$districtName, $stateCode';
    } else if (districtName.isNotEmpty && countryCode.isNotEmpty) {
      data = '$districtName, $countryCode';
    } else {
      data = districtName;
    }
    return data;
  }
}
