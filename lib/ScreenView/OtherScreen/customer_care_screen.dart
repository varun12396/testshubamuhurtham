import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/email_validator.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class CustomerCareScreen extends StatefulWidget {
  const CustomerCareScreen({Key? key}) : super(key: key);

  @override
  State<CustomerCareScreen> createState() => _CustomerCareScreenState();
}

class _CustomerCareScreenState extends State<CustomerCareScreen> {
  TextEditingController username = TextEditingController(),
      emailaddress = TextEditingController(),
      contactnumber = TextEditingController(),
      contentMessage = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Customer Care', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.all(10.0),
            child: Text(
              'Name',
              style: GoogleFonts.rubik(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 6.0,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.blackColor),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextField(
              controller: username,
              keyboardType: TextInputType.name,
              style: TextStyle(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
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
            margin: const EdgeInsets.all(10.0),
            child: Text(
              'Email',
              style: GoogleFonts.rubik(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 6.0,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.blackColor),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextField(
              controller: emailaddress,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
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
            margin: const EdgeInsets.all(10.0),
            child: Text(
              'Contact Number',
              style: GoogleFonts.rubik(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 6.0,
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.blackColor),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextField(
              controller: contactnumber,
              keyboardType: TextInputType.number,
              maxLength: 10,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: TextStyle(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  decoration: TextDecoration.none),
              cursorColor: MyTheme.blackColor,
              decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  counterText: ''),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.all(10.0),
            child: Text(
              'Your message',
              style: GoogleFonts.rubik(
                  color: MyTheme.blackColor,
                  fontSize: 18,
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 20.0),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.blackColor),
                borderRadius: BorderRadius.circular(10.0)),
            child: TextField(
              controller: contentMessage,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              minLines: 3,
              style: TextStyle(
                  color: MyTheme.blackColor,
                  fontSize: 18,
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
            margin: const EdgeInsets.only(
                left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
            child: isLoading
                ? MyComponents.circularLoader(
                    MyTheme.transparent, MyTheme.baseColor)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        ElevatedButton(
                          onPressed: () {
                            clearData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            fixedSize: const Size(
                                kToolbarHeight + 84.0, kToolbarHeight - 6.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Clear',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (username.text.isEmpty) {
                              MyComponents.toast('Please enter name');
                              return;
                            }
                            if (emailaddress.text.isEmpty) {
                              MyComponents.toast('Please enter email address');
                              return;
                            }
                            if (!EmailValidator.validate(emailaddress.text)) {
                              MyComponents.toast(
                                  'Please enter valid email address');
                              return;
                            }
                            if (contactnumber.text.isEmpty) {
                              MyComponents.toast('Please enter contact number');
                              return;
                            }
                            if (contactnumber.text.length <= 10) {
                              MyComponents.toast(
                                  'Please enter 10 digit contact number');
                              return;
                            }
                            if (contentMessage.text.isEmpty) {
                              MyComponents.toast('Please enter your meassge');
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              ApiService.postCustomerCare(
                                      username.text,
                                      emailaddress.text,
                                      contactnumber.text,
                                      contentMessage.text)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                  clearData();
                                  MyComponents.toast(value.message);
                                });
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                                MyComponents.toast(MyComponents.kErrorMesage);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.baseColor,
                            fixedSize: const Size(
                                kToolbarHeight + 84.0, kToolbarHeight - 6.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 40.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Send a mail to us',
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 10.0),
                child: TextButton(
                  onPressed: () {
                    MyComponents.launchInEmail(MyComponents.emailAddress);
                  },
                  child: Row(children: [
                    Icon(Icons.email_outlined,
                        color: MyTheme.primaryColor, size: 28.0),
                    const SizedBox(width: kToolbarHeight - 46.0),
                    Text(
                      MyComponents.emailAddress,
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8),
                    ),
                  ]),
                ),
              ),
              Text(
                'Helpline Numbers',
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(
                    left: 5.0, top: 5.0, right: 5.0, bottom: 10.0),
                child: TextButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Row(children: [
                    Image.asset('images/whatsapp.png',
                        width: 28.0, height: 28.0),
                    const SizedBox(width: kToolbarHeight - 46.0),
                    Text(
                      '+91 ${MyComponents.contactNumber}',
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8),
                    ),
                  ]),
                ),
              ),
              Text(
                'Working Hours',
                style: GoogleFonts.inter(
                    color: MyTheme.blackColor,
                    fontSize: 18,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: TextButton(
                  onPressed: null,
                  child: Row(children: [
                    Icon(Icons.schedule, color: MyTheme.greyColor, size: 28.0),
                    const SizedBox(width: kToolbarHeight - 46.0),
                    Text(
                      MyComponents.timeSlot,
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8),
                    ),
                  ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(actions: [
        Center(
          child: Column(children: [
            TextButton(
              onPressed: () {
                MyComponents.navPop(context);
                MyComponents.launchInPhone(MyComponents.contactNumber);
              },
              child: Row(children: [
                Icon(Icons.phone, color: MyTheme.greenColor, size: 28.0),
                const SizedBox(width: 10.0),
                Text(
                  'Call',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.8),
                ),
              ]),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                MyComponents.navPop(context);
                MyComponents.launchInBrowser(
                    'https://api.whatsapp.com/send/?phone=91${MyComponents.contactNumber}&text&app_absent=0');
              },
              child: Row(children: [
                Image.asset('images/whatsapp.png', width: 28.0, height: 28.0),
                const SizedBox(width: 10.0),
                Text(
                  'Whatsapp',
                  style: GoogleFonts.inter(
                      color: MyTheme.blackColor,
                      fontSize: 18,
                      letterSpacing: 0.8),
                ),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  clearData() {
    username.clear();
    emailaddress.clear();
    contactnumber.clear();
    contentMessage.clear();
  }
}
