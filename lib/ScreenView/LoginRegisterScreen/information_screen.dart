import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/email_validator.dart';
import 'package:myshubamuhurtham/HelperClass/mask_textinput_formatter.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/drop_list_class.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/ModelClass/setps_info.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/astro_detail_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/login_register_screen.dart';

TextEditingController referralCode = TextEditingController(),
    initial = TextEditingController(),
    userName = TextEditingController(),
    surName = TextEditingController(),
    companyName = TextEditingController(),
    fatherName = TextEditingController(),
    motherName = TextEditingController(),
    emailAddress = TextEditingController(),
    dateOfbirth = TextEditingController(),
    password = TextEditingController(),
    confirmpassword = TextEditingController();
String selectedinfoCountry = 'Select your Nationality',
    selectedinfoState = 'Select your Native State',
    selectedinfoMotherTongue = 'Select your Mother Tongue',
    selectedinfoReligion = 'Select your Religion',
    selectedinfoCaste = 'Select your Caste',
    selectedinfoSubCaste = 'Select your Sub Caste',
    selectedinfoWork = 'Select your Work Location',
    selectedinfoAbroad = 'Select the Location',
    selectedinfoDistrict = 'Select your Native District,State',
    selectedinfoEducation = 'Select your Higher Education',
    selectedjobtype = 'Select your job type',
    selectedinfoProfession = 'Select your Profession',
    selectedinfoHeight = 'Select your Height',
    selectedinfoMaritalStatus = 'Select your Marital Status',
    selectedinfoSalary = 'Select your Salary',
    selectedinfoFamilytype = 'Select your Family Type',
    selectedinfoPhysicalstatus = 'Select your Physical Status',
    selectedinfoWeight = 'Select your Weight',
    selectedinfoFamilyvalue = 'Select your Family Value',
    selectedinfoSibling = 'Select no of Siblings',
    selectedinfoProfiledby = 'Select Profile created',
    selectedinfoGender = 'Select your Gender',
    selectedDOB = '',
    infopickedFile = '',
    infopickedFileName = '';
File? imageFile;

class InformationScreen extends StatefulWidget {
  final String isProfileCreatedbyAdmin;
  const InformationScreen({Key? key, required this.isProfileCreatedbyAdmin})
      : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  DateTime? currentBackPressed;
  DateTime selectedDate = DateTime.now();
  int isAgree = 1;
  final ImagePicker picker = ImagePicker();
  XFile? pickedFile;
  List<String> infocountry = [];
  List<String> infoworkState = [];
  List<String> infoabroadcountry = [];
  List<String> infostate = [];
  List<String> infolocation = [];
  List<String> infoheight = [];
  List<String> infomothertongue = [];
  List<String> inforeligion = [];
  List<String> infocaste = [];
  List<String> infosubcaste = [];
  List<String> infoeducation = [];
  List<String> infojobtypelist = [];
  List<String> infoprofession = [];
  List<String> infosalary = [];
  List<String> infomarital = [];
  List<String> infofamilyvalue = [];
  List<String> infofamilytype = [];
  List<String> infophysicalstatus = [];
  List<String> infoannualincome = [];
  bool imagePicked = false,
      isPromoCode = true,
      isReferral = true,
      isInitial = true,
      isName = true,
      isDated = true,
      isSurName = true,
      isCompany = true,
      isFather = true,
      isMother = true,
      isEmail = true,
      isPassword = true,
      isPassword2 = true,
      showPassword = false,
      showPassword2 = false,
      isVisibleCompany = true,
      isVisibleAbroad = false,
      isVisibleSc = true,
      isLoading = true,
      isPageLoading = true;
  String profileCreatedBy = '',
      networkImageUrl = '',
      gender = '',
      casteId = '',
      subCasteId = '',
      professionId = '',
      maritalStatus = '',
      physicalStatus = '',
      height = '',
      countryId = '',
      workLocationId = '',
      workAbLocationId = '',
      stateId = '',
      districtId = '',
      motherTongueId = '',
      selectedjobtypeId = '',
      religionId = '',
      familyValues = '',
      familytype = '',
      salary = '',
      educationId = '';
  int i = 0;
  List<PlatformFile>? paths;
  String? directoryPath;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 85),
      lastDate: DateTime(DateTime.now().year + 1),
      keyboardType: TextInputType.datetime,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOfbirth.text = DateFormat('dd/MM/yyyy').format(selectedDate);
        selectedDOB = DateFormat('yyyy-MM-dd').format(selectedDate);
        if (MyComponents.isAdultValidator(dateOfbirth.text, 'dd/MM/yyyy')) {
          isDated = false;
          SharedPrefs.dateOfbirth(dateOfbirth.text);
        } else {
          isDated = true;
          dateOfbirth.clear();
          selectedDOB = '';
          MyComponents.toast(
              'To Register, you should complete 18 years of age.');
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    if (!SharedPrefs.getDashboard && !SharedPrefs.getStep1Complete) {
      if (!SharedPrefs.getpostCallback) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showDisclaimerDialog(context);
        });
      }
    }
    if (widget.isProfileCreatedbyAdmin == '1') {
      SharedPrefs.step1Complete(true);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDisclaimer2Dialog(context);
      });
    }
    getStepData();
  }

  Future<bool> onWillPop() {
    if (SharedPrefs.getDashboard) {
      MyComponents.navPop(context);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressed == null ||
          now.difference(currentBackPressed!) > const Duration(seconds: 2)) {
        currentBackPressed = now;
        MyComponents.toast('Double tap to exit the app');
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MyComponents.appbarWithTitle(
            context, 'Basic Information', true, [], MyTheme.whiteColor),
        resizeToAvoidBottomInset: true,
        body: isPageLoading
            ? SingleChildScrollView(
                child: Column(children: [
                  SharedPrefs.getDashboard
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: MyComponents.widthSize(context) / 2.8,
                          height: kToolbarHeight + 104.0,
                          child: Stack(children: [
                            SharedPrefs.getStep1Complete
                                ? InkWell(
                                    onTap: () {
                                      MyComponents.showDialogPreview(
                                          context,
                                          MyComponents.kImageFile,
                                          imageFile!.path);
                                    },
                                    child: CircleAvatar(
                                      radius: 120,
                                      backgroundColor: MyTheme.transparent,
                                      backgroundImage:
                                          NetworkImage(networkImageUrl),
                                    ),
                                  )
                                : imagePicked
                                    ? InkWell(
                                        onTap: () {
                                          MyComponents.showDialogPreview(
                                              context,
                                              MyComponents.kImageFile,
                                              imageFile!.path);
                                        },
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor: MyTheme.transparent,
                                          backgroundImage:
                                              FileImage(File(imageFile!.path)),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          showDialogPicker(context);
                                        },
                                        child: CircleAvatar(
                                          radius: 120,
                                          backgroundColor:
                                              MyTheme.backgroundBox,
                                          backgroundImage: AssetImage(
                                              MyComponents.profilePicture),
                                        ),
                                      ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: MyTheme.backgroundBox,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialogPicker(context);
                                    },
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: MyTheme.blackColor,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  ' * ',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.redColor, fontSize: 20),
                                ),
                              ),
                            ),
                          ]),
                        ),
                  Visibility(
                    visible: SharedPrefs.getDashboard ? false : true,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Kindly provide referral code, if any',
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
                          margin: const EdgeInsets.all(10.0),
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: isReferral
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                              controller: referralCode,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4),
                              cursorColor: MyTheme.blackColor,
                              decoration: const InputDecoration(
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isReferral = false;
                                  } else {
                                    isReferral = true;
                                  }
                                });
                                if (data.length <= 9) {
                                  ApiService.postRefferalCode(referralCode.text)
                                      .then((value) {
                                    if (!value.status) {
                                      MyComponents.toast(value.message);
                                    }
                                  });
                                }
                              }),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Profile created by',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color:
                              selectedinfoProfiledby == 'Select Profile created'
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: HardCodeData.profileby,
                          selectedItem: selectedinfoProfiledby,
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
                              selectedinfoProfiledby = value!;
                              profileCreatedBy =
                                  selectedinfoProfiledby.toLowerCase();
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
                    width: MyComponents.widthSize(context),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MyComponents.widthSize(context),
                          child: Column(children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Initial',
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
                                            fontSize: 18),
                                      ),
                                    ]),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight - 6.0,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: isInitial
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: TextField(
                                  controller: initial,
                                  keyboardType: TextInputType.text,
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
                                  onChanged: (data) {
                                    setState(() {
                                      if (data.isNotEmpty) {
                                        isInitial = false;
                                      } else {
                                        isInitial = true;
                                      }
                                    });
                                  }),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Name',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isName
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: userName,
                            keyboardType: TextInputType.text,
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
                            onChanged: (data) {
                              setState(() {
                                if (data.isNotEmpty) {
                                  isName = false;
                                } else {
                                  isName = true;
                                }
                              });
                            }),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Surname',
                          style: GoogleFonts.rubik(
                            color: MyTheme.blackColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isSurName
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: surName,
                            keyboardType: TextInputType.text,
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
                            onChanged: (data) {
                              setState(() {
                                if (data.isNotEmpty) {
                                  isSurName = false;
                                } else {
                                  isSurName = true;
                                }
                              });
                            }),
                      )
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Gender',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoGender == 'Select your Gender'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: HardCodeData.gender,
                          selectedItem: selectedinfoGender,
                          enabled: !SharedPrefs.getDashboard,
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
                              selectedinfoGender = value!;
                              gender = selectedinfoGender.substring(0, 1);
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Date of Birth',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 4.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isDated
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: dateOfbirth,
                            keyboardType: TextInputType.number,
                            enabled: !SharedPrefs.getDashboard,
                            style: TextStyle(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                decoration: TextDecoration.none),
                            inputFormatters: [
                              MaskTextInputFormatter(mask: '##/##/####'),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'DD/MM/YYYY',
                              hintStyle: TextStyle(
                                  color: MyTheme.greyColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  decoration: TextDecoration.none),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_month_rounded,
                                    color: MyTheme.greyColor),
                                onPressed: () => selectDate(context),
                              ),
                            ),
                            onChanged: (dateText) {
                              if (dateText.length >= 10) {
                                String dateFormatText =
                                    MyComponents.stringDateFormat(
                                        dateText, 'yyyy-MM-dd');
                                if (!MyComponents.isDateValidator(
                                    dateText, 'dd/MM/yyyy')) {
                                  setState(() {
                                    isDated = true;
                                  });
                                  MyComponents.toast('Invalid Date format.');
                                  return;
                                }
                                if (!MyComponents.isAdultValidator(
                                    dateFormatText, 'yyyy-MM-dd')) {
                                  setState(() {
                                    isDated = true;
                                  });
                                  dateOfbirth.clear();
                                  selectedDOB = '';
                                  MyComponents.toast(
                                      'To Register, you should complete 18 years of age.');
                                  return;
                                }
                                setState(() {
                                  isDated = false;
                                  selectedDOB =
                                      MyComponents.formattedDateString(
                                          dateFormatText, 'yyyy-MM-dd');
                                  debugPrint('DateTime: $selectedDOB');
                                });
                              } else if (dateText.isEmpty) {
                                setState(() {
                                  isDated = true;
                                  dateOfbirth.clear();
                                  selectedDOB = '';
                                });
                              }
                            }),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Marital Status',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoMaritalStatus ==
                                  'Select your Marital Status'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infomarital,
                          selectedItem: selectedinfoMaritalStatus,
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
                              selectedinfoMaritalStatus = value!;
                              maritalStatus = '';
                              for (var element in HardCodeData.maritalData) {
                                if (element.textName
                                    .contains(selectedinfoMaritalStatus)) {
                                  maritalStatus = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Physical Status',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoPhysicalstatus ==
                                  'Select your Physical Status'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infophysicalstatus,
                          selectedItem: selectedinfoPhysicalstatus,
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
                              selectedinfoPhysicalstatus = value!;
                              physicalStatus = '';
                              for (var element
                                  in HardCodeData.physicalStatusData) {
                                if (element.textName
                                    .contains(selectedinfoPhysicalstatus)) {
                                  physicalStatus = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Mother Tongue',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoMotherTongue ==
                                  'Select your Mother Tongue'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infomothertongue,
                          selectedItem: selectedinfoMotherTongue,
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
                              selectedinfoMotherTongue = value!;
                              motherTongueId = '';
                              for (var element
                                  in MyComponents.mothertongueData) {
                                if (element.name
                                    .contains(selectedinfoMotherTongue)) {
                                  motherTongueId = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Religion',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoReligion == 'Select your Religion'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: inforeligion,
                          selectedItem: selectedinfoReligion,
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
                              selectedinfoReligion = value!;
                              religionId = '';
                              for (var element in MyComponents.religionData) {
                                if (element.name
                                    .contains(selectedinfoReligion)) {
                                  religionId = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Caste',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoCaste == 'Select your Caste'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infocaste,
                          selectedItem: selectedinfoCaste,
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
                              selectedinfoCaste = value!;
                              casteId = '';
                              for (var element in MyComponents.casteData) {
                                if (element.casteName
                                    .contains(selectedinfoCaste)) {
                                  casteId = element.casteId;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'SubCaste',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoSubCaste == 'Select your Sub Caste'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infosubcaste,
                          selectedItem: selectedinfoSubCaste,
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
                              selectedinfoSubCaste = value!;
                              subCasteId = '';
                              for (var element in MyComponents.subcasteData) {
                                if (element.subCasteName
                                    .contains(selectedinfoSubCaste)) {
                                  subCasteId = element.subCasteId;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Job Type',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedjobtype == 'Select your job type'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infojobtypelist,
                          selectedItem: selectedjobtype,
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
                              selectedjobtype = value!;
                              selectedjobtypeId = '';
                              for (var element in HardCodeData.jobTypeList) {
                                if (element.textName
                                    .contains(selectedjobtype)) {
                                  selectedjobtypeId = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Profession',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color:
                              selectedinfoProfession == 'Select your Profession'
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infoprofession,
                          selectedItem: selectedinfoProfession,
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
                              selectedinfoProfession = value!;
                              professionId = '';
                              for (var element in MyComponents.occupationData) {
                                if (element.occupationName
                                    .contains(selectedinfoProfession)) {
                                  professionId = element.occupationId;
                                }
                              }
                              if (selectedinfoProfession == 'Student' ||
                                  selectedinfoProfession == 'Just Graduated') {
                                isVisibleCompany = false;
                                isVisibleAbroad = false;
                              } else {
                                isVisibleCompany = true;
                                companyName.clear();
                                selectedinfoSalary = 'Select your Salary';
                                selectedinfoWork = 'Select your Work Location';
                                selectedinfoAbroad = 'Select the Location';
                              }
                            });
                          },
                          popupProps: const PopupPropsMultiSelection.menu(
                              showSearchBox: true, fit: FlexFit.loose),
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
                  Visibility(
                    visible: isVisibleCompany,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Company Name',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color: isCompany
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                              controller: companyName,
                              keyboardType: TextInputType.text,
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
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isCompany = false;
                                  } else {
                                    isCompany = true;
                                  }
                                });
                              }),
                        ),
                      ]),
                    ),
                  ),
                  Visibility(
                    visible: isVisibleCompany,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Salary',
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
                                            fontSize: 18),
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight - 6.0,
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color:
                                    selectedinfoSalary == 'Select your Salary'
                                        ? MyTheme.transparent
                                        : MyTheme.boxFillColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: infosalary,
                                selectedItem: selectedinfoSalary,
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
                                    selectedinfoSalary = value!;
                                    salary = '';
                                    for (var element
                                        in HardCodeData.salaryData) {
                                      if (element.textName
                                          .contains(selectedinfoSalary)) {
                                        salary = element.id;
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
                  ),
                  Visibility(
                    visible: isVisibleCompany,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Work Location',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color:
                                selectedinfoWork == 'Select your Work Location'
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: DropdownSearch<String>(
                            items: infoworkState,
                            selectedItem: selectedinfoWork,
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
                                selectedinfoWork = value!;
                                infoabroadcountry.clear();
                                workLocationId = '';
                                workAbLocationId = '';
                                if (selectedinfoWork ==
                                    'Select your Work Location') {
                                  isVisibleAbroad = false;
                                } else if (selectedinfoWork ==
                                    'Working Abroad') {
                                  workLocationId = '999';
                                  isVisibleAbroad = true;
                                  for (var element
                                      in MyComponents.countryData) {
                                    infoabroadcountry.add(element.countryText);
                                  }
                                  selectedinfoAbroad = 'Select the Country';
                                } else {
                                  isVisibleAbroad = true;
                                  for (var element in MyComponents.stateData) {
                                    if (element.stateName
                                        .contains(selectedinfoWork)) {
                                      workLocationId = element.stateId;
                                    }
                                  }
                                  for (var element
                                      in MyComponents.locationData) {
                                    if (workLocationId == element.stateId) {
                                      infoabroadcountry.add(
                                          '${element.districtName}, $selectedinfoWork');
                                    }
                                  }
                                  selectedinfoAbroad =
                                      'Select the District,State';
                                }
                              });
                            },
                            popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true, fit: FlexFit.loose),
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
                  ),
                  isVisibleAbroad
                      ? SizedBox(
                          width: MyComponents.widthSize(context),
                          child: Column(children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Specify the Location',
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
                            Container(
                              width: MyComponents.widthSize(context),
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color:
                                    selectedinfoAbroad ==
                                                'Select the Location' ||
                                            selectedinfoAbroad ==
                                                'Select the Country' ||
                                            selectedinfoAbroad ==
                                                'Select the District,State'
                                        ? MyTheme.transparent
                                        : MyTheme.boxFillColor,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(color: MyTheme.greyColor),
                              ),
                              child: DropdownSearch<String>(
                                items: infoabroadcountry,
                                selectedItem: selectedinfoAbroad,
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
                                    selectedinfoAbroad = value!;
                                    workAbLocationId = '';
                                    if (selectedinfoWork == 'Working Abroad') {
                                      for (var element
                                          in MyComponents.countryData) {
                                        if (element.countryText
                                            .contains(selectedinfoAbroad)) {
                                          workAbLocationId = element.countryId;
                                        }
                                      }
                                    } else {
                                      for (var element
                                          in MyComponents.locationData) {
                                        if (element.districtName.contains(
                                            selectedinfoAbroad
                                                .split(',')
                                                .first)) {
                                          workAbLocationId = element.districtId;
                                        }
                                      }
                                    }
                                  });
                                },
                                popupProps: const PopupPropsMultiSelection.menu(
                                    showSearchBox: true, fit: FlexFit.loose),
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
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(
                      children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Higher Education',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color: selectedinfoEducation ==
                                    'Select your Higher Education'
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: DropdownSearch<String>(
                            items: infoeducation,
                            selectedItem: selectedinfoEducation,
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
                                selectedinfoEducation = value!;
                                educationId = '';
                                for (var element
                                    in MyComponents.educationData) {
                                  if (element.name
                                      .contains(selectedinfoEducation)) {
                                    educationId = element.id;
                                  }
                                }
                              });
                            },
                            popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true, fit: FlexFit.loose),
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
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Nationality',
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color:
                              selectedinfoCountry == 'Select your Nationality'
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infocountry,
                          selectedItem: selectedinfoCountry,
                          dropdownButtonProps: DropdownButtonProps(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 2.0),
                            icon: Icon(Icons.keyboard_arrow_down,
                                size: 24, color: MyTheme.blackColor),
                          ),
                          onChanged: (value) {
                            setState(() {
                              selectedinfoCountry = value!;
                              countryId = '';
                              stateId = '';
                              districtId = '';
                              for (var element in MyComponents.countryData) {
                                if (selectedinfoCountry == 'India') {
                                  isVisibleSc = true;
                                  countryId = '85';
                                } else if (element.countryText
                                    .contains(selectedinfoCountry)) {
                                  isVisibleSc = false;
                                  countryId = element.countryId;
                                }
                              }
                              selectedinfoState = 'Select your Native State';
                              selectedinfoDistrict =
                                  'Select your Native District,State';
                            });
                          },
                          popupProps: const PopupPropsMultiSelection.menu(
                              showSearchBox: true, fit: FlexFit.loose),
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
                  Visibility(
                    visible: isVisibleSc,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Native State',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color:
                                selectedinfoState == 'Select your Native State'
                                    ? MyTheme.transparent
                                    : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: DropdownSearch<String>(
                            items: infostate,
                            selectedItem: selectedinfoState,
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
                                selectedinfoState = value!;
                                stateId = '';
                                districtId = '';
                                for (var element in MyComponents.stateData) {
                                  if (element.stateName
                                      .contains(selectedinfoState)) {
                                    stateId = element.stateId;
                                  }
                                }
                                infolocation.clear();
                                for (var element in MyComponents.locationData) {
                                  if (element.stateId == stateId) {
                                    infolocation.add(
                                        '${element.districtName},$selectedinfoState');
                                  }
                                }
                              });
                            },
                            popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true, fit: FlexFit.loose),
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
                  ),
                  Visibility(
                    visible: isVisibleSc,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Native District,State',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color: selectedinfoDistrict ==
                                    'Select your Native District,State'
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: DropdownSearch<String>(
                            items: infolocation,
                            selectedItem: selectedinfoDistrict,
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
                                selectedinfoDistrict = value!;
                                districtId = '';
                                for (var element in MyComponents.locationData) {
                                  if (element.districtName.contains(
                                      selectedinfoDistrict.split(',').first)) {
                                    districtId = element.districtId;
                                  }
                                }
                              });
                            },
                            popupProps: const PopupPropsMultiSelection.menu(
                                showSearchBox: true, fit: FlexFit.loose),
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
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
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
                                )
                              ]),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoHeight == 'Select your Height'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infoheight,
                          selectedItem: selectedinfoHeight,
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
                              selectedinfoHeight = value!;
                              height = '';
                              for (var element in MyComponents.heightData) {
                                if (element.name.contains(selectedinfoHeight)) {
                                  height = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Weight',
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoWeight == 'Select your Weight'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: getWeightList(),
                          selectedItem: selectedinfoWeight,
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
                              selectedinfoWeight = value!;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Family Values',
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoFamilyvalue ==
                                  'Select your Family Value'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infofamilyvalue,
                          selectedItem: selectedinfoFamilyvalue,
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
                              selectedinfoFamilyvalue = value!;
                              familyValues = '';
                              for (var element
                                  in HardCodeData.familyValueData) {
                                if (element.textName
                                    .contains(selectedinfoFamilyvalue)) {
                                  familyValues = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoFamilytype ==
                                  'Select your Family Type'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: infofamilytype,
                          selectedItem: selectedinfoFamilytype,
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
                              selectedinfoFamilytype = value!;
                              familytype = '';
                              for (var element in HardCodeData.familyTypeData) {
                                if (element.textName
                                    .contains(selectedinfoFamilytype)) {
                                  familytype = element.id;
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
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Father Name',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isFather
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: fatherName,
                            keyboardType: TextInputType.text,
                            readOnly: SharedPrefs.getDashboard,
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
                            onChanged: (data) {
                              setState(() {
                                if (data.isNotEmpty) {
                                  isFather = false;
                                } else {
                                  isFather = true;
                                }
                              });
                            }),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Mother Name',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isMother
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: motherName,
                            keyboardType: TextInputType.text,
                            readOnly: SharedPrefs.getDashboard,
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
                            onChanged: (data) {
                              setState(() {
                                if (data.isNotEmpty) {
                                  isMother = false;
                                } else {
                                  isMother = true;
                                }
                              });
                            }),
                      ),
                    ]),
                  ),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'No of Siblings',
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
                      Container(
                        width: MyComponents.widthSize(context),
                        height: kToolbarHeight - 6.0,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedinfoSibling == 'Select no of Siblings'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: HardCodeData.sibling,
                          selectedItem: selectedinfoSibling,
                          enabled: !SharedPrefs.getDashboard,
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
                              selectedinfoSibling = value!;
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
                  Visibility(
                    visible: SharedPrefs.getDashboard ? false : true,
                    child: SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Profile Email',
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
                                  )
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
                            shape: BoxShape.rectangle,
                            color: isEmail
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                              controller: emailAddress,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  decoration: TextDecoration.none),
                              cursorColor: MyTheme.blackColor,
                              decoration: const InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isEmail = false;
                                  } else {
                                    isEmail = true;
                                  }
                                });
                              }),
                        ),
                      ]),
                    ),
                  ),
                  if (!SharedPrefs.getStep1Complete)
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Profile Password',
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
                        Container(
                          width: MyComponents.widthSize(context),
                          height: kToolbarHeight - 6.0,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: isPassword
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                              controller: password,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyTheme.greyColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (showPassword) {
                                        showPassword = false;
                                      } else {
                                        showPassword = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isPassword = false;
                                  } else {
                                    isPassword = true;
                                  }
                                });
                              }),
                        ),
                      ]),
                    ),
                  if (!SharedPrefs.getStep1Complete)
                    SizedBox(
                      width: MyComponents.widthSize(context),
                      child: Column(children: [
                        Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.only(left: 8.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Profile Confirm Password',
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
                        Container(
                          width: MyComponents.widthSize(context),
                          height: kToolbarHeight - 6.0,
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: isPassword2
                                ? MyTheme.transparent
                                : MyTheme.boxFillColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: MyTheme.greyColor),
                          ),
                          child: TextField(
                              controller: confirmpassword,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: MyTheme.greyColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (showPassword2) {
                                        showPassword2 = false;
                                      } else {
                                        showPassword2 = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  if (data.isNotEmpty) {
                                    isPassword2 = false;
                                  } else {
                                    isPassword2 = true;
                                  }
                                });
                              }),
                        ),
                      ]),
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
                        if (!SharedPrefs.getDashboard &&
                            !SharedPrefs.getStep1Complete) {
                          if (infopickedFileName.isEmpty) {
                            MyComponents.toast(
                                'Please pick your profile picture');
                            return;
                          }
                        }
                        if (initial.text.isEmpty) {
                          MyComponents.toast('Please enter your initial');
                          return;
                        }
                        if (userName.text.isEmpty) {
                          MyComponents.toast('Please enter full name');
                          return;
                        }
                        if (selectedinfoGender == 'Select your Gender') {
                          MyComponents.toast('Please choose gender');
                          return;
                        }
                        if (dateOfbirth.text.isEmpty) {
                          MyComponents.toast('Please choose date of birth');
                          return;
                        }
                        if (selectedinfoPhysicalstatus ==
                            'Select your Physical Status') {
                          MyComponents.toast('Please choose physical status');
                          return;
                        }
                        if (selectedinfoMotherTongue ==
                            'Select your Mother Tongue') {
                          MyComponents.toast('Please choose mother tongue');
                          return;
                        }
                        if (selectedinfoReligion == 'Select your Religion') {
                          MyComponents.toast('Please choose religion');
                          return;
                        }
                        if (selectedinfoCaste == 'Select your Caste') {
                          MyComponents.toast('Please choose caste');
                          return;
                        }
                        if (selectedinfoSubCaste == 'Select your Sub Caste') {
                          MyComponents.toast('Please choose your sub caste');
                          return;
                        }
                        if (selectedinfoProfession ==
                            'Select your Profession') {
                          MyComponents.toast('Please choose your profession');
                          return;
                        } else if (isVisibleCompany) {
                          if (companyName.text.isEmpty) {
                            MyComponents.toast(
                                'Please choose your company name');
                            return;
                          }
                          if (selectedinfoSalary == 'Select your Salary') {
                            MyComponents.toast('Please enter your salary');
                            return;
                          }
                          if (selectedinfoWork == 'Select your Work Location') {
                            MyComponents.toast(
                                'Please choose your work location');
                            return;
                          } else if (isVisibleAbroad) {
                            if (selectedinfoAbroad == 'Select the Location' ||
                                selectedinfoAbroad == 'Select the Country' ||
                                selectedinfoAbroad ==
                                    'Select the District,State') {
                              if (selectedinfoWork ==
                                  'Select your Work Location') {
                                MyComponents.toast('Please select Location');
                                return;
                              } else if (selectedinfoWork == 'Working Abroad') {
                                MyComponents.toast('Please select Country');
                                return;
                              } else {
                                MyComponents.toast(
                                    'Please select District,State');
                                return;
                              }
                            }
                          }
                        }
                        if (selectedinfoEducation ==
                            'Select your Higher Education') {
                          MyComponents.toast(
                              'Please select your higher education');
                          return;
                        }
                        if (selectedinfoCountry == 'Select your Nationality') {
                          MyComponents.toast('Please select your nationality');
                          return;
                        } else if (selectedinfoCountry == 'India') {
                          if (selectedinfoState == 'Select your Native State') {
                            MyComponents.toast(
                                'Please select your native state');
                            return;
                          }
                          if (selectedinfoDistrict ==
                              'Select your Native District,State') {
                            MyComponents.toast(
                                'Please select your native district,state');
                            return;
                          }
                        }
                        if (selectedinfoHeight == 'Select your Height') {
                          MyComponents.toast('Select your height');
                          return;
                        }
                        if (fatherName.text.isEmpty) {
                          MyComponents.toast('Please enter your father name');
                          return;
                        }
                        if (motherName.text.isEmpty) {
                          MyComponents.toast('Please enter your mother name');
                          return;
                        }
                        if (selectedinfoSibling == 'Select no of Siblings') {
                          MyComponents.toast('Please choose no of siblings');
                          return;
                        }
                        if (!SharedPrefs.getDashboard &&
                            !SharedPrefs.getStep1Complete) {
                          if (emailAddress.text.isEmpty) {
                            MyComponents.toast('Please enter email address');
                            return;
                          }
                          if (!EmailValidator.validate(emailAddress.text)) {
                            MyComponents.toast(
                                'Please enter valid email address');
                            return;
                          }
                          if (password.text.isEmpty) {
                            MyComponents.toast('Please enter profile password');
                            return;
                          }
                          if (confirmpassword.text.isEmpty) {
                            MyComponents.toast(
                                'Please enter profile confirm password');
                            return;
                          }
                          if (password.text.length < 6 &&
                              confirmpassword.text.length < 6) {
                            MyComponents.toast(
                                'Please enter minimum 6 characters profile password');
                            return;
                          }
                          if (password.text != confirmpassword.text) {
                            MyComponents.toast(
                                'Mismatch password, please enter same password');
                            return;
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                        try {
                          Future<BasicStep1> infodata =
                              ApiService.postbasicinformation(
                            '',
                            referralCode.text,
                            profileCreatedBy,
                            initial.text,
                            userName.text,
                            surName.text,
                            gender,
                            selectedDOB,
                            maritalStatus,
                            physicalStatus,
                            motherTongueId,
                            religionId,
                            casteId,
                            subCasteId,
                            selectedjobtypeId,
                            professionId,
                            companyName.text,
                            salary,
                            workLocationId,
                            workAbLocationId,
                            educationId,
                            countryId,
                            stateId,
                            districtId,
                            height,
                            selectedinfoWeight.replaceAll(' Kg', ''),
                            familyValues,
                            familytype,
                            fatherName.text,
                            motherName.text,
                            selectedinfoSibling,
                            emailAddress.text,
                            password.text,
                            infopickedFile,
                            isAgree,
                          );
                          infodata.then((value) {
                            setState(() {
                              if (value.status) {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                if (!SharedPrefs.getDashboard) {
                                  SharedPrefs.step1Complete(true);
                                  MyComponents.navPush(
                                      context,
                                      (p0) => AstroDetailScreen(
                                          isProfileCreatedbyAdmin:
                                              widget.isProfileCreatedbyAdmin));
                                }
                              } else {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                if (SharedPrefs.getDashboard ||
                                    SharedPrefs.getStep1Complete) {
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

  getWeightList() {
    List<String> data = [];
    data.clear();
    for (var i = 0; i < HardCodeData.weight.length; i++) {
      data.add('${HardCodeData.weight[i]} Kg');
    }
    return data;
  }

  getStepData() {
    infocountry.clear();
    infoabroadcountry.clear();
    infostate.clear();
    infoworkState.clear();
    infolocation.clear();
    infoheight.clear();
    infomothertongue.clear();
    inforeligion.clear();
    infocaste.clear();
    infosubcaste.clear();
    infoeducation.clear();
    infoprofession.clear();
    infosalary.clear();
    infomarital.clear();
    infofamilyvalue.clear();
    infofamilytype.clear();
    infophysicalstatus.clear();
    infoannualincome.clear();
    infojobtypelist.clear();
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
    for (var element in HardCodeData.salaryData) {
      infosalary.add(element.textName);
    }
    for (var element in HardCodeData.maritalData) {
      if (element.textName != 'Any') {
        infomarital.add(element.textName);
      }
    }
    for (var element in HardCodeData.physicalStatusData) {
      if (element.textName != 'Any') {
        infophysicalstatus.add(element.textName);
      }
    }
    for (var element in HardCodeData.familyValueData) {
      infofamilyvalue.add(element.textName);
    }
    for (var element in HardCodeData.familyTypeData) {
      infofamilytype.add(element.textName);
    }
    for (var element in HardCodeData.annualincomedata) {
      infoannualincome.add(element.textName);
    }
    for (var element in HardCodeData.jobTypeList) {
      infojobtypelist.add(element.textName);
    }
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
        infocountry.add('India');
        for (var value in MyComponents.countryData) {
          infocountry.add(value.countryText);
        }
      });
    });
    listState.then((statevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.stateData.addAll(statevalue);
        infoworkState.add('Working Abroad');
        for (var value in MyComponents.stateData) {
          infostate.add(value.stateName);
          infoworkState.add(value.stateName);
        }
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
          infoheight.add(value.name);
        }
      });
    });
    listMotherTongue.then((mothertonguevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.mothertongueData.addAll(mothertonguevalue);
        for (var value in MyComponents.mothertongueData) {
          infomothertongue.add(value.name);
        }
      });
    });
    listReligion.then((religionvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.religionData.addAll(religionvalue);
        for (var value in MyComponents.religionData) {
          inforeligion.add(value.name);
        }
      });
    });
    listCaste.then((castevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.casteData.addAll(castevalue);
        for (var value in MyComponents.casteData) {
          infocaste.add(value.casteName);
        }
      });
    });
    listSubcaste.then((subcastevalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.subcasteData.addAll(subcastevalue);
        for (var value in MyComponents.subcasteData) {
          infosubcaste.add(value.subCasteName);
        }
      });
    });
    listEducation.then((educationvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.educationData.addAll(educationvalue);
        for (var value in MyComponents.educationData) {
          infoeducation.add(value.name);
        }
      });
    });
    listOccupation.then((occupationvalue) {
      if (!mounted) return;
      setState(() {
        MyComponents.occupationData.addAll(occupationvalue);
        for (var value in MyComponents.occupationData) {
          infoprofession.add(value.occupationName);
        }
      });
      if (SharedPrefs.getDashboard ||
          SharedPrefs.getStep1Complete ||
          widget.isProfileCreatedbyAdmin == '1') {
        getStepDetails();
      }
    });
    if (SharedPrefs.getDashboard ||
        SharedPrefs.getStep1Complete ||
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
      SharedPrefs.userGender(value1.message[0].gender);
      SharedPrefs.profileSubscribeId(value1.message[0].subscribedPremiumId);
      if (!mounted) return;
      setState(() {
        if (value1.message[0].avatar.isNotEmpty) {
          infopickedFileName = value1.message[0].avatar;
        }
        if (value1.message[0].initialName.isNotEmpty) {
          initial.text = value1.message[0].initialName;
          isInitial = false;
        } else {
          initial.text = '';
          isInitial = true;
        }
        if (value1.message[0].userName.isNotEmpty) {
          userName.text = value1.message[0].userName;
          isName = false;
        } else {
          userName.text = '';
          isName = true;
        }
        if (value1.message[0].surName.isNotEmpty) {
          surName.text = value1.message[0].surName;
          isSurName = false;
        } else {
          surName.text = '';
          isSurName = true;
        }
        if (value1.message[0].companyName.toString().isNotEmpty) {
          companyName.text = value1.message[0].companyName;
          isCompany = false;
        } else {
          companyName.text = '';
          isCompany = true;
        }
        if (value1.message[0].fatherName.toString().isNotEmpty) {
          fatherName.text = value1.message[0].fatherName;
          isFather = false;
        } else {
          fatherName.text = '';
          isFather = true;
        }
        if (value1.message[0].motherName.toString().isNotEmpty) {
          motherName.text = value1.message[0].motherName;
          isMother = false;
        } else {
          motherName.text = '';
          isMother = true;
        }
        if (value1.message[0].email.toString().isNotEmpty) {
          emailAddress.text = value1.message[0].email;
          isEmail = false;
        } else {
          emailAddress.text = '';
          isEmail = true;
        }
        if (value1.message[0].dateOfBirth.isNotEmpty) {
          dateOfbirth.text = MyComponents.formattedDateString(
              value1.message[0].dateOfBirth, 'dd-MM-yyyy');
          selectedDOB = MyComponents.formattedDateString(
              value1.message[0].dateOfBirth, 'yyyy-MM-dd');
          isDated = false;
        } else {
          dateOfbirth.text = '';
          selectedDOB = '';
          isDated = true;
        }
        profileCreatedBy = value1.message[0].createdBy.isEmpty
            ? ''
            : value1.message[0].createdBy;
        selectedinfoProfiledby = value1.message[0].createdBy.isEmpty
            ? 'Select Profile created'
            : '${value1.message[0].createdBy.substring(0, 1).toUpperCase()}'
                '${value1.message[0].createdBy.substring(1, value1.message[0].createdBy.length)}';
        selectedinfoGender = getProfilegen(value1);
        selectedinfoCountry = getCountry(value1);
        selectedinfoState = getState(value1);
        selectedinfoDistrict = getDistrict(value1);
        selectedinfoMotherTongue = getMotherTongue(value1);
        selectedinfoReligion = getReligion(value1);
        selectedinfoCaste = getCasteData(value1);
        selectedinfoSubCaste = getSubcaste(value1);
        selectedinfoWork = getWorkData(value1);
        selectedinfoAbroad = getAbroad(value1);
        selectedinfoEducation = getEducation(value1);
        selectedjobtype = getJobType(value1);
        selectedinfoProfession = getProfession(value1);
        selectedinfoHeight = getHeight(value1);
        selectedinfoMaritalStatus = getMarital(value1);
        selectedinfoSalary = getSalary(value1);
        selectedinfoFamilytype = getFamilyType(value1);
        selectedinfoPhysicalstatus = getPhysical(value1);
        selectedinfoWeight =
            value1.message[0].weight.isEmpty || value1.message[0].weight == '0'
                ? 'Select your Weight'
                : '${value1.message[0].weight} Kg';
        selectedinfoFamilyvalue = getFamilyValue(value1);
        selectedinfoSibling = value1.message[0].sibiling;

        if (SharedPrefs.getDashboard) {
          if (!mounted) return;
          setState(() {
            isPageLoading = true;
          });
        } else {
          if (!mounted) return;
          setState(() {
            networkImageUrl =
                '${MyComponents.imageBaseUrl}${value1.message[0].hasEncode}/${value1.message[0].avatar}';
            isPageLoading = true;
          });
        }
      });
    });
  }

  String getProfileCreate(String createdBy) {
    String data = '';
    if (createdBy.isNotEmpty) {
      if (createdBy == 'myself' ||
          createdBy == 'MySelf' ||
          createdBy == 'M' ||
          createdBy == 'm') {
        data = 'MySelf';
        profileCreatedBy = 'myself';
      } else if (createdBy == 'parents' ||
          createdBy == 'Parents' ||
          createdBy == 'P' ||
          createdBy == 'p') {
        data = 'Parents';
        profileCreatedBy = 'parents';
      } else if (createdBy == 'friends' ||
          createdBy == 'Friends' ||
          createdBy == 'F' ||
          createdBy == 'f') {
        data = 'Friends';
        profileCreatedBy = 'friends';
      } else if (createdBy == 'relatives' ||
          createdBy == 'Relatives' ||
          createdBy == 'R' ||
          createdBy == 'r') {
        data = 'Relatives';
        profileCreatedBy = 'relatives';
      } else {
        data = 'Select Profile created';
        profileCreatedBy = '';
      }
    }
    return data;
  }

  String getProfilegen(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].gender.isNotEmpty) {
        if (value1.message[0].gender == 'M') {
          data = 'Male';
          gender = 'M';
        } else if (value1.message[0].gender == 'F') {
          data = 'Female';
          gender = 'F';
        }
      }
    });
    return data;
  }

  String getCountry(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].countryId.isNotEmpty) {
        if (value1.message[0].countryId == '85') {
          isVisibleSc = true;
          data = 'India';
          countryId = '85';
        } else {
          isVisibleSc = false;
          for (var i = 0; i < MyComponents.countryData.length; i++) {
            if (MyComponents.countryData[i].countryId ==
                value1.message[0].countryId) {
              data = MyComponents.countryData[i].countryText;
              countryId = MyComponents.countryData[i].countryId;
            }
          }
          selectedinfoState = 'Select your Native State';
          selectedinfoDistrict = 'Select your Native District,State';
        }
      }
    });
    return data;
  }

  String getState(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].stateId.isNotEmpty) {
        for (var i = 0; i < MyComponents.stateData.length; i++) {
          if (MyComponents.stateData[i].stateId == value1.message[0].stateId) {
            data = MyComponents.stateData[i].stateName;
            stateId = MyComponents.stateData[i].stateId;
          }
        }
        for (var element in MyComponents.locationData) {
          if (element.stateId == value1.message[0].stateId) {
            infolocation.add('${element.districtName},$data');
          }
        }
      }
    });
    return data;
  }

  String getDistrict(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].districtId.isNotEmpty) {
        for (var i = 0; i < MyComponents.locationData.length; i++) {
          if (MyComponents.locationData[i].districtId ==
              value1.message[0].districtId) {
            data =
                '${MyComponents.locationData[i].districtName},$selectedinfoState';
            districtId = MyComponents.locationData[i].districtId;
          }
        }
      }
    });
    return data;
  }

  String getWorkData(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].wrkLocation.toString().isNotEmpty) {
        if (value1.message[0].wrkLocation == '999') {
          data = 'Working Abroad';
          workLocationId = '999';
          selectedinfoAbroad = 'Select the Location';
          for (var element in MyComponents.countryData) {
            infoabroadcountry.add(element.countryText);
          }
          isVisibleAbroad = true;
        } else {
          for (var i = 0; i < MyComponents.stateData.length; i++) {
            if (MyComponents.stateData[i].stateId ==
                value1.message[0].wrkLocation) {
              data = MyComponents.stateData[i].stateName;
              workLocationId = MyComponents.stateData[i].stateId;
            }
          }
          for (var element in MyComponents.locationData) {
            if (workLocationId == element.stateId) {
              infoabroadcountry.add('${element.districtName}, $data');
            }
          }
          isVisibleAbroad = true;
          selectedinfoAbroad = 'Select the Location';
        }
      } else {
        isVisibleAbroad = false;
        selectedinfoAbroad = 'Select the Location';
      }
    });
    return data;
  }

  String getAbroad(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].wrkLocation == '999') {
        for (var i = 0; i < MyComponents.countryData.length; i++) {
          if (MyComponents.countryData[i].countryId ==
              value1.message[0].wrkAbrLocation) {
            data = MyComponents.countryData[i].countryText;
            workAbLocationId = MyComponents.countryData[i].countryId;
          }
        }
      } else {
        if (value1.message[0].wrkLocation.toString().isNotEmpty) {
          for (var i = 0; i < MyComponents.locationData.length; i++) {
            if (MyComponents.locationData[i].districtId ==
                value1.message[0].wrkAbrLocation) {
              data =
                  '${MyComponents.locationData[i].districtName},$selectedinfoWork';
              workAbLocationId = MyComponents.locationData[i].districtId;
            }
          }
        }
      }
    });
    return data;
  }

  String getMotherTongue(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].motherTongueId.isNotEmpty) {
        for (var i = 0; i < MyComponents.mothertongueData.length; i++) {
          if (MyComponents.mothertongueData[i].id ==
              value1.message[0].motherTongueId) {
            data = MyComponents.mothertongueData[i].name;
            motherTongueId = MyComponents.mothertongueData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getReligion(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].religionId.isNotEmpty) {
        for (var i = 0; i < MyComponents.religionData.length; i++) {
          if (MyComponents.religionData[i].id == value1.message[0].religionId) {
            data = MyComponents.religionData[i].name;
            religionId = MyComponents.religionData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getCasteData(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].casteId.isNotEmpty) {
        for (var i = 0; i < MyComponents.casteData.length; i++) {
          if (MyComponents.casteData[i].casteId == value1.message[0].casteId) {
            data = MyComponents.casteData[i].casteName;
            casteId = MyComponents.casteData[i].casteId;
          }
        }
      }
    });
    return data;
  }

  String getSubcaste(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].subCasteId.isNotEmpty) {
        for (var i = 0; i < MyComponents.subcasteData.length; i++) {
          if (MyComponents.subcasteData[i].subCasteId ==
              value1.message[0].subCasteId) {
            data = MyComponents.subcasteData[i].subCasteName;
            subCasteId = MyComponents.subcasteData[i].subCasteId;
          }
        }
      }
    });
    return data;
  }

  String getEducation(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].educationId.isNotEmpty) {
        for (var i = 0; i < MyComponents.educationData.length; i++) {
          if (MyComponents.educationData[i].id ==
              value1.message[0].educationId) {
            data = MyComponents.educationData[i].name;
            educationId = MyComponents.educationData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getJobType(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].jobTitle.toString().isNotEmpty) {
        for (var i = 0; i < HardCodeData.jobTypeList.length; i++) {
          if (HardCodeData.jobTypeList[i].id == value1.message[0].jobTitle) {
            data = HardCodeData.jobTypeList[i].textName;
            selectedjobtypeId = HardCodeData.jobTypeList[i].id;
          }
        }
      }
    });
    return data;
  }

  String getProfession(MyProfileData value1) {
    String data = '';

    setState(() {
      if (value1.message[0].professionId.isNotEmpty) {
        for (var i = 0; i < MyComponents.occupationData.length; i++) {
          if (MyComponents.occupationData[i].occupationId ==
              value1.message[0].professionId) {
            data = MyComponents.occupationData[i].occupationName;
            professionId = MyComponents.occupationData[i].occupationId;
          }
        }
        if (data == 'Student' || data == 'Just Graduated') {
          isVisibleCompany = false;
          isVisibleAbroad = false;
          companyName.clear();
          selectedinfoSalary = 'Select your Salary';
          selectedinfoWork = 'Select your Work Location';
          selectedinfoAbroad = 'Select the Location';
        } else {
          isVisibleCompany = true;
        }
      } else {
        isVisibleCompany = true;
      }
    });
    return data;
  }

  String getHeight(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].height.isNotEmpty) {
        for (var i = 0; i < MyComponents.heightData.length; i++) {
          if (MyComponents.heightData[i].id == value1.message[0].height) {
            data = MyComponents.heightData[i].name;
            height = MyComponents.heightData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getMarital(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].maritalStatus.isNotEmpty) {
        for (var i = 0; i < HardCodeData.maritalData.length; i++) {
          if (HardCodeData.maritalData[i].id ==
              value1.message[0].maritalStatus) {
            data = HardCodeData.maritalData[i].textName;
            maritalStatus = HardCodeData.maritalData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getSalary(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].salary.toString().isNotEmpty) {
        for (var i = 0; i < HardCodeData.salaryData.length; i++) {
          if (HardCodeData.salaryData[i].id == value1.message[0].salary) {
            data = HardCodeData.salaryData[i].textName;
            salary = HardCodeData.salaryData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getFamilyType(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].familyType.isNotEmpty) {
        for (var i = 0; i < HardCodeData.familyTypeData.length; i++) {
          if (HardCodeData.familyTypeData[i].id ==
              value1.message[0].familyType) {
            data = HardCodeData.familyTypeData[i].textName;
            familytype = HardCodeData.familyTypeData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getPhysical(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].physicalStatus.isNotEmpty) {
        for (var i = 0; i < HardCodeData.physicalStatusData.length; i++) {
          if (HardCodeData.physicalStatusData[i].id ==
              value1.message[0].physicalStatus) {
            data = HardCodeData.physicalStatusData[i].textName;
            physicalStatus = HardCodeData.physicalStatusData[i].id;
          }
        }
      }
    });
    return data;
  }

  String getFamilyValue(MyProfileData value1) {
    String data = '';
    setState(() {
      if (value1.message[0].familyValues.isNotEmpty) {
        for (var i = 0; i < HardCodeData.familyValueData.length; i++) {
          if (HardCodeData.familyValueData[i].id ==
              value1.message[0].familyValues) {
            data = HardCodeData.familyValueData[i].textName;
            familyValues = HardCodeData.familyValueData[i].id;
          }
        }
      }
    });
    return data;
  }

  showDisclaimerDialog(BuildContext context) {
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
              insetPadding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  ListTile(
                    title: Text(
                      'Disclaimer',
                      style: GoogleFonts.rubik(
                          fontSize: 24,
                          color: MyTheme.baseColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    trailing: Icon(
                      Icons.close_rounded,
                      size: 24,
                      color: MyTheme.blackColor,
                    ),
                    onTap: () {
                      MyComponents.navPop(context);
                      MyComponents.navPushAndRemoveUntil(
                          context, (p0) => const LoginScreen(), false);
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Text(
                      'You hereby confirm that as on date of this registration, you do '
                      'not have any objection to receive emails, SMS/WhatsApp '
                      'messages and calls from MyShubamuhurtham and members of '
                      'MyShubamuhurtham as long as you are a registered member of '
                      'MyShubamuhurtham, including SMS permission for authenticating '
                      'mobile transactions via OTP, sent by the Payment Gateway. '
                      'This consent shall supersede any preferences set by you with '
                      'or registration done with the Do Not Disturb (DND Register)/ '
                      'National Customer Preference Register (NCPR). This consent '
                      'extends to emails, messages or calls relating but not limited '
                      'to phone number verification, the provision of matchmaking '
                      'advertising service, matchmaking enquiries and promotions.',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MyComponents.widthSize(context) / 2.8,
                          height: kToolbarHeight - 12.0,
                          margin: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.whiteColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                SharedPrefs.postCall(true);
                              });
                              MyComponents.navPop(context);
                            },
                            child: Text(
                              'Accept',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: MyTheme.baseColor,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context) / 2.8,
                          height: kToolbarHeight - 12.0,
                          margin: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                            ),
                            onPressed: () {
                              MyComponents.navPop(context);
                              MyComponents.navPushAndRemoveUntil(
                                  context, (p0) => const LoginScreen(), false);
                            },
                            child: Text(
                              'Decline',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  color: MyTheme.baseColor,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ]),
                ]),
              ),
            ),
          );
        });
  }

  showDisclaimer2Dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: const EdgeInsets.all(4.0),
            child: SingleChildScrollView(
              child: Column(children: [
                ListTile(
                  title: Text(
                    'Note',
                    style: GoogleFonts.rubik(
                        fontSize: 24,
                        color: MyTheme.baseColor,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  trailing: Icon(
                    Icons.close_rounded,
                    size: 24,
                    color: MyTheme.blackColor,
                  ),
                  onTap: () {
                    MyComponents.navPop(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    'Dear Customer, to activate the "VIEW PROFILES"(search option), '
                    'kindly fill all the mandatory fields marked as * '
                    'which includes: Basic information, Astrology details & Partner preference.',
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        color: MyTheme.blackColor,
                        letterSpacing: 0.4),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MyComponents.widthSize(context) / 2.8,
                        height: kToolbarHeight - 12.0,
                        margin: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              SharedPrefs.postCall(true);
                            });
                            MyComponents.navPop(context);
                          },
                          child: Text(
                            'Accept',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: MyTheme.baseColor,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context) / 2.8,
                        height: kToolbarHeight - 12.0,
                        margin: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            MyComponents.navPop(context);
                            MyComponents.navPushAndRemoveUntil(
                                context, (p0) => const LoginScreen(), false);
                          },
                          child: Text(
                            'Decline',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                color: MyTheme.baseColor,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          );
        });
  }

  showDialogPicker(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: kToolbarHeight + 144.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                    child: Text(
                      'Choose Image',
                      style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: MyTheme.blackColor,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(children: [
                    const SizedBox(width: kToolbarHeight - 26.0),
                    Column(children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: MyTheme.greyColor,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onImageButtonPressed(ImageSource.camera,
                                context: context);
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: MyTheme.whiteColor,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Camera',
                          style: GoogleFonts.rubik(
                              fontSize: 14,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                    const SizedBox(width: kToolbarHeight - 26.0),
                    Column(children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: MyTheme.greyColor,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            onImageButtonPressed(ImageSource.gallery,
                                context: context);
                          },
                          icon: Icon(
                            Icons.image,
                            color: MyTheme.whiteColor,
                            size: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Gallery',
                          style: GoogleFonts.rubik(
                              fontSize: 14,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
                  ]),
                ]),
          );
        });
  }

  Future<void> onImageButtonPressed(ImageSource source,
      {required BuildContext context}) async {
    try {
      pickedFile = await picker.pickImage(
        source: source,
        maxWidth: MyComponents.maxWidth,
        maxHeight: MyComponents.maxHeight,
        imageQuality: MyComponents.imageQuality,
        preferredCameraDevice: CameraDevice.front,
      );

      setState(() {
        imageFile = File(pickedFile!.path);
        if (imageFile!.path.contains('png') ||
            imageFile!.path.contains('jpg') ||
            imageFile!.path.contains('jpeg')) {
          infopickedFile = pickedFile!.path;
          infopickedFileName = pickedFile!.name;
          imagePicked = true;
        } else {
          infopickedFile = '';
          infopickedFileName = '';
          imagePicked = false;
          MyComponents.toast(
              'JPG, JPEG, PNG file format only allowed to upload');
        }
      });
    } catch (e) {
      setState(() {
        imagePicked = false;
        infopickedFile = '';
        infopickedFileName = '';
        debugPrint(e.toString());
      });
    }
  }
}
