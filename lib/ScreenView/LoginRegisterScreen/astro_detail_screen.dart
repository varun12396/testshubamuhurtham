import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/hard_code_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/ModelClass/setps_info.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/information_screen.dart';
import 'package:myshubamuhurtham/ScreenView/LoginRegisterScreen/partner_prefrence_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/invoice_history_screen.dart';

DateTime selectedDate = DateTime.now();
TimeOfDay selectedTime = TimeOfDay.now();
TextEditingController astrobirthplace = TextEditingController(),
    astrogothram = TextEditingController(),
    dateOfbirth = TextEditingController(),
    astrotime = TextEditingController();
String selectedastrostartype = 'Select your Star Type',
    selectedastrozodiac = 'Select your Zodiac',
    selectedastrodosham = 'Select your Dosham',
    selectedastrohoroscope = 'Generated Horoscope',
    sendastrohoroscope = 'G',
    sendastrozodiac = '',
    sendastrostartype = '',
    uploadHoroscope = '',
    deleteHoroscope = '',
    uploadHoroscopeVerify = '',
    pickedFile = '',
    pickedFileName = '';

class AstroDetailScreen extends StatefulWidget {
  final String isProfileCreatedbyAdmin;
  const AstroDetailScreen({Key? key, required this.isProfileCreatedbyAdmin})
      : super(key: key);

  @override
  State<AstroDetailScreen> createState() => _AstroDetailScreenState();
}

class _AstroDetailScreenState extends State<AstroDetailScreen> {
  bool isFileSelected = true,
      isLoading = true,
      isBirthLocation = true,
      isBirthDate = true,
      isBirthTime = true,
      isGenerated = true,
      isGeneratedLoading = false,
      isPageLoading = true,
      isGothram = true;
  List<String> astrozodiac = [],
      astrostartype = [],
      doshamData = [],
      defaultHoroscope = ['Generated Horoscope'];
  List<PlatformFile>? paths;
  String pickedDateTime = '';
  String? directoryPath;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        astrotime.text = selectedTime.format(context);
        isBirthTime = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    astrostartype.clear();
    astrozodiac.clear();
    doshamData.clear();
    doshamData = HardCodeData.dosham;
    for (var element in HardCodeData.zodiaclist) {
      astrozodiac.add(element.textName);
    }
    for (var element in HardCodeData.startypedata) {
      astrostartype.add(element.textName);
    }
    if (selectedDOB.isNotEmpty) {
      pickedDateTime = selectedDOB;
    }
    if (SharedPrefs.getDashboard ||
        SharedPrefs.getStep2Complete ||
        widget.isProfileCreatedbyAdmin == '1') {
      getStepDetails();
    } else {
      setState(() {
        dateOfbirth.text = MyComponents.formattedDateString(
            SharedPrefs.getDateOfbirth, 'dd-MM-yyyy');
        pickedDateTime = MyComponents.formattedDateString(
            SharedPrefs.getDateOfbirth, 'yyyy-MM-dd');
        isBirthDate = false;
      });
    }
  }

  Future<bool> onWillPop() {
    if (SharedPrefs.getDashboard) {
      MyComponents.navPop(context);
    } else {
      MyComponents.navPushAndRemoveUntil(context,
          (p0) => const InformationScreen(isProfileCreatedbyAdmin: ''), false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MyComponents.appbarWithTitle(
            context, 'Astrology Details', true, [], MyTheme.whiteColor),
        body: isPageLoading
            ? SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Birth Place',
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
                          color: isBirthLocation
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                            controller: astrobirthplace,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                decoration: TextDecoration.none),
                            cursorColor: MyTheme.blackColor,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.location_city_rounded,
                                  size: 24,
                                  color: MyTheme.greyColor,
                                ),
                              ),
                            ),
                            onChanged: (data) {
                              setState(() {
                                if (data.isNotEmpty) {
                                  isBirthLocation = false;
                                } else {
                                  isBirthLocation = true;
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
                              text: 'Birth Date',
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
                          color: MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                          readOnly: true,
                          controller: dateOfbirth,
                          keyboardType: TextInputType.none,
                          style: TextStyle(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              decoration: TextDecoration.none),
                          cursorColor: MyTheme.blackColor,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.cake_rounded,
                                size: 24,
                                color: MyTheme.greyColor,
                              ),
                            ),
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
                              text: 'Birth Time',
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
                          color: isBirthTime
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                          controller: astrotime,
                          onTap: () {
                            _selectTime(context);
                          },
                          keyboardType: TextInputType.none,
                          style: TextStyle(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              decoration: TextDecoration.none),
                          cursorColor: MyTheme.blackColor,
                          decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.access_time,
                                  size: 24, color: MyTheme.greyColor),
                            ),
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
                              text: 'Gothram',
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
                          color: isGothram
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: TextField(
                          controller: astrogothram,
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
                                isGothram = false;
                              } else {
                                isGothram = true;
                              }
                            });
                          },
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
                              text: 'Raasi/Zodiac',
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
                          color: selectedastrozodiac == 'Select your Zodiac'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: astrozodiac,
                          selectedItem: selectedastrozodiac,
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
                              selectedastrozodiac = value!;
                              sendastrozodiac = '';
                              for (var element in HardCodeData.zodiaclist) {
                                if (element.textName == selectedastrozodiac) {
                                  sendastrozodiac = element.id;
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
                              text: 'Nakshathram/Star',
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
                              selectedastrostartype == 'Select your Star Type'
                                  ? MyTheme.transparent
                                  : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: astrostartype,
                          selectedItem: selectedastrostartype,
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
                              selectedastrostartype = value!;
                              sendastrostartype = '';
                              for (var element in HardCodeData.startypedata) {
                                if (element.textName == selectedastrostartype) {
                                  sendastrostartype = element.id;
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
                              text: 'Dosham',
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
                          color: selectedastrodosham == 'Select your Dosham'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: doshamData,
                          selectedItem: selectedastrodosham,
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
                              selectedastrodosham = value!;
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
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Text(
                          'Upload Horoscope (Optional)',
                          style: GoogleFonts.rubik(
                              color: MyTheme.blackColor,
                              fontSize: 18,
                              letterSpacing: 0.4,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ElevatedButton(
                          onPressed: pickedFileName.isNotEmpty
                              ? null
                              : () {
                                  pickFiles();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            fixedSize: Size(
                                MyComponents.widthSize(context) / 2.4,
                                kToolbarHeight - 26.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Choose File',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4),
                          ),
                        ),
                      ),
                      Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 8.0, right: 10.0, bottom: 8.0),
                        child: Text(
                          'Only JPG, PNG, PDF formats are allowed and maximum file size up to 5 MB',
                          style: GoogleFonts.inter(
                              color: MyTheme.blackColor,
                              fontSize: 14,
                              letterSpacing: 0.4),
                        ),
                      ),
                    ]),
                  ),
                  pickedFileName.isEmpty
                      ? const SizedBox.shrink()
                      : pickedFileName.contains('.pdf')
                          ? Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight + 104.0,
                              padding: const EdgeInsets.all(2.0),
                              margin: const EdgeInsets.only(
                                  left: 20.0,
                                  top: 8.0,
                                  right: 20.0,
                                  bottom: 8.0),
                              decoration: BoxDecoration(
                                  color: MyTheme.greyColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(MyComponents.pdfImage),
                              ),
                            )
                          : Container(
                              width: MyComponents.widthSize(context),
                              height: kToolbarHeight + 104.0,
                              margin: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: MyTheme.greyColor, width: 2.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: uploadHoroscope.isNotEmpty
                                    ? Image.network(uploadHoroscope,
                                        fit: BoxFit.cover)
                                    : Image.file(File(pickedFile),
                                        fit: BoxFit.cover),
                              ),
                            ),
                  pickedFileName.isEmpty || !SharedPrefs.getStep2Complete
                      ? const SizedBox.shrink()
                      : Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.all(10.0),
                          child: Column(children: [
                            TextButton(
                              onPressed: () {
                                if (pickedFile.isEmpty) {
                                  if (pickedFileName.contains('.pdf')) {
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
                                  if (pickedFileName.contains('.pdf')) {
                                    MyComponents.navPush(
                                        context,
                                        (p0) => PdfPreviewScreen(
                                            pdfDocFile: pickedFile,
                                            titleHeader: 'Uploaded Horoscope',
                                            fileFormat: 'FileData'));
                                  } else {
                                    MyComponents.showDialogPreview(context,
                                        MyComponents.kImageFile, pickedFile);
                                  }
                                }
                              },
                              style: TextButton.styleFrom(
                                  side: BorderSide(color: MyTheme.redColor)),
                              child: FittedBox(
                                child: Text(
                                  'View Uploaded Horoscope',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            const SizedBox(height: kToolbarHeight - 46.0),
                            TextButton(
                              onPressed: () {
                                if (SharedPrefs.getStep2Complete) {
                                  setState(() {
                                    isGenerated = false;
                                    defaultHoroscope.clear();
                                    defaultHoroscope = ['Generated Horoscope'];
                                    selectedastrohoroscope =
                                        'Generated Horoscope';
                                    sendastrohoroscope = 'G';
                                    uploadHoroscopeVerify =
                                        'Horoscope not uploded';
                                    pickedFile = '';
                                    pickedFileName = '';
                                    uploadHoroscope = '';
                                  });
                                  ApiService.postdeletehoroscope(
                                          deleteHoroscope)
                                      .then((value) {
                                    deleteHoroscope = '';
                                    uploadHoroscope = '';
                                    selectedastrohoroscope =
                                        'Generated Horoscope';
                                    sendastrohoroscope = 'G';
                                    uploadHoroscopeVerify =
                                        'Horoscope not uploded';
                                  });
                                } else {
                                  setState(() {
                                    isGenerated = true;
                                    defaultHoroscope.clear();
                                    defaultHoroscope = ['Generated Horoscope'];
                                    selectedastrohoroscope =
                                        'Generated Horoscope';
                                    sendastrohoroscope = 'G';
                                    uploadHoroscopeVerify =
                                        'Horoscope not uploded';
                                    pickedFile = '';
                                    pickedFileName = '';
                                    uploadHoroscope = '';
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                  side: BorderSide(color: MyTheme.redColor)),
                              child: FittedBox(
                                child: Text(
                                  'Delete Uploaded Horoscope',
                                  style: GoogleFonts.rubik(
                                      color: MyTheme.blackColor,
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ]),
                        ),
                  SharedPrefs.getStep2Complete
                      ? Container(
                          width: MyComponents.widthSize(context),
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              showGeneratedLang(context);
                            },
                            style: TextButton.styleFrom(
                                side: BorderSide(color: MyTheme.redColor)),
                            child: FittedBox(
                              child: Text(
                                'View Generated Horoscope',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SharedPrefs.getDashboard
                      ? Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.all(10.0),
                          child: Row(children: [
                            SizedBox(
                              width: MyComponents.widthSize(context) / 2.8,
                              child: Text(
                                'Horoscope Status',
                                style: GoogleFonts.rubik(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: MyComponents.widthSize(context) / 2.0,
                              child: Text(
                                ': $uploadHoroscopeVerify',
                                style: TextStyle(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ]),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    width: MyComponents.widthSize(context),
                    child: Column(children: [
                      Container(
                        width: MyComponents.widthSize(context),
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Primary Horoscope',
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
                        margin: const EdgeInsets.only(
                            left: 10.0, top: 10.0, right: 10.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: selectedastrohoroscope ==
                                  'Select your Primary Horoscope'
                              ? MyTheme.transparent
                              : MyTheme.boxFillColor,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: MyTheme.greyColor),
                        ),
                        child: DropdownSearch<String>(
                          items: defaultHoroscope,
                          selectedItem: selectedastrohoroscope,
                          enabled: isGenerated,
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
                              selectedastrohoroscope = value!;
                              if (selectedastrohoroscope ==
                                  'Generated Horoscope') {
                                sendastrohoroscope = 'G';
                              } else if (selectedastrohoroscope ==
                                  'Uploaded Horoscope') {
                                sendastrohoroscope = 'M';
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
                        if (astrobirthplace.text.isEmpty) {
                          MyComponents.toast('Please choose Birth Place');
                          return;
                        }
                        if (dateOfbirth.text.isEmpty) {
                          MyComponents.toast('Please choose Birth Date');
                          return;
                        }
                        if (astrotime.text.isEmpty) {
                          MyComponents.toast('Please choose Birth Time');
                          return;
                        }
                        if (astrogothram.text.isEmpty) {
                          MyComponents.toast('Please choose Gothram');
                          return;
                        }
                        if (selectedastrozodiac == 'Select your Zodiac') {
                          MyComponents.toast('Please select your Zodiac');
                          return;
                        }
                        if (selectedastrostartype == 'Select your Star Type') {
                          MyComponents.toast('Please select your Star Type');
                          return;
                        }
                        if (selectedastrodosham == 'Select your Dosham') {
                          MyComponents.toast('Please select your Dosham');
                          return;
                        }
                        if (selectedastrohoroscope ==
                            'Select your Primary Horoscope') {
                          MyComponents.toast(
                              'Please select your Primary Horoscope.');
                          return;
                        }
                        setState(() {
                          isLoading = false;
                        });
                        try {
                          Future<BasicStep2> astrologydata =
                              ApiService.postastrologydetails(
                                  astrobirthplace.text,
                                  astrotime.text,
                                  pickedDateTime,
                                  astrogothram.text,
                                  sendastrozodiac,
                                  sendastrostartype,
                                  selectedastrodosham,
                                  pickedFile,
                                  sendastrohoroscope);
                          astrologydata.then((value) {
                            setState(() {
                              if (value.status) {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                if (!SharedPrefs.getDashboard) {
                                  SharedPrefs.step2Complete(isLoading);
                                  MyComponents.navPush(
                                      context,
                                      (p0) => PartnerPrefrenceScreen(
                                          isProfileCreatedbyAdmin:
                                              widget.isProfileCreatedbyAdmin));
                                }
                              } else {
                                isLoading = true;
                                MyComponents.toast(value.message);
                                pickedFile = '';
                                pickedFileName = '';
                                if (SharedPrefs.getDashboard ||
                                    SharedPrefs.getStep2Complete) {
                                  getStepDetails();
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
                                    fontSize: 18.0,
                                    color: MyTheme.whiteColor,
                                    letterSpacing: 0.4),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                generateHoroscope(setState4, 'TAM');
                              },
                              child: Text(
                                'Tamil',
                                style: GoogleFonts.inter(
                                    fontSize: 18.0,
                                    color: MyTheme.whiteColor,
                                    letterSpacing: 0.4),
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

  void pickFiles() async {
    resetState();
    try {
      directoryPath = null;
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png'],
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            debugPrint(status.toString()),
      ))
          ?.files;
    } on PlatformException catch (e) {
      debugPrint('Unsupported operation$e');
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;
    setState(() {
      if (paths != null) {
        pickedFile = paths![0].path!;
        pickedFileName = paths![0].name;
        defaultHoroscope.clear();
        isGenerated = true;
        defaultHoroscope = ['Generated Horoscope', 'Uploaded Horoscope'];
      } else {
        isGenerated = false;
        defaultHoroscope.clear();
        defaultHoroscope = ['Generated Horoscope'];
        pickedFile = '';
        pickedFileName = '';
      }
    });
  }

  void resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      directoryPath = '';
      pickedFile = '';
      paths = null;
    });
  }

  getStepDetails() {
    if (!mounted) return;
    setState(() {
      isPageLoading = false;
    });
    Future<MyProfileData> profileData = ApiService.postprofilelist();
    profileData.then((value1) {
      if (!mounted) return;
      setState(() {
        if (value1.message[0].dateOfBirth.isNotEmpty) {
          dateOfbirth.text = MyComponents.formattedDateString(
              value1.message[0].dateOfBirth, 'dd-MM-yyyy');
          pickedDateTime = MyComponents.formattedDateString(
              value1.message[0].dateOfBirth, 'yyyy-MM-dd');
          isBirthDate = false;
        } else {
          dateOfbirth.text = '';
          pickedDateTime = '';
          isBirthDate = true;
        }

        if (value1.message[0].birthPlace.isNotEmpty) {
          astrobirthplace.text = value1.message[0].birthPlace;
          isBirthLocation = false;
        } else {
          astrobirthplace.text = '';
          isBirthLocation = true;
        }

        if (value1.message[0].gothram.isNotEmpty) {
          astrogothram.text = value1.message[0].gothram;
          isGothram = false;
        } else {
          astrogothram.text = '';
          isGothram = true;
        }

        if (value1.message[0].birthTime.isNotEmpty) {
          astrotime.text = value1.message[0].birthTime;
          isBirthTime = false;
        } else {
          astrotime.text = '';
          isBirthTime = true;
        }

        if (value1.message[0].star.isNotEmpty) {
          for (var i = 0; i < HardCodeData.startypedata.length; i++) {
            if (HardCodeData.startypedata[i].id == value1.message[0].star) {
              selectedastrostartype = HardCodeData.startypedata[i].textName;
            }
          }
        } else {
          selectedastrostartype = 'Select your Star Type';
        }

        if (value1.message[0].zodiac.isNotEmpty) {
          for (var i = 0; i < HardCodeData.zodiaclist.length; i++) {
            if (HardCodeData.zodiaclist[i].id == value1.message[0].zodiac) {
              selectedastrozodiac = HardCodeData.zodiaclist[i].textName;
            }
          }
        } else {
          selectedastrozodiac = 'Select your Zodiac';
        }

        if (value1.message[0].dosham.isNotEmpty) {
          selectedastrodosham = value1.message[0].dosham;
        } else {
          selectedastrodosham = 'Select your Dosham';
        }

        if (value1.message[0].primaryHoroscope == null ||
            value1.message[0].primaryHoroscope.toString().isEmpty) {
          sendastrohoroscope = 'G';
          selectedastrohoroscope = 'Generated Horoscope';
        } else {
          sendastrohoroscope =
              value1.message[0].primaryHoroscope == 'G' ? 'G' : 'M';
          selectedastrohoroscope = value1.message[0].primaryHoroscope == 'G'
              ? 'Generated Horoscope'
              : 'Uploaded Horoscope';
        }

        pickedFileName = value1.message[0].uploadedHoroscope;
        if (pickedFileName.isNotEmpty) {
          uploadHoroscope =
              '${MyComponents.horoBaseUrl}${value1.message[0].hasEncode}/${value1.message[0].uploadedHoroscope}';
          deleteHoroscope = value1.message[0].uploadedHoroscope;
        } else {
          uploadHoroscope = '';
          deleteHoroscope = '';
        }

        if (value1.message[0].uploadedHoroscope == null ||
            value1.message[0].uploadedHoroscope.toString().isEmpty) {
          uploadHoroscopeVerify = 'Horoscope not uploded';
        } else if (value1.message[0].horoscopeVeirfiedAt == null ||
            value1.message[0].horoscopeVeirfiedAt.toString().isNotEmpty) {
          uploadHoroscopeVerify = 'Verified';
        } else {
          uploadHoroscopeVerify = 'Pending';
        }

        if (uploadHoroscope.isNotEmpty) {
          isGenerated = true;
          defaultHoroscope.clear();
          defaultHoroscope = ['Generated Horoscope', 'Uploaded Horoscope'];
        } else {
          isGenerated = false;
          defaultHoroscope.clear();
          defaultHoroscope = ['Generated Horoscope'];
        }
        isPageLoading = true;
      });
    });
  }
}
