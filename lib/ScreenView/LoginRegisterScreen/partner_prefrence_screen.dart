import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/drop_list_class.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/ModelClass/setps_info.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/astro_detail_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/profile_preview_screen.dart';

TextEditingController aboutpartner = TextEditingController();
List<String> partnerphysicalstatus = [];
List<String> partnersubcaste = [];
List<String> partnereducation = [];
List<String> partnerprofession = [];
List<String> partnersalary = [];
List<String> partnerworkAbLocation = [];
List<String> partnermarital = [];
List<String> partnerfamilyvalue = [];
List<String> partnerfamilytype = [];
List<String> partnerreligion = [];
List<String> partnerannualincome = [];
List<String> partnermothertongue = [];
List<String> partnerheight = [];
List<String> partnerheight2 = [];
List<String> partnerLocation = [];
List<String> selectedmothertongue = [];
List<String> selectedcaste = [];
List<String> selectededucation = [];
List<String> selectedoccupation = [];
List<String> selectedcountry = [];
List<String> selectedstate = [];
List<String> selectedplace = [];
List<String> selectedwork = [];
List<String> selectedAbroadWork = [];
List<String> selectedmarital = [];
String selectedpartPhysicalstatus = 'Select the Physical Status',
    selectedpartfamilytypes = 'Select the Family Type',
    selectedpartannualincome = 'Select the Annual Income',
    selectedpartreligions = 'Select the Religion',
    selectedparteducations = 'Select the Education',
    selectedpartcountries = 'Select the Country',
    selectedpartstates = 'Select the State',
    selectedpartmaritalstatuses = 'Select the Marital Status',
    selectedpartoccupations = 'Select the Profession',
    selectedpartlocations = 'Select the Native Place',
    selectedpartworklocations = 'Select the Work Location',
    selectedpartmothertongue = 'Select the Mother Tongue',
    selectedpartage1 = 'From',
    selectedpartage2 = 'To',
    selectedpartheight1 = 'From',
    selectedpartheight2 = 'To',
    selectedpartheightId1 = '',
    selectedpartheightId2 = '',
    partphysicalStatus = '',
    partreligionId = '',
    partfamilyType = '',
    partannualIncome = '';
List<String> selectFrom = [],
    selectTo = [],
    motherTongueId = [],
    denominationId = [],
    educationId = [],
    occupationId = [],
    countryId = [],
    stateId = [],
    nativeId = [],
    workId = [],
    abroadWorkId = [],
    maritalId = [];

class PartnerPrefrenceScreen extends StatefulWidget {
  final String isProfileCreatedbyAdmin;
  const PartnerPrefrenceScreen(
      {Key? key, required this.isProfileCreatedbyAdmin})
      : super(key: key);

  @override
  State<PartnerPrefrenceScreen> createState() => _PartnerPrefrenceScreenState();
}

class _PartnerPrefrenceScreenState extends State<PartnerPrefrenceScreen> {
  bool selected = false,
      isLoading = true,
      isPageLoading = true,
      isMotherTongue = true,
      isDenomination = true,
      isEducation = true,
      isOccupation = true,
      isCountry = true,
      isState = true,
      isNativePlace = true,
      isWorkLocation = true,
      isLocationState = true,
      isWorkAbLocation = true,
      isMaritalStatus = true,
      isAboutPartner = true,
      isVisibleState = false,
      isVisibleCity = false,
      isVisibleABLocation = false;
  String isNoCasteData = '0';
  int numLines = 0;

  @override
  void initState() {
    super.initState();
    getPartnerInfo();
  }

  Future<bool> onWillPop() {
    if (SharedPrefs.getDashboard) {
      MyComponents.navPop(context);
    } else {
      MyComponents.navPushAndRemoveUntil(context,
          (p0) => const AstroDetailScreen(isProfileCreatedbyAdmin: ''), true);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MyComponents.appbarWithTitle(
            context, 'Partner Preference', true, [], MyTheme.whiteColor),
        body: isPageLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Age',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.redColor, fontSize: 18),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: MyComponents.widthSize(context),
                        child: Row(children: [
                          Container(
                            width: MyComponents.widthSize(context) / 2.4,
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartage1 == 'From' ||
                                      selectedpartage1.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: selectFrom,
                              selectedItem: selectedpartage1,
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
                                  selectedpartage1 = value!;
                                  for (int i = int.parse(selectedpartage1);
                                      i <= 50;
                                      i++) {
                                    selectTo.add(i.toString());
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'to',
                              style: TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context) / 2.4,
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartage2 == 'To' ||
                                      selectedpartage2.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: selectTo,
                              selectedItem: selectedpartage2,
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
                                  selectedpartage2 = value!;
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Height',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                    color: MyTheme.redColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: MyComponents.widthSize(context),
                        child: Row(children: [
                          Container(
                            width: MyComponents.widthSize(context) / 2.4,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartheight1 == 'From' ||
                                      selectedpartheight1.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerheight,
                              selectedItem: selectedpartheight1,
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
                                  selectedpartheight1 = value!;
                                  selectedpartheightId1 = '';
                                  for (var element in MyComponents.heightData) {
                                    if (element.name
                                        .contains(selectedpartheight1)) {
                                      selectedpartheightId1 = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              'to',
                              style: TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context) / 2.4,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartheight2 == 'To' ||
                                      selectedpartheight2.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerheight2,
                              selectedItem: selectedpartheight2,
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
                                  selectedpartheight2 = value!;
                                  selectedpartheightId2 = '';
                                  for (var element in MyComponents.heightData) {
                                    if (element.name
                                        .contains(selectedpartheight2)) {
                                      selectedpartheightId2 = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Physical Status',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                    color: MyTheme.baseColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartPhysicalstatus ==
                                          'Select the Physical Status' ||
                                      selectedpartPhysicalstatus.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerphysicalstatus,
                              selectedItem: selectedpartPhysicalstatus,
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
                                  selectedpartPhysicalstatus = value!;
                                  partphysicalStatus = '';
                                  for (var element
                                      in HardCodeData.physicalStatusData) {
                                    if (element.textName
                                        .contains(selectedpartPhysicalstatus)) {
                                      partphysicalStatus = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Family Type',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartfamilytypes ==
                                          'Select the Family Type' ||
                                      selectedpartfamilytypes.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerfamilytype,
                              selectedItem: selectedpartfamilytypes,
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
                                  selectedpartfamilytypes = value!;
                                  partfamilyType = '';
                                  for (var element
                                      in HardCodeData.familyTypeData) {
                                    if (element.textName
                                        .contains(selectedpartfamilytypes)) {
                                      partfamilyType = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Mother Tongue',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                    color: MyTheme.baseColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isMotherTongue
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getMotherData(),
                              selectedItems: selectedmothertongue,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isMotherTongue = false;
                                  } else {
                                    isMotherTongue = true;
                                    motherTongueId.clear();
                                    selectedmothertongue.clear();
                                  }
                                  if (data.contains('Any')) {
                                    selectedmothertongue.add('Any');
                                    motherTongueId.add('11');
                                  } else {
                                    for (var element
                                        in MyComponents.mothertongueData) {
                                      if (data.contains(element.name)) {
                                        motherTongueId.add(element.id);
                                        selectedmothertongue.add(element.name);
                                      }
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Mother Tongue',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Annual Income',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedpartannualincome ==
                                          'Select the Annual Income' ||
                                      selectedpartannualincome.isEmpty
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerannualincome,
                              selectedItem: selectedpartannualincome,
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
                                  selectedpartannualincome = value!;
                                  partannualIncome = '';
                                  for (var element
                                      in HardCodeData.annualincomedata) {
                                    if (element.textName
                                        .contains(selectedpartannualincome)) {
                                      partannualIncome = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Religion',
                                  style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                  ),
                                ),
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                    color: MyTheme.baseColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            height: kToolbarHeight - 6.0,
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color:
                                  selectedpartreligions == 'Select the Religion'
                                      ? MyTheme.transparent
                                      : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>(
                              items: partnerreligion,
                              selectedItem: selectedpartreligions,
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
                                  selectedpartreligions = value!;
                                  partreligionId = '';
                                  for (var element
                                      in MyComponents.religionData) {
                                    if (element.name
                                        .contains(selectedpartreligions)) {
                                      partreligionId = element.id;
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: false, fit: FlexFit.loose),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Caste/Denomination',
                              style: GoogleFonts.rubik(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isDenomination
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: MyTheme.greyColor,
                              ),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getCasteData(),
                              selectedItems: selectedcaste,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  denominationId.clear();
                                  selectedcaste.clear();
                                  if (data.isNotEmpty) {
                                    isDenomination = false;
                                  } else {
                                    isDenomination = true;
                                  }
                                  if (data.contains(
                                      'All Chettiyar subcaste invited')) {
                                    isNoCasteData = '1';
                                    denominationId.add('125');
                                    selectedcaste
                                        .add('All Chettiyar subcaste invited');
                                  } else {
                                    isNoCasteData = '0';
                                    for (var element
                                        in MyComponents.subcasteData) {
                                      if (data.contains(element.subCasteName)) {
                                        denominationId.add(element.subCasteId);
                                        selectedcaste.add(element.subCasteName);
                                      }
                                    }
                                  }
                                });
                              },
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Caste/Denomination',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Education',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isEducation
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getEducationData(),
                              selectedItems: selectededucation,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isEducation = false;
                                  } else {
                                    isEducation = true;
                                    educationId.clear();
                                    selectededucation.clear();
                                  }
                                });
                                if (data.contains('Any')) {
                                  educationId.clear();
                                  selectededucation.clear();
                                  selectededucation.add('Any');
                                  educationId.add('187');
                                } else {
                                  for (var element
                                      in MyComponents.educationData) {
                                    if (data.contains(element.name)) {
                                      educationId.add(element.id);
                                      selectededucation.add(element.name);
                                    }
                                  }
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Education',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Occupation',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isOccupation
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getOccupationData(),
                              selectedItems: selectedoccupation,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isOccupation = false;
                                  } else {
                                    isOccupation = true;
                                    occupationId.clear();
                                    selectedoccupation.clear();
                                  }
                                });
                                if (data.contains('Any')) {
                                  occupationId.clear();
                                  selectedoccupation.clear();
                                  selectedoccupation.add('Any');
                                  occupationId.add('130');
                                } else {
                                  for (var element
                                      in MyComponents.occupationData) {
                                    if (data.contains(element.occupationName)) {
                                      occupationId.add(element.occupationId);
                                      selectedoccupation
                                          .add(element.occupationName);
                                    }
                                  }
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Occupation',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Nationality',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isCountry
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getCountryData(),
                              selectedItems: selectedcountry,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  selectedcountry.clear();
                                  selectedstate.clear();
                                  selectedplace.clear();
                                  countryId.clear();
                                  stateId.clear();
                                  nativeId.clear();
                                  if (data.isNotEmpty) {
                                    isCountry = false;
                                    isState = true;
                                    isNativePlace = true;
                                    if (data.contains('Any')) {
                                      isVisibleState = false;
                                      isVisibleCity = false;
                                      selectedcountry.add('Any');
                                      countryId.add('209');
                                    } else if (data.contains('India')) {
                                      isVisibleState = true;
                                      isVisibleCity = true;
                                      selectedcountry.add('India');
                                      countryId.add('85');
                                    } else if (!data.contains('India') &&
                                        !data.contains('Any')) {
                                      isVisibleState = false;
                                      isVisibleCity = false;
                                      for (var element
                                          in MyComponents.countryData) {
                                        if (data
                                            .contains(element.countryText)) {
                                          countryId.add(element.countryId);
                                          selectedcountry
                                              .add(element.countryText);
                                        }
                                      }
                                    }
                                  } else {
                                    isCountry = true;
                                    isVisibleState = false;
                                    isVisibleCity = false;
                                  }
                                });
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Nationality',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Visibility(
                    visible: isVisibleState,
                    child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Native State',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isState
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                items: getStateData(),
                                selectedItems: selectedstate,
                                dropdownButtonProps: DropdownButtonProps(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 2.0),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24,
                                    color: MyTheme.blackColor,
                                  ),
                                ),
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: true,
                                ),
                                onChanged: (data) {
                                  setState(() {
                                    selectedstate.clear();
                                    selectedplace.clear();
                                    stateId.clear();
                                    nativeId.clear();
                                    partnerLocation.clear();
                                    if (data.isEmpty) {
                                      isState = true;
                                      isNativePlace = true;
                                      isVisibleCity = false;
                                    } else {
                                      isState = false;
                                      isNativePlace = true;
                                      if (data.contains('Any')) {
                                        isVisibleCity = false;
                                        selectedstate.add('Any');
                                        stateId.add('39');
                                      } else {
                                        isVisibleCity = true;
                                        for (var element
                                            in MyComponents.stateData) {
                                          if (data
                                              .contains(element.stateName)) {
                                            stateId.add(element.stateId);
                                            selectedstate
                                                .add(element.stateName);
                                          }
                                        }
                                        partnerLocation.add('Any');
                                        for (var i = 0;
                                            i < stateId.length;
                                            i++) {
                                          for (var element
                                              in MyComponents.locationData) {
                                            if (element.stateId == stateId[i]) {
                                              partnerLocation.add(
                                                  '${element.districtName}, ${selectedstate[i]}');
                                            }
                                          }
                                        }
                                      }
                                    }
                                  });
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      hintText: 'Select the Native State',
                                      hintStyle: TextStyle(
                                          color: MyTheme.blackColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          decoration: TextDecoration.none),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  Visibility(
                    visible: isVisibleCity,
                    child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Native Place',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isNativePlace
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                items: partnerLocation,
                                selectedItems: selectedplace,
                                dropdownButtonProps: DropdownButtonProps(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 2.0),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24,
                                    color: MyTheme.blackColor,
                                  ),
                                ),
                                popupProps: const PopupPropsMultiSelection.menu(
                                  showSearchBox: true,
                                ),
                                onChanged: (data) {
                                  setState(() {
                                    nativeId.clear();
                                    selectedplace.clear();
                                    if (data.isEmpty) {
                                      isNativePlace = true;
                                    } else {
                                      isNativePlace = false;
                                      if (data.contains('Any')) {
                                        selectedplace.add('Any');
                                        nativeId.add('736');
                                      } else {
                                        for (var i = 0; i < data.length; i++) {
                                          for (var element
                                              in MyComponents.locationData) {
                                            if (data[i]
                                                .split(',')
                                                .first
                                                .contains(
                                                    element.districtName)) {
                                              nativeId.add(element.districtId);
                                              selectedplace
                                                  .add(element.districtName);
                                            }
                                          }
                                        }
                                      }
                                    }
                                  });
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      hintText: 'Select the Native Place',
                                      hintStyle: TextStyle(
                                          color: MyTheme.blackColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          decoration: TextDecoration.none),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Work Location',
                              style: GoogleFonts.rubik(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isWorkLocation
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getWorkLocation(),
                              selectedItems: selectedwork,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  selectedwork.clear();
                                  selectedAbroadWork.clear();
                                  workId.clear();
                                  abroadWorkId.clear();
                                  partnerworkAbLocation.clear();
                                  isWorkAbLocation = true;
                                  if (data.isEmpty) {
                                    isWorkLocation = true;
                                    isVisibleABLocation = false;
                                  } else if (data.contains('Any')) {
                                    isWorkLocation = false;
                                    selectedwork.add('Any');
                                    workId.add('50');
                                  } else if (data.contains('Working Abroad')) {
                                    selectedwork.add('Working Abroad');
                                    workId.add('999');
                                    isWorkLocation = false;
                                    isLocationState = true;
                                    isVisibleABLocation = true;
                                    partnerworkAbLocation.add('Any');
                                    for (var element
                                        in MyComponents.countryData) {
                                      partnerworkAbLocation
                                          .add(element.countryText);
                                    }
                                  } else {
                                    workId.clear();
                                    selectedwork.clear();
                                    isWorkLocation = false;
                                    isLocationState = false;
                                    isVisibleABLocation = true;
                                    for (var element
                                        in MyComponents.stateData) {
                                      if (data.contains(element.stateName)) {
                                        workId.add(element.stateId);
                                        selectedwork.add(element.stateName);
                                      }
                                    }
                                    partnerworkAbLocation.add('Any');
                                    for (var element
                                        in MyComponents.locationData) {
                                      if (workId[0] == element.stateId) {
                                        partnerworkAbLocation.add(
                                            '${element.districtName}, ${selectedwork[0]}');
                                      }
                                    }
                                  }
                                });
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Work Location',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Visibility(
                    visible: isVisibleABLocation,
                    child: SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Specify the Location',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: isWorkAbLocation
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>.multiSelection(
                                items: partnerworkAbLocation,
                                selectedItems: selectedAbroadWork,
                                dropdownButtonProps: DropdownButtonProps(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 2.0),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 24,
                                    color: MyTheme.blackColor,
                                  ),
                                ),
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true),
                                onChanged: (data) {
                                  setState(() {
                                    abroadWorkId.clear();
                                    selectedAbroadWork.clear();
                                    if (data.isEmpty) {
                                      isWorkAbLocation = true;
                                    } else {
                                      isWorkAbLocation = false;
                                      if (data.contains('Any')) {
                                        selectedAbroadWork.add('Any');
                                        abroadWorkId.add('210');
                                      } else if (selectedwork
                                          .contains('Working Abroad')) {
                                        for (var element
                                            in MyComponents.countryData) {
                                          if (data
                                              .contains(element.countryText)) {
                                            abroadWorkId.add(element.countryId);
                                            selectedAbroadWork
                                                .add(element.countryText);
                                          }
                                        }
                                      } else {
                                        for (var i = 0; i < data.length; i++) {
                                          for (var element
                                              in MyComponents.locationData) {
                                            if (data[i]
                                                .split(',')
                                                .first
                                                .contains(
                                                    element.districtName)) {
                                              abroadWorkId
                                                  .add(element.districtId);
                                              selectedAbroadWork
                                                  .add(element.districtName);
                                            }
                                          }
                                        }
                                      }
                                    }
                                  });
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                      hintText: isLocationState
                                          ? 'Select the Specify Country'
                                          : 'Select the Specify District,State',
                                      hintStyle: TextStyle(
                                          color: MyTheme.blackColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4,
                                          decoration: TextDecoration.none),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'Marital Status',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: ' * ',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.baseColor, fontSize: 18),
                                ),
                              ]),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isMaritalStatus
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: MyTheme.greyColor),
                            ),
                            child: DropdownSearch<String>.multiSelection(
                              items: getMaritalData(),
                              selectedItems: selectedmarital,
                              dropdownButtonProps: DropdownButtonProps(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 2.0),
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 24,
                                  color: MyTheme.blackColor,
                                ),
                              ),
                              popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isMaritalStatus = false;
                                  } else {
                                    isMaritalStatus = true;
                                    maritalId.clear();
                                    selectedmarital.clear();
                                  }
                                });
                                if (data.contains('Any')) {
                                  maritalId.clear();
                                  selectedmarital.clear();
                                  selectedmarital.add('Any');
                                  maritalId.add('A');
                                } else {
                                  maritalId.clear();
                                  selectedmarital.clear();
                                  for (var element
                                      in HardCodeData.maritalData) {
                                    if (data.contains(element.textName)) {
                                      maritalId.add(element.id);
                                      selectedmarital.add(element.textName);
                                    }
                                  }
                                }
                              },
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    hintText: 'Select the Marital Status',
                                    hintStyle: TextStyle(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        decoration: TextDecoration.none),
                                    border: InputBorder.none),
                              ),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'About My Partner',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: ' * ',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.baseColor, fontSize: 18),
                              ),
                            ]),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          height: kToolbarHeight + 84.0,
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isAboutPartner
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                            controller: aboutpartner,
                            keyboardType: TextInputType.multiline,
                            maxLines: 100,
                            style: TextStyle(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                decoration: TextDecoration.none),
                            cursorColor: MyTheme.blackColor,
                            decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 10.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Minimum 15 Words',
                            style: GoogleFonts.inter(
                                color: MyTheme.baseColor,
                                fontSize: 14,
                                letterSpacing: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            : MyComponents.circularLoader(
                MyTheme.transparent, MyTheme.baseColor),
        bottomNavigationBar: isPageLoading
            ? isLoading
                ? SizedBox(
                    width: MyComponents.widthSize(context),
                    height: kToolbarHeight - 6.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedpartage1 == 'From' ||
                            selectedpartage2 == 'To') {
                          MyComponents.toast('Please select the Age');
                          return;
                        }
                        if (selectedpartheight1 == 'From' ||
                            selectedpartheight2 == 'To') {
                          MyComponents.toast('Please select the Height');
                          return;
                        }
                        if (selectedpartPhysicalstatus ==
                            'Select the Physical Status') {
                          MyComponents.toast(
                              'Please select the Physical Status');
                          return;
                        }
                        if (motherTongueId.isEmpty) {
                          MyComponents.toast('Please select the Mother Tongue');
                          return;
                        }
                        if (selectedpartreligions == 'Select Religion') {
                          MyComponents.toast('Please select the Religion');
                          return;
                        }
                        if (maritalId.isEmpty) {
                          MyComponents.toast(
                              'Please select the Marital Status');
                          return;
                        }
                        if (aboutpartner.text.isEmpty) {
                          MyComponents.toast('Please enter about your Partner');
                          return;
                        }
                        if (MyComponents.wordsCountValidator(
                            aboutpartner.text, 15)) {
                          MyComponents.toast('Please enter minimum 15 words.');
                          return;
                        }
                        setState(() {
                          isLoading = false;
                        });
                        try {
                          Future<BasicStep3> listdata =
                              ApiService.postpartnerpreference(
                            selectedpartage1,
                            selectedpartage2,
                            selectedpartheightId1,
                            selectedpartheightId2,
                            partphysicalStatus,
                            partfamilyType,
                            motherTongueId.isEmpty
                                ? 'null'
                                : json.encode(motherTongueId),
                            partannualIncome,
                            partreligionId,
                            isNoCasteData,
                            denominationId.isEmpty
                                ? 'null'
                                : json.encode(denominationId),
                            educationId.isEmpty
                                ? 'null'
                                : json.encode(educationId),
                            occupationId.isEmpty
                                ? 'null'
                                : json.encode(occupationId),
                            countryId.isEmpty ? 'null' : json.encode(countryId),
                            stateId.isEmpty ? 'null' : json.encode(stateId),
                            nativeId.isEmpty ? 'null' : json.encode(nativeId),
                            workId.isEmpty ? 'null' : json.encode(workId),
                            abroadWorkId.isEmpty
                                ? 'null'
                                : json.encode(abroadWorkId),
                            maritalId.isEmpty ? 'null' : json.encode(maritalId),
                            aboutpartner.text,
                          );
                          listdata.then((value) {
                            setState(() {
                              if (value.status) {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                if (!SharedPrefs.getDashboard) {
                                  SharedPrefs.step3Complete(true);
                                  MyComponents.navPush(context,
                                      (p0) => const ProfilePreviewScreen());
                                }
                              } else {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                if (SharedPrefs.getDashboard ||
                                    SharedPrefs.getStep3Complete) {
                                  if (!mounted) return;
                                  setState(() {
                                    isPageLoading = false;
                                    getStepDetails();
                                  });
                                }
                              }
                            });
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = true;
                          });
                          MyComponents.toast(MyComponents.kErrorMesage);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.baseColor),
                      child: Text(
                        SharedPrefs.getDashboard ? 'Save' : 'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: MyTheme.whiteColor,
                            fontSize: 18,
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                : MyComponents.bottomCircularLoader(
                    MyTheme.whiteColor, MyTheme.baseColor)
            : const SizedBox.shrink(),
      ),
    );
  }

  getPartnerInfo() {
    selectFrom.clear();
    selectTo.clear();
    partnerreligion.clear();
    partnersalary.clear();
    partnermarital.clear();
    partnerphysicalstatus.clear();
    partnerfamilyvalue.clear();
    partnerfamilytype.clear();
    partnerannualincome.clear();
    partnerheight.clear();
    partnerheight2.clear();
    MyComponents.countryData.clear();
    MyComponents.stateData.clear();
    MyComponents.locationData.clear();
    MyComponents.heightData.clear();
    MyComponents.mothertongueData.clear();
    MyComponents.religionData.clear();
    MyComponents.subcasteData.clear();
    MyComponents.educationData.clear();
    MyComponents.occupationData.clear();
    for (int i = 18; i <= 50; i++) {
      selectFrom.add(i.toString());
    }
    for (var element in HardCodeData.salaryData) {
      partnersalary.add(element.textName);
    }
    for (var element in HardCodeData.maritalData) {
      partnermarital.add(element.textName);
    }
    for (var element in HardCodeData.physicalStatusData) {
      partnerphysicalstatus.add(element.textName);
    }
    for (var element in HardCodeData.familyValueData) {
      partnerfamilyvalue.add(element.textName);
    }
    for (var element in HardCodeData.familyTypeData) {
      partnerfamilytype.add(element.textName);
    }
    for (var element in HardCodeData.annualincomedata) {
      partnerannualincome.add(element.textName);
    }
    Future<List<Height>> listHeight = ApiService.getheight();
    Future<List<Mothertongue>> listMotherTongue = ApiService.getmothertongue();
    Future<List<Religion>> listReligion = ApiService.getreligion();
    Future<List<SubCaste>> listSubcaste = ApiService.getsubcaste();
    Future<List<Education>> listEducation = ApiService.geteducation();
    Future<List<Occupation>> listOccupation = ApiService.getoccupation();
    Future<List<Country>> listCountry = ApiService.getcountry();
    Future<List<States>> listState = ApiService.getstates();
    Future<List<Location>> listLocation = ApiService.getlocation();
    MyComponents.casteData.clear();
    Future<List<Caste>> listCaste = ApiService.getcaste();
    listCaste.then((castevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.casteData.addAll(castevalue);
      });
    });
    listCountry.then((countryvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.countryData.addAll(countryvalue);
      });
    });
    listState.then((statevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.stateData.addAll(statevalue);
      });
    });
    listLocation.then((locationvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.locationData.addAll(locationvalue);
      });
    });
    listHeight.then((heightvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.heightData.addAll(heightvalue);
        for (var value in MyComponents.heightData) {
          partnerheight.add(value.name);
          partnerheight2.add(value.name);
        }
      });
    });
    listMotherTongue.then((mothertonguevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.mothertongueData.addAll(mothertonguevalue);
      });
    });
    listReligion.then((religionvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.religionData.addAll(religionvalue);
        for (var value in MyComponents.religionData) {
          partnerreligion.add(value.name);
        }
      });
    });
    listSubcaste.then((subcastevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.subcasteData.addAll(subcastevalue);
      });
    });
    listEducation.then((educationvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.educationData.addAll(educationvalue);
      });
    });
    listOccupation.then((occupationvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.occupationData.addAll(occupationvalue);
      });
      if (SharedPrefs.getDashboard ||
          SharedPrefs.getStep3Complete ||
          widget.isProfileCreatedbyAdmin == '1') {
        getStepDetails();
      }
    });

    if (SharedPrefs.getDashboard ||
        SharedPrefs.getStep3Complete ||
        widget.isProfileCreatedbyAdmin == '1') {
      if (!mounted) return;
      setState(() {
        isPageLoading = false;
      });
    }
  }

  getStepDetails() {
    Future<MyProfileData> profileData = ApiService.postprofilelist();
    profileData.then((value1) {
      if (!mounted) return;
      setState(() {
        if (value1.message[0].partnerPreferencesFromAge.toString().isNotEmpty) {
          selectedpartage1 = value1.message[0].partnerPreferencesFromAge;
        } else {
          selectedpartage1 = 'From';
        }
        if (value1.message[0].partnerPreferencesToAge.toString().isNotEmpty) {
          selectedpartage2 = value1.message[0].partnerPreferencesToAge;
        } else {
          selectedpartage2 = 'To';
        }
        selectedpartheightId1 = value1.message[0].partnerPreferencesFromHeight;
        selectedpartheightId2 = value1.message[0].partnerPreferencesToHeight;
        selectedpartheight1 =
            getHeight1(value1.message[0].partnerPreferencesFromHeight).isEmpty
                ? 'From'
                : getHeight1(value1.message[0].partnerPreferencesFromHeight);
        selectedpartheight2 =
            getHeight2(value1.message[0].partnerPreferencesToHeight).isEmpty
                ? 'To'
                : getHeight2(value1.message[0].partnerPreferencesToHeight);
        selectedpartPhysicalstatus = getPhysicalstatus(
            value1.message[0].partnerPreferencesPhysicalStatus);
        selectedpartfamilytypes = getFamilyTypes(
                    value1.message[0].partnerPreferencesFamilyType)
                .isEmpty
            ? 'Select the Family Type'
            : getFamilyTypes(value1.message[0].partnerPreferencesFamilyType);
        getMotherTongue(value1.message[0].partnerPreferencesMotherTongues);
        selectedpartannualincome = getAnnualIncome(
                    value1.message[0].partnerPreferencesAnnualIncome)
                .isEmpty
            ? 'Select the Annual Income'
            : getAnnualIncome(value1.message[0].partnerPreferencesAnnualIncome);
        selectedpartreligions =
            getReligion(value1.message[0].partnerPreferencesReligionId);
        getSubCaste(value1.message[0].partnerPreferencesSubCastes,
            value1.message[0].partnerPreferencesIsCasteNoBar);
        getEducation(value1.message[0].partnerPreferencesEducations);
        getOccupations(value1.message[0].partnerPreferencesOccupations);
        getCountries(value1.message[0].partnerPreferencesCountries);
        getStates(value1.message[0].partnerPreferencesStates);
        getNativePlaces(value1.message[0].partnerPreferencesNativePlaces);
        getWorkPlaces(value1.message[0].partnerPreferencesWrkLocations);
        getWorkAbPlaces(value1.message[0].partnerPreferencesWrkLocations,
            value1.message[0].partnerPreferencesWrkAbrLocations);
        getMaritalStatus(value1.message[0].partnerPreferencesMaritalStatuses);
        if (value1.message[0].partnerPreferencesAboutPartner
            .toString()
            .isNotEmpty) {
          aboutpartner.text = value1.message[0].partnerPreferencesAboutPartner;
          isAboutPartner = false;
        } else {
          isAboutPartner = true;
        }
        isPageLoading = true;
      });
    });
  }

  String getHeight1(String partnerPreferencesFromHeight) {
    String data = '';
    for (var i = 0; i < MyComponents.heightData.length; i++) {
      if (MyComponents.heightData[i].id == partnerPreferencesFromHeight) {
        data = MyComponents.heightData[i].name;
      }
    }
    return data;
  }

  String getHeight2(String partnerPreferencesToHeight) {
    String data = '';
    for (var i = 0; i < MyComponents.heightData.length; i++) {
      if (MyComponents.heightData[i].id == partnerPreferencesToHeight) {
        data = MyComponents.heightData[i].name;
      }
    }
    return data;
  }

  String getPhysicalstatus(String partnerPreferencesPhysicalStatus) {
    String data = '';
    for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
      if (HardCodeData.physicalStatusData[i].id ==
          partnerPreferencesPhysicalStatus) {
        data = HardCodeData.physicalStatusData[i].textName;
        partphysicalStatus = HardCodeData.physicalStatusData[i].id;
      }
    }
    return data;
  }

  String getFamilyTypes(String partnerPreferencesFamilyType) {
    String data = '';
    for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
      if (HardCodeData.familyTypeData[i].id == partnerPreferencesFamilyType) {
        data = HardCodeData.familyTypeData[i].textName;
        partfamilyType = HardCodeData.familyTypeData[i].id;
      }
    }
    return data;
  }

  String getAnnualIncome(String partnerPreferencesAnnualIncome) {
    String data = '';
    for (var i = 0; i < HardCodeData.annualincomedata.length; i++) {
      if (HardCodeData.annualincomedata[i].id ==
          partnerPreferencesAnnualIncome) {
        data = HardCodeData.annualincomedata[i].textName;
        partannualIncome = HardCodeData.annualincomedata[i].id;
      }
    }
    return data;
  }

  String getReligion(String partnerPreferencesReligionId) {
    String data = '';
    for (var i = 0; i < MyComponents.religionData.length; i++) {
      if (MyComponents.religionData[i].id == partnerPreferencesReligionId) {
        data = MyComponents.religionData[i].name;
        partreligionId = MyComponents.religionData[i].id;
      }
    }
    return data;
  }

  getMotherData() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.mothertongueData) {
      items.add(element.name);
    }
    return items;
  }

  getCasteData() {
    List<String> items = [];
    items.add('All Chettiyar subcaste invited');
    for (var element in MyComponents.subcasteData) {
      items.add(element.subCasteName);
    }
    return items;
  }

  getEducationData() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.educationData) {
      items.add(element.name);
    }
    return items;
  }

  getOccupationData() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.occupationData) {
      items.add(element.occupationName);
    }
    return items;
  }

  getCountryData() {
    List<String> items = [];
    items.add('Any');
    items.add('India');
    for (var element in MyComponents.countryData) {
      items.add(element.countryText);
    }
    return items;
  }

  getStateData() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.stateData) {
      items.add(element.stateName);
    }
    return items;
  }

  getNativeData() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.locationData) {
      items.add(element.districtName);
    }
    return items;
  }

  getMaritalData() {
    List<String> items = [];
    for (var element in HardCodeData.maritalData) {
      items.add(element.textName);
    }
    return items;
  }

  getWorkLocation() {
    List<String> items = [];
    items.add('Any');
    items.add('Working Abroad');
    for (var element in MyComponents.stateData) {
      items.add(element.stateName);
    }
    return items;
  }

  getWorkABLocation() {
    List<String> items = [];
    items.add('Any');
    for (var element in MyComponents.countryData) {
      items.add(element.countryText);
    }
    return items;
  }

  getMotherTongue(String partnerPreferencesMotherTongues) {
    selectedmothertongue.clear();
    motherTongueId.clear();
    if (partnerPreferencesMotherTongues != '[]' &&
        partnerPreferencesMotherTongues != 'null' &&
        partnerPreferencesMotherTongues.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesMotherTongues)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '11') {
          selectedmothertongue.add('Any');
          motherTongueId.add('11');
          isMotherTongue = false;
        } else {
          for (var i = 0; i < dataList.length; i++) {
            for (var element2 in MyComponents.mothertongueData) {
              if (dataList[i] == element2.id) {
                selectedmothertongue.add(element2.name);
                motherTongueId.add(element2.id);
                isMotherTongue = false;
              }
            }
          }
        }
      }
    }
  }

  getSubCaste(String partnerPreferencesSubCastes,
      String partnerPreferencesIsCasteNoBar) {
    selectedcaste.clear();
    denominationId.clear();
    if (partnerPreferencesIsCasteNoBar == '1') {
      selectedcaste.add('All Chettiyar Subcaste Invited');
      denominationId.add('125');
      isNoCasteData = '1';
      isDenomination = false;
    } else if (partnerPreferencesIsCasteNoBar == '0') {
      if (partnerPreferencesSubCastes != '[]' &&
          partnerPreferencesSubCastes != 'null' &&
          partnerPreferencesSubCastes.isNotEmpty) {
        List<String> dataList = List<String>.from(json
            .decode(partnerPreferencesSubCastes)
            .map((e) => e.toString())
            .toList());
        if (dataList.isNotEmpty) {
          isNoCasteData = '0';
          for (var element1 in dataList) {
            for (var element2 in MyComponents.subcasteData) {
              if (element1 == element2.subCasteId) {
                selectedcaste.add(element2.subCasteName);
                denominationId.add(element2.subCasteId);
                isDenomination = false;
              }
            }
          }
        }
      }
    }
  }

  getEducation(String partnerPreferencesEducations) {
    selectededucation.clear();
    educationId.clear();
    if (partnerPreferencesEducations != '[]' &&
        partnerPreferencesEducations != 'null' &&
        partnerPreferencesEducations.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesEducations)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '187') {
          selectededucation.add('Any');
          educationId.add('187');
          isEducation = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.educationData) {
              if (element1 == element2.id) {
                selectededucation.add(element2.name);
                educationId.add(element2.id);
                isEducation = false;
              }
            }
          }
        }
      }
    }
  }

  getOccupations(String partnerPreferencesOccupations) {
    selectedoccupation.clear();
    occupationId.clear();
    if (partnerPreferencesOccupations != '[]' &&
        partnerPreferencesOccupations != 'null' &&
        partnerPreferencesOccupations.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesOccupations)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '130') {
          selectedoccupation.add('Any');
          occupationId.add('130');
          isOccupation = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.occupationData) {
              if (element1 == element2.occupationId) {
                selectedoccupation.add(element2.occupationName);
                occupationId.add(element2.occupationId);
                isOccupation = false;
              }
            }
          }
        }
      }
    }
  }

  getCountries(String partnerPreferencesCountries) {
    selectedcountry.clear();
    countryId.clear();
    if (partnerPreferencesCountries != '[]' &&
        partnerPreferencesCountries != 'null' &&
        partnerPreferencesCountries.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesCountries)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '209') {
          selectedcountry.add('Any');
          countryId.add('209');
          isCountry = false;
          isVisibleState = false;
          isVisibleCity = false;
        } else if (dataList[0] == '85') {
          selectedcountry.add('India');
          countryId.add('85');
          isCountry = false;
          isVisibleState = true;
          isVisibleCity = true;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.countryData) {
              if (element1 == element2.countryId) {
                selectedcountry.add(element2.countryText);
                countryId.add(element2.countryId);
                isCountry = false;
                isVisibleState = true;
                isVisibleCity = true;
              }
            }
          }
        }
      }
    }
  }

  getStates(String partnerPreferencesState) {
    selectedstate.clear();
    stateId.clear();
    if (partnerPreferencesState != '[]' &&
        partnerPreferencesState != 'null' &&
        partnerPreferencesState.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesState)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '39') {
          selectedstate.add('Any');
          stateId.add('39');
          isState = false;
          isVisibleCity = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.stateData) {
              if (element1 == element2.stateId) {
                selectedstate.add(element2.stateName);
                stateId.add(element2.stateId);
                isState = false;
                isVisibleCity = true;
              }
            }
          }
          for (var element in MyComponents.locationData) {
            if (element.stateId == stateId[0]) {
              partnerLocation
                  .add('${element.districtName},${selectedstate[0]}');
            }
          }
        }
      }
    }
  }

  getNativePlaces(String partnerPreferencesNativePlaces) {
    selectedplace.clear();
    nativeId.clear();
    if (partnerPreferencesNativePlaces != '[]' &&
        partnerPreferencesNativePlaces != 'null' &&
        partnerPreferencesNativePlaces.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesNativePlaces)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '736') {
          selectedplace.add('Any');
          nativeId.add('736');
          isNativePlace = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.locationData) {
              if (element1 == element2.districtId) {
                for (var element3 in MyComponents.stateData) {
                  if (element2.stateId == element3.stateId) {
                    selectedplace
                        .add('${element2.districtName},${element3.stateName}');
                  }
                }
                nativeId.add(element2.districtId);
                isNativePlace = false;
              }
            }
          }
        }
      }
    }
  }

  getWorkPlaces(String partnerPreferencesWorkPlaces) {
    selectedwork.clear();
    workId.clear();
    partnerworkAbLocation.clear();
    if (partnerPreferencesWorkPlaces != '[]' &&
        partnerPreferencesWorkPlaces != 'null' &&
        partnerPreferencesWorkPlaces.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesWorkPlaces)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == '50') {
          selectedwork.add('Any');
          workId.add('50');
          isWorkLocation = false;
          isVisibleABLocation = false;
        } else if (dataList[0] == '999') {
          selectedwork.add('Working Abroad');
          workId.add('999');
          isWorkLocation = false;
          partnerworkAbLocation.add('Any');
          for (var element in MyComponents.countryData) {
            partnerworkAbLocation.add(element.countryText);
          }
          isVisibleABLocation = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in MyComponents.stateData) {
              if (element1 == element2.stateId) {
                selectedwork.add(element2.stateName);
                workId.add(element2.stateId);
                isWorkLocation = false;
                isVisibleABLocation = true;
              }
            }
          }
          partnerworkAbLocation.add('Any');
          for (var element in MyComponents.locationData) {
            if (workId[0] == element.stateId) {
              partnerworkAbLocation
                  .add('${element.districtName}, ${selectedwork[0]}');
            }
          }
        }
      } else {
        isWorkLocation = false;
        isVisibleABLocation = false;
      }
    }
  }

  getWorkAbPlaces(String partnerPreferencesWorkPlaces,
      String partnerPreferencesWorkAbPlaces) {
    selectedAbroadWork.clear();
    abroadWorkId.clear();
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
          selectedAbroadWork.add('Any');
          abroadWorkId.add('210');
          isWorkAbLocation = false;
          isVisibleABLocation = true;
        } else if (dataList[0] == '999' && dataList1[0] != '210') {
          for (var element1 in dataList1) {
            for (var element2 in MyComponents.countryData) {
              if (element1 == element2.countryId) {
                selectedAbroadWork.add(element2.countryText);
                abroadWorkId.add(element2.countryId);
                isWorkAbLocation = false;
                isVisibleABLocation = true;
              }
            }
          }
        } else {
          for (var element1 in dataList1) {
            for (var element2 in MyComponents.locationData) {
              if (element1 == element2.districtId) {
                for (var element3 in MyComponents.stateData) {
                  if (element2.stateId == element3.stateId) {
                    selectedAbroadWork
                        .add('${element2.districtName},${element3.stateName}');
                    abroadWorkId.add(element2.districtId);
                    isWorkAbLocation = false;
                    isVisibleABLocation = true;
                  }
                }
              }
            }
          }
        }
      } else {
        isWorkAbLocation = true;
        isVisibleABLocation = false;
      }
    }
  }

  getMaritalStatus(String partnerPreferencesMartialStatus) {
    selectedmarital.clear();
    maritalId.clear();
    if (partnerPreferencesMartialStatus != '[]' &&
        partnerPreferencesMartialStatus != 'null' &&
        partnerPreferencesMartialStatus.isNotEmpty) {
      List<String> dataList = List<String>.from(json
          .decode(partnerPreferencesMartialStatus)
          .map((e) => e.toString())
          .toList());
      if (dataList.isNotEmpty) {
        if (dataList[0] == 'A') {
          selectedmarital.add('Any');
          maritalId.add('A');
          isMaritalStatus = false;
        } else {
          for (var element1 in dataList) {
            for (var element2 in HardCodeData.maritalData) {
              if (element1.contains(element2.id)) {
                selectedmarital.add(element2.textName);
                maritalId.add(element2.id);
                isMaritalStatus = false;
              }
            }
          }
        }
      }
    }
  }
}
