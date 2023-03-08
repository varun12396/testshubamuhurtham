import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/view_details_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/subscription_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamController<List<SearchProfileMessage>> searchControllers =
      StreamController();
  List<MyProfileMessage> myprofiledata = [];
  List<SearchProfileMessage> searchProfileData = [];
  TextEditingController userProfileNo = TextEditingController();
  ScrollController scrollController = ScrollController();
  int currentLength = 0;
  bool isIncrementLoading = true,
      isChettiyar = false,
      isDistrictDataVisible = true,
      isAbroadLocationVisibleData = true;
  List<String> countryData = [],
      stateData = [],
      districtData = [],
      workLocationData = [],
      abroadLocationData = [],
      heighData = [],
      mothertongueData = [],
      religionData = [],
      casteData = [],
      subCateData = [],
      educationData = [],
      professionData = [],
      salaryData = [],
      martialStatusData = [],
      familyValueData = [],
      familyTypeData = [],
      physicalStatusData = [],
      annualIncomeData = [],
      zodicData = [],
      starTypeData = [],
      galleryData = [],
      jobTypeData = [],
      horoscopeSettingData = [],
      educationDataId = [],
      subCateDataId = [],
      martialStatusDataId = [],
      selectedEducationData = [],
      selectedSubCateData = [],
      selectedMartialStatusData = [];
  String selectedCountryData = 'Select Nationality',
      selectedStateData = 'Select State',
      selectedDistrictData = 'Select District,State',
      selectedWorkLocationData = 'Select Work Location',
      selectedAbroadLocationData = 'Select Abroad Location',
      selectedHeighFromData = 'From',
      selectedHeighToData = 'To',
      selectedMothertongueData = 'Select Mother Tongue',
      selectedReligionData = 'Select Religion',
      selectedCasteData = 'Select Caste',
      selectedProfessionData = 'Select Profession',
      selectedSalaryData = 'Select Salary',
      selectedFamilyValueData = 'Select FamilyValue',
      selectedFamilyTypeData = 'Select FamilyType',
      selectedPhysicalStatusData = 'Select Physical Status',
      selectedAnnualIncomeData = 'Select Annual Income',
      selectedZodicData = 'Select Zodic',
      selectedDhosamData = 'Select Dhosam',
      selectedStarTypeData = 'Select Star Type',
      selectedGalleryData = 'Select Photos',
      selectedHoroscopeSettingData = 'Select Horoscope',
      selectedFromAgeData = 'From',
      selectedToAgeData = 'To',
      selectedJobTypeData = 'Select JobType',
      selectedProfile = 'Recent Upload Profile',
      networkImage = '',
      sendSortData = '',
      sendIsCaste = '',
      sendJobTypeData = '',
      sendFromAgeData = '',
      sendToAgeData = '',
      sendCountryData = '',
      sendStateData = '',
      sendDistrictData = '',
      sendWorkLocationData = '',
      sendAbroadLocationData = '',
      sendHeighFromData = '',
      sendHeighToData = '',
      sendMothertongueData = '',
      sendReligionData = '',
      sendCasteData = '',
      sendProfessionData = '',
      sendSalaryData = '',
      sendFamilyValueData = '',
      sendFamilyTypeData = '',
      sendPhysicalStatusData = '',
      sendAnnualIncomeData = '',
      sendZodicData = '',
      sendDhosamData = '',
      sendStarTypeData = '',
      sendGalleryData = '',
      sendEducationDataId = '',
      sendSubCateDataId = '',
      sendMartialStatusDataId = '',
      sendHoroscopeSettingData = '';

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isIncrementLoading) {
          setState(() {
            isIncrementLoading = true;
          });
          onPullToRefreshData(currentLength);
        }
      }
    });
    onPullToRefreshData(currentLength);
  }

  @override
  void dispose() {
    searchControllers.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onPullToRefresh,
        child: StreamBuilder<List<SearchProfileMessage>>(
            initialData: searchProfileData,
            stream: searchControllers.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return emptyDataToShow();
              }
              if (searchProfileData.isEmpty) {
                return MyComponents.fadeShimmerList(true);
              }
              return snapshot.data!.isEmpty
                  ? emptyDataToShow()
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
                            decoration: BoxDecoration(
                                color: MyTheme.backgroundBox,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor)),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      getCircularImage(snapshot.data![index]),
                                      const SizedBox(
                                          width: kToolbarHeight - 46.0),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SharedPrefs.getSubscribeId == '1'
                                                ? SizedBox(
                                                    width:
                                                        MyComponents.widthSize(
                                                                context) /
                                                            2.0,
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .userName,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        color:
                                                            MyTheme.blackColor,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                            SizedBox(
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.0,
                                              child: Text(
                                                snapshot.data![index].profileNo,
                                                style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  color: MyTheme.baseColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.0,
                                              child: snapshot.data![index]
                                                      .educationText.isEmpty
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      snapshot.data![index]
                                                          .educationText,
                                                      style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        color:
                                                            MyTheme.blackColor,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.0,
                                              child: snapshot.data![index]
                                                      .zodiac.isEmpty
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      getZodiac(snapshot
                                                          .data![index].zodiac),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        color:
                                                            MyTheme.blackColor,
                                                      ),
                                                    ),
                                            ),
                                            SizedBox(
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.0,
                                              child: snapshot
                                                      .data![index].star.isEmpty
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      getStar(snapshot
                                                          .data![index].star),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 18,
                                                        color:
                                                            MyTheme.blackColor,
                                                      ),
                                                    ),
                                            ),
                                          ]),
                                    ]),
                                    snapshot.data![index].maritalStatus
                                                .isEmpty ||
                                            snapshot.data![index]
                                                    .maritalStatus ==
                                                'A' ||
                                            snapshot.data![index]
                                                    .maritalStatus ==
                                                'U'
                                        ? const SizedBox.shrink()
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                left: 4.0, top: 10.0),
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 6.0,
                                                right: 10.0,
                                                bottom: 6.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                color: MyTheme.yellowColor),
                                            child: Text(
                                              getMarital(snapshot
                                                  .data![index].maritalStatus),
                                              style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                  color: MyTheme.blackColor,
                                                  letterSpacing: 0.8,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                    snapshot.data![index].professionId.isEmpty
                                        ? const SizedBox.shrink()
                                        : Container(
                                            width:
                                                MyComponents.widthSize(context),
                                            margin: const EdgeInsets.only(
                                                left: 4.0, top: 10.0),
                                            child: Row(children: [
                                              Icon(
                                                Icons.cake_rounded,
                                                color: MyTheme.redColor,
                                              ),
                                              Text(
                                                ' ${snapshot.data![index].age} Years',
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: MyTheme.blackColor,
                                                    letterSpacing: 0.4,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                          ),
                                    snapshot.data![index].professionId.isEmpty
                                        ? const SizedBox.shrink()
                                        : Container(
                                            width:
                                                MyComponents.widthSize(context),
                                            margin: const EdgeInsets.only(
                                                left: 4.0, top: 10.0),
                                            child: Row(children: [
                                              Icon(
                                                Icons.work_rounded,
                                                color: MyTheme.redColor,
                                              ),
                                              Text(
                                                ' ${getProfession(snapshot.data![index].professionId)}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: MyTheme.blackColor,
                                                    letterSpacing: 0.4,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                          ),
                                    snapshot.data![index].districtName.isEmpty
                                        ? const SizedBox.shrink()
                                        : Container(
                                            width:
                                                MyComponents.widthSize(context),
                                            margin: const EdgeInsets.only(
                                                left: 4.0, top: 10.0),
                                            child: Row(children: [
                                              Icon(
                                                Icons.location_on_sharp,
                                                color: MyTheme.redColor,
                                              ),
                                              Text(
                                                ' ${snapshot.data![index].districtName}, '
                                                '${snapshot.data![index].stateCode}',
                                                style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    color: MyTheme.blackColor,
                                                    letterSpacing: 0.4,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ]),
                                          ),
                                    Container(
                                      width: MyComponents.widthSize(context),
                                      margin: const EdgeInsets.only(
                                          left: 4.0,
                                          top: 10.0,
                                          right: 4.0,
                                          bottom: 10.0),
                                      child: snapshot
                                              .data![index].justViewedId.isEmpty
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(
                                                      MyComponents.widthSize(
                                                              context) /
                                                          2.4,
                                                      kToolbarHeight - 6.0),
                                                  backgroundColor: SharedPrefs
                                                              .getLimitViewProfileReached <=
                                                          0
                                                      ? MyTheme.greyColor
                                                      : MyTheme.baseColor),
                                              onPressed: () async {
                                                if (SharedPrefs
                                                        .getLimitViewProfileReached <=
                                                    0) {
                                                  getPrimeDialog(context);
                                                } else {
                                                  SharedPrefs
                                                      .limitViewProfileReached(
                                                          SharedPrefs
                                                                  .getLimitViewProfileReached -
                                                              1);
                                                  snapshot.data![index]
                                                          .justViewedId =
                                                      myprofiledata[0]
                                                          .profileId;
                                                  ApiService.addViewDetails(
                                                          snapshot.data![index]
                                                              .profileId,
                                                          myprofiledata[0]
                                                              .subscribedPremiumCount)
                                                      .then((value) {});
                                                  var result =
                                                      await MyComponents
                                                          .navPush(
                                                    context,
                                                    (p0) => ViewProfileScreen(
                                                        myprofile:
                                                            myprofiledata[0],
                                                        profiledata: snapshot
                                                            .data![index],
                                                        returnPage: 'Home',
                                                        screenType: 'View'),
                                                  );
                                                  if (result != null ||
                                                      result
                                                          .toString()
                                                          .isNotEmpty) {
                                                    setState(() {
                                                      snapshot.data![index]
                                                              .justViewedId =
                                                          result.toString();
                                                    });
                                                  }
                                                }
                                              },
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .visibility_rounded),
                                                    Text(
                                                      ' Detailed Profile',
                                                      style: GoogleFonts.rubik(
                                                          color: SharedPrefs
                                                                      .getLimitViewProfileReached <=
                                                                  0
                                                              ? MyTheme
                                                                  .blackColor
                                                              : MyTheme
                                                                  .whiteColor,
                                                          fontSize: 18,
                                                          letterSpacing: 0.4,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ]),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                MyComponents.navPush(
                                                  context,
                                                  (p0) => ViewProfileScreen(
                                                      myprofile:
                                                          myprofiledata[0],
                                                      profiledata:
                                                          snapshot.data![index],
                                                      returnPage: 'Home',
                                                      screenType: 'Viewed'),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  fixedSize: Size(
                                                      MyComponents.widthSize(
                                                              context) /
                                                          2.4,
                                                      kToolbarHeight - 16.0),
                                                  backgroundColor:
                                                      MyTheme.yellowColor),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons
                                                        .visibility_rounded),
                                                    Text(
                                                      'Viewed Profile',
                                                      style: GoogleFonts.rubik(
                                                          color: MyTheme
                                                              .blackColor,
                                                          fontSize: 18,
                                                          letterSpacing: 0.4,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ]),
                                            ),
                                    ),
                                  ]),
                            ),
                          ),
                          if (isIncrementLoading &&
                              index == snapshot.data!.length - 1)
                            Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                  color: MyTheme.backgroundBox,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: MyTheme.greyColor)),
                              child: Container(
                                width: MyComponents.widthSize(context),
                                padding: const EdgeInsets.all(2.0),
                                child: Column(children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: FadeShimmer.round(
                                            size: 120,
                                            baseColor: MyTheme.greyColor,
                                            highlightColor: MyTheme.whiteColor,
                                          ),
                                        ),
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FadeShimmer(
                                              baseColor: MyTheme.greyColor,
                                              highlightColor:
                                                  MyTheme.whiteColor,
                                              height: kToolbarHeight - 46.0,
                                              radius: 8,
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FadeShimmer(
                                              baseColor: MyTheme.greyColor,
                                              highlightColor:
                                                  MyTheme.whiteColor,
                                              height: kToolbarHeight - 46.0,
                                              radius: 8,
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.2,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: FadeShimmer(
                                              baseColor: MyTheme.greyColor,
                                              highlightColor:
                                                  MyTheme.whiteColor,
                                              height: kToolbarHeight - 26.0,
                                              radius: 8,
                                              width: MyComponents.widthSize(
                                                      context) /
                                                  2.2,
                                            ),
                                          ),
                                        ]),
                                      ]),
                                ]),
                              ),
                            )
                        ]);
                      });
            }),
      ),
    );
  }

  Widget emptyDataToShow() {
    return MyComponents.emptyDatatoshow(
        context, MyComponents.emptySearch, 'Profile not found!', 'Reload', true,
        () {
      setState(() {
        clearData();
      });
      getFilterData('', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
          '', '', '', '', '', '', '', sendSortData, currentLength.toString());
    });
  }

  getPrimeDialog(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        true,
        const SizedBox.shrink(),
        SizedBox(
          height: kToolbarHeight + 144.0,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage(MyComponents.cancelPicture),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        'Dear Member, to avail this service, kindly upgrade to ',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: MyTheme.blackColor,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: 'PREMIUM SUBSCRIPTION',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            letterSpacing: 0.4,
                            color: MyTheme.baseColor,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: '.',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            letterSpacing: 0.4,
                            color: MyTheme.blackColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ]),
              ),
            ),
          ]),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
              MyComponents.navPush(context, (p0) => const SubscriptionScreen());
            },
            child: Text(
              'Get SubScription',
              style: GoogleFonts.inter(
                  color: MyTheme.baseColor,
                  fontSize: 18,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'May be later',
              style: GoogleFonts.inter(
                  color: MyTheme.baseColor,
                  fontSize: 18,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ]);
  }

  showFilterDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState2) {
            return Dialog(
              elevation: 0.0,
              backgroundColor: MyTheme.whiteColor,
              insetPadding: const EdgeInsets.all(0.0),
              child: Scaffold(
                appBar: MyComponents.appbarWithTitle(
                    context,
                    'Filter/Sort Search',
                    false,
                    [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            clearData();
                            MyComponents.navPop(context);
                          },
                          child: Text(
                            'Close',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                    MyTheme.whiteColor),
                body: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Sort Profile By',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>(
                                items: HardCodeData.selectSort,
                                selectedItem: selectedProfile,
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
                                  setState2(() {
                                    selectedProfile = value!;
                                    if (selectedProfile == 'Ascending') {
                                      sendSortData = 'asc';
                                    } else if (selectedProfile ==
                                        'Descending') {
                                      sendSortData = 'desc';
                                    } else {
                                      sendSortData = '';
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false, fit: FlexFit.loose),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: selectedProfile,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Profile No.',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight - 6.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: TextField(
                                controller: userProfileNo,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    color: MyTheme.blackColor),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hintText: 'Enter Profile No',
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      color: MyTheme.blackColor),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Education',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                border: Border.all(color: MyTheme.blackColor),
                                color: MyTheme.whiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>.multiSelection(
                                  dropdownButtonProps: DropdownButtonProps(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 2.0),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                      color: MyTheme.blackColor,
                                    ),
                                  ),
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: 'Select Education',
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                  items: educationData,
                                  selectedItems: selectedEducationData,
                                  onChanged: (value) {
                                    setState2(() {
                                      if (value.isEmpty) {
                                        selectedEducationData.clear();
                                        educationDataId.clear();
                                      }
                                      for (var element
                                          in MyComponents.educationData) {
                                        if (value.contains(element.name)) {
                                          educationDataId.add(element.id);
                                          selectedEducationData
                                              .add(element.name);
                                        }
                                      }
                                      String data = educationDataId
                                          .toString()
                                          .replaceAll('[', '');
                                      String data1 = data.replaceAll(']', '');
                                      sendEducationDataId = data1;
                                    });
                                  }),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Age',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MyComponents.widthSize(context) / 2.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyTheme.blackColor),
                                        color: MyTheme.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    margin: const EdgeInsets.all(10.0),
                                    child: DropdownSearch<String>(
                                      items: HardCodeData.userAge,
                                      selectedItem: selectedFromAgeData,
                                      dropdownButtonProps: DropdownButtonProps(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 2.0),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: MyTheme.blackColor,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState2(() {
                                          selectedFromAgeData = value!;
                                          sendFromAgeData = selectedFromAgeData;
                                        });
                                      },
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                              showSearchBox: false),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: 'From',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.4,
                                              color: MyTheme.blackColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MyComponents.widthSize(context) / 2.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyTheme.blackColor),
                                        color: MyTheme.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    margin: const EdgeInsets.only(right: 8.0),
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: DropdownSearch<String>(
                                      items: HardCodeData.userAge,
                                      selectedItem: selectedToAgeData,
                                      dropdownButtonProps: DropdownButtonProps(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 2.0),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: MyTheme.blackColor,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState2(() {
                                          selectedToAgeData = value!;
                                          sendToAgeData = selectedToAgeData;
                                        });
                                      },
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                              showSearchBox: false),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: 'To',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.4,
                                              color: MyTheme.blackColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Caste/Denomination',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            SizedBox(
                              width: MyComponents.widthSize(context),
                              child: CheckboxListTile(
                                value: isChettiyar,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                  'All Chettiyar Subcaste Invited',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                                onChanged: (value) {
                                  setState2(() {
                                    isChettiyar = !isChettiyar;
                                    if (isChettiyar) {
                                      subCateDataId.clear();
                                      selectedSubCateData.clear();
                                      for (var element
                                          in MyComponents.subcasteData) {
                                        subCateDataId.add(element.subCasteId);
                                      }
                                      String data = subCateDataId
                                          .toString()
                                          .replaceAll('[', '');
                                      String data1 = data.replaceAll(']', '');
                                      sendIsCaste = '1';
                                      sendSubCateDataId = data1;
                                    }
                                  });
                                },
                              ),
                            ),
                            Visibility(
                              visible: isChettiyar ? false : true,
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: MyTheme.blackColor),
                                    color: MyTheme.whiteColor,
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                margin: const EdgeInsets.all(10.0),
                                child: DropdownSearch<String>.multiSelection(
                                  items: subCateData,
                                  selectedItems: selectedSubCateData,
                                  dropdownButtonProps: DropdownButtonProps(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 2.0),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                      color: MyTheme.blackColor,
                                    ),
                                  ),
                                  onChanged: (values) {
                                    setState2(() {
                                      if (values.isEmpty) {
                                        subCateDataId.clear();
                                        selectedSubCateData.clear();
                                      }
                                      if (!isChettiyar) {
                                        for (var element
                                            in MyComponents.subcasteData) {
                                          if (values
                                              .contains(element.subCasteName)) {
                                            subCateDataId
                                                .add(element.subCasteId);
                                            selectedSubCateData
                                                .add(element.subCasteName);
                                          }
                                        }
                                        String data = subCateDataId
                                            .toString()
                                            .replaceAll('[', '');
                                        String data1 = data.replaceAll(']', '');
                                        sendIsCaste = '0';
                                        sendSubCateDataId = data1;
                                      }
                                    });
                                  },
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: 'Select the Caste/Denomination',
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Height',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MyComponents.widthSize(context) / 2.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyTheme.blackColor),
                                        color: MyTheme.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    margin: const EdgeInsets.all(10.0),
                                    child: DropdownSearch<String>(
                                      items: heighData,
                                      selectedItem: selectedHeighFromData,
                                      dropdownButtonProps: DropdownButtonProps(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 2.0),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: MyTheme.blackColor,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState2(() {
                                          selectedHeighFromData =
                                              value.toString();
                                          for (var element
                                              in MyComponents.heightData) {
                                            if (element.name.contains(
                                                selectedHeighFromData)) {
                                              sendHeighFromData = element.id;
                                            }
                                          }
                                        });
                                      },
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                              showSearchBox: false),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: 'From',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.4,
                                              color: MyTheme.blackColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MyComponents.widthSize(context) / 2.4,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: MyTheme.blackColor),
                                        color: MyTheme.whiteColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    margin: const EdgeInsets.all(10.0),
                                    child: DropdownSearch<String>(
                                      items: heighData,
                                      selectedItem: selectedHeighToData,
                                      dropdownButtonProps: DropdownButtonProps(
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 2.0),
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 24,
                                          color: MyTheme.blackColor,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState2(() {
                                          selectedHeighToData =
                                              value.toString();
                                          for (var element
                                              in MyComponents.heightData) {
                                            if (element.name.contains(
                                                selectedHeighToData)) {
                                              sendHeighToData = element.id;
                                            }
                                          }
                                        });
                                      },
                                      popupProps:
                                          const PopupPropsMultiSelection.menu(
                                              showSearchBox: false),
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          hintText: 'To',
                                          hintStyle: TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.4,
                                              color: MyTheme.blackColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Nakshatharam/Star',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight - 6.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>(
                                items: starTypeData,
                                selectedItem: selectedStarTypeData,
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
                                  setState2(() {
                                    selectedStarTypeData = value.toString();
                                    for (var element
                                        in HardCodeData.startypedata) {
                                      if (element.textName
                                          .contains(selectedStarTypeData)) {
                                        sendStarTypeData = element.id;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select Star Type',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Raasi/Zodiac',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>(
                                items: zodicData,
                                selectedItem: selectedZodicData,
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
                                  setState2(() {
                                    selectedZodicData = value.toString();
                                    for (var element
                                        in HardCodeData.zodiaclist) {
                                      if (element.textName
                                          .contains(selectedZodicData)) {
                                        setState(() {
                                          sendZodicData = element.id;
                                        });
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select Raasi/Zodic',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Dosham',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>(
                                items: HardCodeData.dosham,
                                selectedItem: selectedDhosamData,
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
                                  setState2(() {
                                    selectedDhosamData = value.toString();
                                    sendDhosamData = selectedDhosamData;
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false, fit: FlexFit.loose),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select Dosham',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Photos',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: MyTheme.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: galleryData,
                                selectedItem: selectedGalleryData,
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
                                  setState2(() {
                                    selectedGalleryData = value.toString();
                                    for (var element
                                        in HardCodeData.gallerysettingData) {
                                      if (element.textName
                                          .contains(selectedGalleryData)) {
                                        sendGalleryData = element.id;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false, fit: FlexFit.loose),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select Photos',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Horoscope Setting',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>(
                                items: horoscopeSettingData,
                                selectedItem: selectedHoroscopeSettingData,
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
                                  setState2(() {
                                    selectedHoroscopeSettingData =
                                        value.toString();
                                    for (var element
                                        in HardCodeData.horoscopesettingData) {
                                      if (element.textName.contains(
                                          selectedHoroscopeSettingData)) {
                                        sendHoroscopeSettingData = element.id;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false, fit: FlexFit.loose),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select Horoscope',
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Marital Status',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              child: DropdownSearch<String>.multiSelection(
                                  dropdownButtonProps: DropdownButtonProps(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 2.0),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 24,
                                      color: MyTheme.blackColor,
                                    ),
                                  ),
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: 'Select Martial Status',
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                  items: martialStatusData,
                                  selectedItems: selectedMartialStatusData,
                                  onChanged: (value) {
                                    setState2(() {
                                      if (value.isEmpty) {
                                        selectedMartialStatusData.clear();
                                        martialStatusDataId.clear();
                                      }
                                      for (var element
                                          in HardCodeData.maritalData) {
                                        if (value.contains(element.textName)) {
                                          martialStatusDataId.add(element.id);
                                        }
                                      }
                                      String data = martialStatusDataId
                                          .toString()
                                          .replaceAll('[', '');
                                      String data1 = data.replaceAll(']', '');
                                      sendMartialStatusDataId = data1;
                                    });
                                  }),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Salary',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight - 6.0,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: MyTheme.blackColor),
                                  color: MyTheme.whiteColor,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: DropdownSearch<String>(
                                items: salaryData,
                                selectedItem: selectedSalaryData,
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
                                  setState2(() {
                                    selectedSalaryData = value.toString();
                                    for (var element
                                        in HardCodeData.salaryData) {
                                      if (element.textName
                                          .contains(selectedSalaryData)) {
                                        sendSalaryData = element.id;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: selectedSalaryData,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          'Residential Location',
                          style: GoogleFonts.rubik(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w400),
                        ),
                        children: [
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: MyTheme.transparent,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: countryData,
                              selectedItem: selectedCountryData,
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
                                setState2(() {
                                  selectedCountryData = value.toString();
                                  for (var element
                                      in MyComponents.countryData) {
                                    if (selectedCountryData == 'India') {
                                      isDistrictDataVisible = true;
                                      sendCountryData = '85';
                                    } else if (element.countryText
                                        .contains(selectedCountryData)) {
                                      isDistrictDataVisible = false;
                                      sendCountryData = element.countryId;
                                      selectedStateData =
                                          'Select your Native State';
                                      selectedDistrictData =
                                          'Select your Native District,State';
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: true),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: selectedCountryData,
                                  hintStyle: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      color: MyTheme.blackColor),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isDistrictDataVisible,
                            child: SizedBox(
                              width: MyComponents.widthSize(context),
                              child: Container(
                                width: MyComponents.widthSize(context),
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: MyTheme.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: MyTheme.greyColor),
                                ),
                                child: DropdownSearch<String>(
                                  items: stateData,
                                  selectedItem: selectedStateData,
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
                                    setState2(() {
                                      selectedStateData = value.toString();
                                      for (var element
                                          in MyComponents.stateData) {
                                        if (element.stateName
                                            .contains(selectedStateData)) {
                                          sendStateData = element.stateId;
                                        }
                                      }
                                      districtData.clear();
                                      for (var element
                                          in MyComponents.locationData) {
                                        if (element.stateId == sendStateData) {
                                          districtData.add(
                                              '${element.districtName},$selectedStateData');
                                        }
                                      }
                                    });
                                  },
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: selectedStateData,
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isDistrictDataVisible,
                            child: SizedBox(
                              width: MyComponents.widthSize(context),
                              child: Container(
                                width: MyComponents.widthSize(context),
                                height: kToolbarHeight - 6.0,
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: MyTheme.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: MyTheme.greyColor),
                                ),
                                child: DropdownSearch<String>(
                                  items: districtData,
                                  selectedItem: selectedDistrictData,
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
                                    setState2(() {
                                      selectedDistrictData = value!;
                                      for (var element
                                          in MyComponents.locationData) {
                                        if (element.districtName.contains(
                                            selectedDistrictData
                                                .split(',')
                                                .first)) {
                                          sendDistrictData = element.districtId;
                                        }
                                      }
                                    });
                                  },
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: selectedDistrictData,
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Work Location',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: MyTheme.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: workLocationData,
                                selectedItem: selectedWorkLocationData,
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
                                  setState2(() {
                                    selectedWorkLocationData = value.toString();
                                    for (var element
                                        in MyComponents.stateData) {
                                      if (element.stateName
                                          .contains(selectedWorkLocationData)) {
                                        sendWorkLocationData = element.stateId;
                                      }
                                    }
                                    if (selectedWorkLocationData ==
                                        'Working Abroad') {
                                      sendWorkLocationData = '999';
                                      isAbroadLocationVisibleData = true;
                                    } else {
                                      isAbroadLocationVisibleData = false;
                                      selectedAbroadLocationData =
                                          'Select your Specify Location';
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: selectedWorkLocationData,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: isAbroadLocationVisibleData,
                              child: Container(
                                width: MyComponents.widthSize(context),
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                margin: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: MyTheme.transparent,
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: MyTheme.greyColor),
                                ),
                                child: DropdownSearch<String>(
                                  items: abroadLocationData,
                                  selectedItem: selectedAbroadLocationData,
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
                                    setState2(() {
                                      selectedAbroadLocationData =
                                          value.toString();
                                      for (var element
                                          in MyComponents.countryData) {
                                        if (element.countryText.contains(
                                            selectedAbroadLocationData)) {
                                          sendAbroadLocationData =
                                              element.countryId;
                                        }
                                      }
                                    });
                                  },
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                          showSearchBox: true),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: selectedAbroadLocationData,
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          color: MyTheme.blackColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Profession',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: MyTheme.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: professionData,
                                selectedItem: selectedProfessionData,
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
                                  setState2(() {
                                    selectedProfessionData = value.toString();
                                    for (var element
                                        in MyComponents.occupationData) {
                                      if (element.occupationName
                                          .contains(selectedProfessionData)) {
                                        sendProfessionData =
                                            element.occupationId;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: selectedProfessionData,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: ExpansionTile(
                          initiallyExpanded: true,
                          title: Text(
                            'Job Type',
                            style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: MyTheme.transparent,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: jobTypeData,
                                selectedItem: selectedJobTypeData,
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
                                  setState2(() {
                                    selectedJobTypeData = value.toString();
                                    for (var element
                                        in HardCodeData.jobTypeList) {
                                      if (element.textName
                                          .contains(selectedJobTypeData)) {
                                        sendJobTypeData = element.id;
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: false, fit: FlexFit.loose),
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    hintText: selectedJobTypeData,
                                    hintStyle: TextStyle(
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        color: MyTheme.blackColor),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(height: kToolbarHeight + 14.0),
                  ]),
                ),
                bottomNavigationBar: Container(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight + 4.0,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentLength = 0;
                            });
                            searchProfileData.clear();
                            getFilterData(
                                userProfileNo.text,
                                sendEducationDataId,
                                sendFromAgeData,
                                sendToAgeData,
                                sendIsCaste,
                                sendSubCateDataId,
                                sendHeighFromData,
                                sendHeighToData,
                                sendStarTypeData,
                                sendZodicData,
                                sendDhosamData,
                                sendGalleryData,
                                sendMartialStatusDataId,
                                sendHoroscopeSettingData,
                                sendSalaryData,
                                sendCountryData,
                                sendStateData,
                                sendDistrictData,
                                sendWorkLocationData,
                                sendAbroadLocationData,
                                sendJobTypeData,
                                sendProfessionData,
                                sendSortData,
                                currentLength.toString());
                            MyComponents.navPop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.baseColor),
                          child: Text(
                            'Apply',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState2(() {
                              clearData();
                            });
                            searchProfileData.clear();
                            getFilterData(
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                sendSortData,
                                currentLength.toString());
                            MyComponents.navPop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.whiteColor),
                          child: Text(
                            'Clear All',
                            style: GoogleFonts.inter(
                                color: MyTheme.baseColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          });
        });
  }

  String getMarital(String maritalStatus) {
    String data = '';
    for (var i = 0; i < HardCodeData.maritalData.length; i++) {
      if (HardCodeData.maritalData[i].id == maritalStatus) {
        data = HardCodeData.maritalData[i].textName;
      }
    }
    return data;
  }

  String getZodiac(String zodiacData) {
    String zodiac = '';
    for (var element in HardCodeData.zodiaclist) {
      if (element.id == zodiacData) {
        zodiac = element.textName;
      }
    }
    return zodiac;
  }

  String getStar(String starData) {
    String star = '';
    for (var element in HardCodeData.startypedata) {
      if (element.id == starData) {
        star = element.textName;
      }
    }
    return star;
  }

  String getProfession(String professionId) {
    String occupationName = '';
    for (var element in MyComponents.occupationData) {
      if (element.occupationId == professionId) {
        occupationName = element.occupationName;
      }
    }
    return occupationName;
  }

  getCircularImage(SearchProfileMessage searchProfile) {
    if (SharedPrefs.getSubscribeId == '1') {
      if (searchProfile.showInterestAcceptedProfile == '1' ||
          searchProfile.visibleToAll == '1' ||
          searchProfile.protectPhoto == '1') {
        if (searchProfile.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image.network(searchProfile.messageAvatar,
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
      if (searchProfile.protectPhoto == '1') {
        if (searchProfile.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image.network(searchProfile.messageAvatar,
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
    }
  }

  getStepData() {
    countryData.clear();
    stateData.clear();
    districtData.clear();
    workLocationData.clear();
    abroadLocationData.clear();
    heighData.clear();
    mothertongueData.clear();
    religionData.clear();
    casteData.clear();
    subCateData.clear();
    educationData.clear();
    professionData.clear();
    zodicData.clear();
    starTypeData.clear();
    salaryData.clear();
    martialStatusData.clear();
    physicalStatusData.clear();
    familyValueData.clear();
    familyTypeData.clear();
    annualIncomeData.clear();
    galleryData.clear();
    jobTypeData.clear();
    horoscopeSettingData.clear();

    for (var element in HardCodeData.zodiaclist) {
      zodicData.add(element.textName);
    }
    for (var element in HardCodeData.startypedata) {
      starTypeData.add(element.textName);
    }
    for (var element in HardCodeData.salaryData) {
      salaryData.add(element.textName);
    }
    for (var element in HardCodeData.maritalData) {
      martialStatusData.add(element.textName);
    }
    for (var element in HardCodeData.physicalStatusData) {
      physicalStatusData.add(element.textName);
    }
    for (var element in HardCodeData.familyValueData) {
      familyValueData.add(element.textName);
    }
    for (var element in HardCodeData.familyTypeData) {
      familyTypeData.add(element.textName);
    }
    for (var element in HardCodeData.annualincomedata) {
      annualIncomeData.add(element.textName);
    }
    for (var element in HardCodeData.gallerysettingData) {
      galleryData.add(element.textName);
    }
    for (var element in HardCodeData.horoscopesettingData) {
      horoscopeSettingData.add(element.textName);
    }
    for (var element in HardCodeData.jobTypeList) {
      jobTypeData.add(element.textName);
    }

    countryData.add('India');
    for (var value in MyComponents.countryData) {
      countryData.add(value.countryText);
      abroadLocationData.add(value.countryText);
    }
    workLocationData.add('Working Abroad');
    for (var value in MyComponents.stateData) {
      stateData.add(value.stateName);
      workLocationData.add(value.stateName);
    }
    for (var value in MyComponents.heightData) {
      heighData.add(value.name);
    }
    for (var value in MyComponents.religionData) {
      religionData.add(value.name);
    }
    for (var value in MyComponents.casteData) {
      casteData.add(value.casteName);
    }
    for (var value in MyComponents.subcasteData) {
      subCateData.add(value.subCasteName);
    }
    for (var value in MyComponents.mothertongueData) {
      mothertongueData.add(value.name);
    }
    for (var value in MyComponents.educationData) {
      educationData.add(value.name);
    }
    for (var value in MyComponents.occupationData) {
      professionData.add(value.occupationName);
    }
  }

  clearData() {
    currentLength = 0;
    userProfileNo.clear();
    educationDataId.clear();
    subCateDataId.clear();
    martialStatusDataId.clear();
    selectedEducationData.clear();
    selectedSubCateData.clear();
    selectedMartialStatusData.clear();
    selectedProfile = 'Recent Upload Profile';
    sendSortData = '';
    sendIsCaste = '';
    selectedCountryData = 'Select Nationality';
    selectedStateData = 'Select State';
    selectedDistrictData = 'Select District,State';
    selectedWorkLocationData = 'Select Work Location';
    selectedAbroadLocationData = 'Select Abroad Location';
    selectedHeighFromData = 'From';
    selectedHeighToData = 'To';
    selectedMothertongueData = 'Select Mother Tongue';
    selectedReligionData = 'Select Religion';
    selectedCasteData = 'Select Caste';
    selectedProfessionData = 'Select Profession';
    selectedSalaryData = 'Select Salary';
    selectedFamilyValueData = 'Select FamilyValue';
    selectedFamilyTypeData = 'Select FamilyType';
    selectedPhysicalStatusData = 'Select Physical Status';
    selectedAnnualIncomeData = 'Select Annual Income';
    selectedZodicData = 'Select Zodic';
    selectedDhosamData = 'Select Dhosam';
    selectedStarTypeData = 'Select Star Type';
    selectedGalleryData = 'Select Photos';
    selectedHoroscopeSettingData = 'Select Horoscope';
    selectedFromAgeData = 'From';
    selectedToAgeData = 'To';
    selectedJobTypeData = 'Select JobType';
    sendJobTypeData = '';
    sendFromAgeData = '';
    sendToAgeData = '';
    sendCountryData = '';
    sendStateData = '';
    sendDistrictData = '';
    sendWorkLocationData = '';
    sendAbroadLocationData = '';
    sendHeighFromData = '';
    sendHeighToData = '';
    sendMothertongueData = '';
    sendReligionData = '';
    sendCasteData = '';
    sendProfessionData = '';
    sendSalaryData = '';
    sendFamilyValueData = '';
    sendFamilyTypeData = '';
    sendPhysicalStatusData = '';
    sendAnnualIncomeData = '';
    sendZodicData = '';
    sendDhosamData = '';
    sendStarTypeData = '';
    sendGalleryData = '';
    sendEducationDataId = '';
    sendSubCateDataId = '';
    sendMartialStatusDataId = '';
    sendHoroscopeSettingData = '';
  }

  Future<void> onPullToRefresh() {
    return Future.delayed(const Duration(seconds: 1), () {
      onPullToRefreshData(0);
    });
  }

  onPullToRefreshData(int currentLength) {
    getFilterData('', '', '', '', '', '', '', '', '', '', '', '', '', '', '',
        '', '', '', '', '', '', '', sendSortData, currentLength.toString());
  }

  getFilterData(
      String profileNo,
      String educationId,
      String fromAge,
      String toAge,
      String isCasteBar,
      String subCasteId,
      String fromHeight,
      String toHeight,
      String star,
      String zodiac,
      String dosham,
      String gallerySettings,
      String maritalStatusesId,
      String horoscope,
      String salary,
      String countryId,
      String stateId,
      String districtId,
      String locationId,
      String wrkAbrCountry,
      String jobTitle,
      String professionId,
      String sortList,
      String offsetLimit) {
    myprofiledata.clear();
    ApiService.postprofilelist().then((value) {
      myprofiledata.addAll(value.message);
      SharedPrefs.userGender(value.message[0].gender);
      SharedPrefs.profileSubscribeId(value.message[0].subscribedPremiumId);
      ApiService.filterprofilelist(
              profileNo,
              educationId,
              fromAge,
              toAge,
              isCasteBar,
              subCasteId,
              fromHeight,
              toHeight,
              star,
              zodiac,
              dosham,
              gallerySettings,
              maritalStatusesId,
              horoscope,
              salary,
              countryId,
              stateId,
              districtId,
              locationId,
              wrkAbrCountry,
              jobTitle,
              professionId,
              sortList,
              offsetLimit)
          .then((searchValue) {
        searchProfileData.addAll(searchValue.message);
        searchControllers.sink.add(searchProfileData);
        setState(() {
          currentLength = searchProfileData.length;
          isIncrementLoading = false;
        });
      });
    });
  }
}
