import 'dart:convert';

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
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/invoice_history_screen.dart';

class ProfilePreviewScreen extends StatefulWidget {
  const ProfilePreviewScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePreviewScreen> createState() => _ProfilePreviewScreenState();
}

class _ProfilePreviewScreenState extends State<ProfilePreviewScreen> {
  bool isLoading = true, isGeneratedLoading = false, isPageLoading = false;
  String uploadHoroscope = '',
      imageUser = '',
      setLocationData = 'Specify the Location *',
      setLocationData2 = 'Specify the Location';
  List<MyProfileMessage> profiledata = [];
  List<String> getMotherData = [],
      getCastesData = [],
      getEducationData = [],
      getOccupationData = [],
      getCountriesData = [],
      getStatesData = [],
      getPlacesData = [],
      getwrkLocationData = [],
      getwrkAbLocationData = [],
      getMaritalData = [];

  @override
  void initState() {
    super.initState();
    getStepData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Profile Preview', true, [], MyTheme.whiteColor),
      body: isPageLoading
          ? SingleChildScrollView(
              child: Column(children: [
                ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(
                      'Basic Information',
                      style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: MyTheme.baseColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400),
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    children: [
                      imageUser.isEmpty
                          ? InkWell(
                              onTap: () {
                                MyComponents.showDialogPreview(
                                    context,
                                    MyComponents.kImageAssets,
                                    MyComponents.profilePicture);
                              },
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: MyTheme.transparent,
                                backgroundImage:
                                    AssetImage(MyComponents.profilePicture),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                MyComponents.showDialogPreview(context,
                                    MyComponents.kImageNetwork, imageUser);
                              },
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: MyTheme.transparent,
                                backgroundImage: NetworkImage(imageUser),
                              ),
                            ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(top: 10.0, bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Profile created by *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  profiledata[0].createdBy.isEmpty
                                      ? ''
                                      : '${profiledata[0].createdBy.substring(0, 1).toUpperCase()}'
                                          '${profiledata[0].createdBy.substring(1, profiledata[0].createdBy.length)}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Initial/Name/Surname *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getUserName(
                                      profiledata[0].initialName,
                                      profiledata[0].userName,
                                      profiledata[0].surName),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Gender *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getProfilegen(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Date of Birth *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${MyComponents.formattedDateString(profiledata[0].dateOfBirth, 'dd-MM-yyyy')}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Marital Status *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getMarital(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Physical Status *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getPhysical(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Mother Tongue *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getMotherTongue(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Religion *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getReligion(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Caste *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getCasteData(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Sub Caste *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getSubcaste(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Job Type *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getJobType(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Profession *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getProfession(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Company *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].companyName}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Salary *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getSalary(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Work Location *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getWorkLocation(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  setLocationData,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getAbroadLocation(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Higher Education *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getEducationText(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Nationality *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getCountryData(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Native State *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getStateData(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Native District *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getDistrictData(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Height *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getHeight(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Weight',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].weight} Kg',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Family Values',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getFamilyValue(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Family Type',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getFamilyType(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Father Name *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].fatherName}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Mother Name *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].motherName}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Sibilings *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].sibiling}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Email *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].email}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
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
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400),
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Birth Place *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  profiledata[0].birthPlace,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Birth Date *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${MyComponents.formattedDateString(profiledata[0].dateOfBirth, 'dd-MM-yyyy')}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Birth Time *',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  '${profiledata[0].birthTime} hrs',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Gothram',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  profiledata[0].gothram,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Raasi/Zodiac',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getZodiac(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Nakshathram/Star',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  getStar(0),
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Dosham',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  profiledata[0].dosham,
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
                                ),
                              ),
                            ]),
                      ),
                      uploadHoroscope.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: TextButton(
                                onPressed: () {
                                  if (uploadHoroscope.isNotEmpty) {
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
                                },
                                style: TextButton.styleFrom(
                                    side: BorderSide(color: MyTheme.redColor)),
                                child: FittedBox(
                                  child: Text(
                                    'View uploaded Horoscope',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: TextButton(
                          onPressed: () {
                            showGeneratedLang(context);
                          },
                          style: TextButton.styleFrom(
                              side: BorderSide(color: MyTheme.redColor)),
                          child: FittedBox(
                            child: Text(
                              'View Generated Horoscope',
                              style: GoogleFonts.inter(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.4,
                                child: Text(
                                  'Primary Horoscope',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Text(
                                ': ',
                                style: GoogleFonts.inter(
                                    fontSize: 18,
                                    color: MyTheme.blackColor,
                                    letterSpacing: 0.4),
                              ),
                              SizedBox(
                                width: MyComponents.widthSize(context) / 2.0,
                                child: Text(
                                  profiledata[0].primaryHoroscope == 'G'
                                      ? 'Generated Horoscope'
                                      : 'Uploaded Horoscope',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      color: MyTheme.blackColor,
                                      letterSpacing: 0.4),
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
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w400),
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    children: [
                      profiledata[0].partnerPreferencesFromAge.isEmpty &&
                              profiledata[0].partnerPreferencesToAge.isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Age *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        '${profiledata[0].partnerPreferencesFromAge} to ${profiledata[0].partnerPreferencesToAge}',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getHeight1(0).isEmpty && getHeight2(0).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Height *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        '${getHeight1(0)} to ${getHeight2(0)}',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getPhysicalStatus(0).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Physical Status *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getPhysicalStatus(0),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getFamilyType2(0).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Family Type',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getFamilyType2(0),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getMotherTongueData(profiledata[0]
                                  .partnerPreferencesMotherTongues)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Mother Tongue *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getMotherTongueData(profiledata[0]
                                            .partnerPreferencesMotherTongues),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getAnnualIncome(0).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Annual Income',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getAnnualIncome(0),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getReligionData(0).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Religion *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getReligionData(0),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getSubCaste(profiledata[0].partnerPreferencesSubCastes,
                                  profiledata[0].partnerPreferencesIsCasteNoBar)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Caste / Denomination ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getSubCaste(
                                            profiledata[0]
                                                .partnerPreferencesSubCastes,
                                            profiledata[0]
                                                .partnerPreferencesIsCasteNoBar),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getEducation(profiledata[0].partnerPreferencesEducations)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Education ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getEducation(profiledata[0]
                                            .partnerPreferencesEducations),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getOccupations(
                                  profiledata[0].partnerPreferencesOccupations)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Occupation ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getOccupations(profiledata[0]
                                            .partnerPreferencesOccupations),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getCountries(profiledata[0].partnerPreferencesCountries)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Nationality ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getCountries(profiledata[0]
                                            .partnerPreferencesCountries),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getStates(profiledata[0].partnerPreferencesStates).isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Native State ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getStates(profiledata[0]
                                            .partnerPreferencesStates),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getNativePlaces(
                                  profiledata[0].partnerPreferencesNativePlaces)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      height: kToolbarHeight - 26.0,
                                      child: Text(
                                        'Native Place ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getNativePlaces(profiledata[0]
                                            .partnerPreferencesNativePlaces),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getWorkPlaces(
                                  profiledata[0].partnerPreferencesWrkLocations)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Work Location ',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getWorkPlaces(profiledata[0]
                                            .partnerPreferencesWrkLocations),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getWorkAbPlaces(
                                  profiledata[0].partnerPreferencesWrkLocations,
                                  profiledata[0]
                                      .partnerPreferencesWrkAbrLocations)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        setLocationData2,
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getWorkAbPlaces(
                                            profiledata[0]
                                                .partnerPreferencesWrkLocations,
                                            profiledata[0]
                                                .partnerPreferencesWrkAbrLocations),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      getMaritalStatus(profiledata[0]
                                  .partnerPreferencesMaritalStatuses)
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'Marital Status *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        getMaritalStatus(profiledata[0]
                                            .partnerPreferencesMaritalStatuses),
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                      profiledata[0]
                              .partnerPreferencesAboutPartner
                              .toString()
                              .isEmpty
                          ? const SizedBox.shrink()
                          : Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.4,
                                      child: Text(
                                        'About My Partner *',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Text(
                                      ': ',
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                    SizedBox(
                                      width:
                                          MyComponents.widthSize(context) / 2.0,
                                      child: Text(
                                        '${profiledata[0].partnerPreferencesAboutPartner}',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4),
                                      ),
                                    ),
                                  ]),
                            ),
                    ]),
              ]),
            )
          : MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor),
      bottomNavigationBar: isPageLoading
          ? isLoading
              ? SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight - 6.0,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      try {
                        Future<BasicStep4> values =
                            ApiService.postProfileStepComplete();
                        values.then((value) {
                          if (value.status) {
                            ApiService.postprofilelist().then((value1) {
                              SharedPrefs.userGender(value1.message[0].gender);
                              SharedPrefs.profileSubscribeId(
                                  value1.message[0].subscribedPremiumId);
                              if (value1.message[0].isVerified == '1') {
                                SharedPrefs.verified(true);
                              } else {
                                SharedPrefs.verified(false);
                              }
                              setState(() {
                                isLoading = true;
                              });
                              SharedPrefs.step1Complete(true);
                              SharedPrefs.step2Complete(true);
                              SharedPrefs.step3Complete(true);
                              SharedPrefs.step4Complete(true);

                              successDialog(context);
                            });
                          } else {
                            setState(() {
                              isLoading = true;
                            });
                            MyComponents.toast(value.message);
                          }
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = true;
                        });
                        MyComponents.toast(MyComponents.kErrorMesage);
                      }
                    },
                    child: Text(
                      'Save & Continue',
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
    );
  }

  successDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              MyComponents.navPop(context);
              MyComponents.navPushAndRemoveUntil(
                  context, (p0) => const LoginScreen(), false);
              return Future.value(true);
            },
            child: Dialog(
              insetPadding: const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(MyComponents.sucessPicture,
                            width: kToolbarHeight + 84.0,
                            height: kToolbarHeight + 84.0),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
                        child: Text(
                          'Your Profile has been Successfully Created!',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: MyTheme.primaryColor,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: Text(
                          'Thank you for choosing MyShubaMuhurtham to find '
                          'your perfect match. You will be receiving a '
                          'verification call shortly from our team. '
                          'After successful verification your membership will be '
                          'activated. Please check your sms inbox after '
                          'verification. Good Luck in Finding your Forever One!',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          MyComponents.navPop(context);
                          MyComponents.navPushAndRemoveUntil(
                              context,
                              (p0) => const MainScreen(
                                  isVisible: true, pageIndex: 0),
                              false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Go to Home',
                            style: GoogleFonts.inter(fontSize: 18),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          );
        });
  }

  showGeneratedLang(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState4) {
            return Dialog(
              child: Container(
                width: MyComponents.widthSize(context),
                height: kToolbarHeight + 124.0,
                margin: const EdgeInsets.all(10.0),
                child: isGeneratedLoading
                    ? MyComponents.delayLoader(context, 'Loading...')
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                            ElevatedButton(
                              onPressed: () {
                                generateHoroscope(setState4, 'ENG');
                              },
                              child: Text(
                                'English',
                                style: GoogleFonts.inter(
                                    fontSize: 18.0, color: MyTheme.whiteColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                generateHoroscope(setState4, 'TAM');
                              },
                              child: Text(
                                'Tamil',
                                style: GoogleFonts.inter(
                                    fontSize: 18.0, color: MyTheme.whiteColor),
                              ),
                            ),
                          ]),
              ),
            );
          });
        });
  }

  generateHoroscope(StateSetter setState4, String language) {
    setState4(() {
      isGeneratedLoading = true;
    });
    try {
      ApiService.postgeneratehoroscope(SharedPrefs.getUserId, language)
          .then((value) {
        setState4(() {
          isGeneratedLoading = false;
          MyComponents.navPop(context);
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

  getStepData() {
    MyComponents.countryData.clear();
    MyComponents.stateData.clear();
    MyComponents.locationData.clear();
    MyComponents.heightData.clear();
    MyComponents.mothertongueData.clear();
    MyComponents.religionData.clear();
    MyComponents.casteData.clear();
    MyComponents.subcasteData.clear();
    MyComponents.educationData.clear();
    MyComponents.occupationData.clear();
    Future<List<Country>> listCountry = ApiService.getcountry();
    Future<List<States>> listState = ApiService.getstates();
    Future<List<Location>> listLocation = ApiService.getlocation();
    Future<List<Height>> listHeight = ApiService.getheight();
    Future<List<Mothertongue>> listMotherTongue = ApiService.getmothertongue();
    Future<List<Religion>> listReligion = ApiService.getreligion();
    Future<List<Caste>> listCaste = ApiService.getcaste();
    Future<List<SubCaste>> listSubcaste = ApiService.getsubcaste();
    Future<List<Education>> listEducation = ApiService.geteducation();
    Future<List<Occupation>> listOccupation = ApiService.getoccupation();
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
      });
    });
    listCaste.then((castevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.casteData.addAll(castevalue);
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
    });
    ApiService.postprofilelist().then((value) {
      if (!mounted) return;
      setState(() {
        profiledata.addAll(value.message);
        imageUser = profiledata[0].avatar.toString().isNotEmpty
            ? '${MyComponents.imageBaseUrl}${profiledata[0].hasEncode}/${value.message[0].avatar}'
            : '';
        uploadHoroscope = value.message[0].uploadedHoroscope
                .toString()
                .isNotEmpty
            ? '${MyComponents.horoBaseUrl}${profiledata[0].hasEncode}/${value.message[0].uploadedHoroscope}'
            : '';
        isPageLoading = true;
      });
    });
  }

  String getProfilegen(int index) {
    String data = '';
    setState(() {
      if (profiledata[index].gender.isNotEmpty) {
        if (profiledata[index].gender == 'M') {
          data = 'Male';
        } else if (profiledata[index].gender == 'F') {
          data = 'Female';
        }
      }
    });
    return data;
  }

  String getZodiac(int index) {
    String zodiac = '';
    if (profiledata[index].zodiac.isNotEmpty) {
      for (var element in HardCodeData.zodiaclist) {
        if (element.id == profiledata[index].zodiac) {
          zodiac = element.textName;
        }
      }
    }
    return zodiac;
  }

  String getStar(int index) {
    String star = '';
    if (profiledata[index].star.isNotEmpty) {
      for (var element in HardCodeData.startypedata) {
        if (element.id == profiledata[index].star) {
          star = element.textName;
        }
      }
    }
    return star;
  }

  String getProfession(int index) {
    String occupationName = '';
    if (profiledata[index].professionId.isNotEmpty) {
      for (var element in MyComponents.occupationData) {
        if (element.occupationId == profiledata[index].professionId) {
          occupationName = element.occupationName;
        }
      }
    }

    return occupationName;
  }

  String getHeight(int index) {
    String data = '';
    if (profiledata[index].height.isNotEmpty) {
      for (var i = 0; i < MyComponents.heightData.length; i++) {
        if (MyComponents.heightData[i].id == profiledata[index].height) {
          data = MyComponents.heightData[i].name;
        }
      }
    }
    return data;
  }

  String getMotherTongue(int index) {
    String data = '';
    if (profiledata[index].motherTongueId.isNotEmpty) {
      for (var i = 0; i < MyComponents.mothertongueData.length; i++) {
        if (MyComponents.mothertongueData[i].id ==
            profiledata[index].motherTongueId) {
          data = MyComponents.mothertongueData[i].name;
        }
      }
    }
    return data;
  }

  String getPhysical(int index) {
    String data = '';
    if (profiledata[index].physicalStatus.isNotEmpty) {
      for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
        if (HardCodeData.physicalStatusData[i].id ==
            profiledata[index].physicalStatus) {
          data = HardCodeData.physicalStatusData[i].textName;
        }
      }
    }
    return data;
  }

  String getPhysicalStatus(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesPhysicalStatus.isNotEmpty) {
      for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
        if (HardCodeData.physicalStatusData[i].id ==
            profiledata[index].partnerPreferencesPhysicalStatus) {
          data = HardCodeData.physicalStatusData[i].textName;
        }
      }
    }
    return data;
  }

  String getReligion(int index) {
    String data = '';
    if (profiledata[index].religionId.isNotEmpty) {
      for (var i = 0; i < MyComponents.religionData.length; i++) {
        if (MyComponents.religionData[i].id == profiledata[index].religionId) {
          data = MyComponents.religionData[i].name;
        }
      }
    }
    return data;
  }

  String getCasteData(int index) {
    String data = '';
    if (profiledata[index].casteId.isNotEmpty) {
      for (var i = 0; i < MyComponents.casteData.length; i++) {
        if (MyComponents.casteData[i].casteId == profiledata[index].casteId) {
          data = MyComponents.casteData[i].casteName;
        }
      }
    }
    return data;
  }

  String getSubcaste(int index) {
    String data = '';
    if (profiledata[index].subCasteId.isNotEmpty) {
      for (var i = 0; i < MyComponents.subcasteData.length; i++) {
        if (MyComponents.subcasteData[i].subCasteId ==
            profiledata[index].subCasteId) {
          data = MyComponents.subcasteData[i].subCasteName;
        }
      }
    }
    return data;
  }

  String getMarital(int index) {
    String data = '';
    if (profiledata[index].maritalStatus.isNotEmpty) {
      for (var i = 0; i < HardCodeData.maritalData.length; i++) {
        if (HardCodeData.maritalData[i].id ==
            profiledata[index].maritalStatus) {
          data = HardCodeData.maritalData[i].textName;
        }
      }
    }
    return data;
  }

  String getSalary(int index) {
    String data = '';
    if (profiledata[index].salary.toString().isNotEmpty) {
      for (var i = 0; i < HardCodeData.salaryData.length; i++) {
        if (HardCodeData.salaryData[i].id == profiledata[index].salary) {
          data = HardCodeData.salaryData[i].textName;
        }
      }
    }
    return data;
  }

  String getJobType(int index) {
    String data = '';
    if (profiledata[index].jobTitle.toString().isNotEmpty) {
      for (var i = 0; i < HardCodeData.jobTypeList.length; i++) {
        if (HardCodeData.jobTypeList[i].id == profiledata[index].jobTitle) {
          data = HardCodeData.jobTypeList[i].textName;
        }
      }
    }
    return data;
  }

  String getCountryData(int index) {
    String data = '';
    if (profiledata[index].countryId.isNotEmpty) {
      for (var i = 0; i < MyComponents.countryData.length; i++) {
        if (profiledata[index].countryId == '85') {
          data = 'India';
        } else if (MyComponents.countryData[i].countryId ==
            profiledata[index].countryId) {
          data = MyComponents.countryData[i].countryText;
        }
      }
    }
    return data;
  }

  String getStateData(int index) {
    String data = '';
    if (profiledata[index].stateId.isNotEmpty) {
      for (var i = 0; i < MyComponents.stateData.length; i++) {
        if (MyComponents.stateData[i].stateId == profiledata[index].stateId) {
          data = MyComponents.stateData[i].stateName;
        }
      }
    }
    return data;
  }

  String getDistrictData(int index) {
    String data = '';
    if (profiledata[index].districtId.isNotEmpty) {
      for (var i = 0; i < MyComponents.locationData.length; i++) {
        if (MyComponents.locationData[i].districtId ==
            profiledata[index].districtId) {
          data =
              '${MyComponents.locationData[i].districtName},${getStateData(0)}';
        }
      }
    }
    return data;
  }

  String getWorkLocation(int index) {
    String data = '';
    if (profiledata[index].wrkLocation.toString().isNotEmpty) {
      for (var i = 0; i < MyComponents.stateData.length; i++) {
        if (profiledata[index].wrkLocation == '999') {
          data = 'Working Abroad';
        } else if (MyComponents.stateData[i].stateId ==
            profiledata[index].wrkLocation) {
          data = MyComponents.stateData[i].stateName;
        }
      }
    }
    return data;
  }

  String getAbroadLocation(int index) {
    String data = '';
    if (profiledata[index].wrkAbrLocation.toString().isNotEmpty) {
      if (profiledata[index].wrkLocation == '999') {
        setLocationData = 'Specify the Country *';
        for (var i = 0; i < MyComponents.countryData.length; i++) {
          if (MyComponents.countryData[i].countryId ==
              profiledata[index].wrkAbrLocation) {
            data = MyComponents.countryData[i].countryText;
          }
        }
      } else {
        setLocationData = 'Specify the Location *';
        for (var i = 0; i < MyComponents.locationData.length; i++) {
          if (MyComponents.locationData[i].districtId ==
              profiledata[index].wrkAbrLocation) {
            data =
                '${MyComponents.locationData[i].districtName},${getStateData2(0)}';
          }
        }
      }
    }
    return data;
  }

  String getStateData2(int index) {
    String data = '';
    if (profiledata[index].stateId.isNotEmpty) {
      for (var i = 0; i < MyComponents.stateData.length; i++) {
        if (MyComponents.stateData[i].stateId ==
            profiledata[index].wrkLocation) {
          data = MyComponents.stateData[i].stateName;
        }
      }
    }
    return data;
  }

  String getEducationText(int index) {
    String data = '';
    if (profiledata[index].educationId.isNotEmpty) {
      for (var i = 0; i < MyComponents.educationData.length; i++) {
        if (MyComponents.educationData[i].id ==
            profiledata[index].educationId) {
          data = MyComponents.educationData[i].name;
        }
      }
    }
    return data;
  }

  String getFamilyValue(int index) {
    String data = '';
    if (profiledata[index].familyValues.isNotEmpty) {
      for (var i = 0; i < HardCodeData.familyValueData.length; i++) {
        if (HardCodeData.familyValueData[i].id ==
            profiledata[index].familyValues) {
          data = HardCodeData.familyValueData[i].textName;
        }
      }
    }
    return data;
  }

  String getFamilyType(int index) {
    String data = '';
    if (profiledata[index].familyType.isNotEmpty) {
      for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
        if (HardCodeData.familyTypeData[i].id ==
            profiledata[index].familyType) {
          data = HardCodeData.familyTypeData[i].textName;
        }
      }
    }
    return data;
  }

  String getHeight1(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesFromHeight.isNotEmpty) {
      for (var i = 0; i < MyComponents.heightData.length; i++) {
        if (MyComponents.heightData[i].id ==
            profiledata[index].partnerPreferencesFromHeight) {
          data = MyComponents.heightData[i].name;
        }
      }
    }
    return data;
  }

  String getHeight2(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesToHeight.isNotEmpty) {
      for (var i = 0; i < MyComponents.heightData.length; i++) {
        if (MyComponents.heightData[i].id ==
            profiledata[index].partnerPreferencesToHeight) {
          data = MyComponents.heightData[i].name;
        }
      }
    }
    return data;
  }

  String getFamilyType2(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesFamilyType.isNotEmpty) {
      for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
        if (HardCodeData.familyTypeData[i].id ==
            profiledata[index].partnerPreferencesFamilyType) {
          data = HardCodeData.familyTypeData[i].textName;
        }
      }
    }
    return data;
  }

  String getAnnualIncome(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesAnnualIncome.isNotEmpty) {
      for (var i = 0; i < HardCodeData.annualincomedata.length; i++) {
        if (HardCodeData.annualincomedata[i].id ==
            profiledata[index].partnerPreferencesAnnualIncome) {
          data = HardCodeData.annualincomedata[i].textName;
        }
      }
    }
    return data;
  }

  String getReligionData(int index) {
    String data = '';
    if (profiledata[index].partnerPreferencesReligionId.isNotEmpty) {
      for (var i = 0; i < MyComponents.religionData.length; i++) {
        if (MyComponents.religionData[i].id ==
            profiledata[index].partnerPreferencesReligionId) {
          data = MyComponents.religionData[i].name;
        }
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
          for (var i = 0; i < dataList.length; i++) {
            for (var element2 in MyComponents.mothertongueData) {
              if (dataList[i] == element2.id) {
                getMotherData.add(element2.name);
              }
            }
          }
        }
      }
    }

    return getMotherData.toList().join(', ').toString();
  }

  String getSubCaste(String partnerPreferencesSubCastes,
      String partnerPreferencesIsCasteNoBar) {
    getCastesData.clear();
    if (partnerPreferencesIsCasteNoBar == '1') {
      getCastesData.add('All Chettiyar Subcaste Invited');
    } else if (partnerPreferencesIsCasteNoBar == '0') {
      if (partnerPreferencesSubCastes != '[]' &&
          partnerPreferencesSubCastes != 'null' &&
          partnerPreferencesSubCastes.isNotEmpty) {
        List<String> dataList = List<String>.from(json
            .decode(partnerPreferencesSubCastes)
            .map((e) => e.toString())
            .toList());
        if (dataList.isNotEmpty) {
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
            for (var element2 in MyComponents.countryData) {
              if (element1 == element2.countryId) {
                getCountriesData.add(element2.countryText);
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
          setLocationData2 = 'Specify the Country';
          for (var element1 in dataList1) {
            for (var element2 in MyComponents.countryData) {
              if (element1 == element2.countryId) {
                getwrkAbLocationData.add(element2.countryText);
              }
            }
          }
        } else {
          setLocationData2 = 'Specify the Location';
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

  String getUserName(String initialName, String userName, String surName) {
    String data;
    data = surName.isNotEmpty
        ? '${profiledata[0].initialName}.${profiledata[0].userName}/${profiledata[0].surName}'
        : '${profiledata[0].initialName}.${profiledata[0].userName}';
    return data;
  }
}
