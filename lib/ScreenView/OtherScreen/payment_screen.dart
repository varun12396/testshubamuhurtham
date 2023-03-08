import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/invoice_history_screen.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/payment_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/main_screen.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';
import 'package:permission_handler/permission_handler.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController refferalCode = TextEditingController(),
      promotionCode = TextEditingController();
  List<PackageListDatum> packageList = [];
  bool isPremium = false,
      isenablePayemnt = false,
      isLoading = true,
      isLoading2 = true,
      isLoadingCoupon = true,
      isLoadingBox = true,
      isApplyCouponBox = false,
      isApplyCoupon = false,
      isReferalsCode = true,
      isPromotionCode = true;
  String packageId = '',
      transactionId = '',
      userName = '',
      contactNumber = '',
      emailAddress = '',
      profileNo = '',
      subsribedDate = '',
      validToDate = '',
      refferalCodes = '',
      promotionCodes = '',
      responseStatusDetails = '';
  double totalAmount = 0.00, discountAmount = 0.00, grandTotal = 0.00;

  @override
  void initState() {
    super.initState();
    ApiService.listPackage().then((value) {
      if (!mounted) return;
      setState(() {
        packageList.addAll(value.packageList);
        isLoading = false;
      });
      ApiService.postprofilelist().then((value) {
        if (!mounted) return;
        setState(() {
          if (value.message[0].refferId.toString().isNotEmpty) {
            refferalCode.text = value.message[0].refferId;
            isPromotionCode = false;
          }
          if (value.message[0].promotionCode.toString().isNotEmpty) {
            promotionCode.text = value.message[0].promotionCode;
            isReferalsCode = false;
          }
          profileNo = value.message[0].profileNo;
          userName = value.message[0].userName;
          contactNumber = value.message[0].mobileNumber;
          emailAddress = value.message[0].email;
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Package Details', true, [], MyTheme.whiteColor),
      body: isLoading
          ? MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor)
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: MyComponents.widthSize(context),
                  margin: const EdgeInsets.all(10.0),
                  child: Text(
                    'Select a Premium Package',
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        color: MyTheme.blackColor,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  width: MyComponents.widthSize(context),
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyTheme.greyColor),
                      borderRadius: BorderRadius.circular(8.0),
                      color: MyTheme.whiteColor),
                  child: ExpansionTile(
                      onExpansionChanged: (value) {
                        setState(() {
                          isPremium = value;
                          isenablePayemnt = value;
                          if (isPremium) {
                            totalAmount = double.parse(packageList[0].amount);
                            grandTotal = totalAmount;
                            packageId = packageList[0].packageId;
                          } else {
                            totalAmount = 0.00;
                            grandTotal = 0.00;
                            discountAmount = 0.00;
                            packageId = '';
                            isApplyCouponBox = false;
                          }
                        });
                      },
                      leading: isPremium
                          ? Icon(Icons.check_circle_rounded,
                              color: MyTheme.greenColor, size: 24.0)
                          : Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(Icons.check_box_outline_blank_rounded,
                                  color: MyTheme.blackColor, size: 20.0),
                            ),
                      trailing: const SizedBox.shrink(),
                      title: FittedBox(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                              text:
                                  '${packageList[0].displayDuration} Package ',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  color: MyTheme.blackColor),
                              children: [
                                TextSpan(
                                  text: '(',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      color: MyTheme.blackColor),
                                ),
                                TextSpan(
                                  text: 'Rs. ${packageList[0].amount}',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      color: MyTheme.baseColor),
                                ),
                                TextSpan(
                                  text: ')',
                                  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      letterSpacing: 0.4,
                                      color: MyTheme.blackColor),
                                )
                              ]),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '(No. of Send Interest: ${packageList[0].noOfSendInterest})',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                letterSpacing: 0.4,
                                color: MyTheme.blackColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '(No. of Horoscope Views: ${packageList[0].noOfHoroscopeViews})',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                letterSpacing: 0.4,
                                color: MyTheme.blackColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0, bottom: 20.0),
                          child: Text(
                            '(No. of Horoscope Compatibility: ${packageList[0].horoscopeCompatibility})',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                letterSpacing: 0.4,
                                color: MyTheme.blackColor),
                          ),
                        ),
                      ]),
                ),
                isPremium
                    ? Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: MyTheme.greyColor),
                            borderRadius: BorderRadius.circular(8.0),
                            color: MyTheme.whiteColor),
                        child: Column(children: [
                          ListTile(
                            leading: Image.asset(MyComponents.discountImage),
                            title: Text(
                              'Apply Coupons',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  color: MyTheme.blackColor),
                            ),
                            trailing: isApplyCoupon
                                ? Icon(Icons.keyboard_arrow_down_rounded,
                                    color: MyTheme.baseColor)
                                : Icon(Icons.keyboard_arrow_right_rounded,
                                    color: MyTheme.baseColor),
                            onTap: () {
                              setState(() {
                                isApplyCoupon = !isApplyCoupon;
                              });
                            },
                          ),
                          Visibility(
                            visible: isApplyCoupon,
                            child: Column(children: [
                              SizedBox(
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
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: MyTheme.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border:
                                          Border.all(color: MyTheme.greyColor),
                                    ),
                                    child: TextField(
                                        controller: refferalCode,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                            color: MyTheme.blackColor,
                                            fontSize: 18,
                                            letterSpacing: 0.4,
                                            decoration: TextDecoration.none),
                                        cursorColor: MyTheme.blackColor,
                                        readOnly: !isReferalsCode,
                                        onTap: () {
                                          if (!isReferalsCode) {
                                            MyComponents.toast(
                                                MyComponents.kCouponMesage);
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                        ),
                                        onChanged: (data) {
                                          setState(() {
                                            if (data.isEmpty) {
                                              isPromotionCode = true;
                                              isenablePayemnt = true;
                                            } else {
                                              isPromotionCode = false;
                                              isenablePayemnt = false;
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
                                      'Kindly provide coupon code, if any',
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
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: MyTheme.transparent,
                                      borderRadius: BorderRadius.circular(10.0),
                                      border:
                                          Border.all(color: MyTheme.greyColor),
                                    ),
                                    child: TextField(
                                        controller: promotionCode,
                                        keyboardType: TextInputType.text,
                                        readOnly: !isPromotionCode,
                                        onTap: () {
                                          if (!isPromotionCode) {
                                            MyComponents.toast(
                                                MyComponents.kCouponMesage);
                                          }
                                        },
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
                                            if (data.isEmpty) {
                                              isReferalsCode = true;
                                              isenablePayemnt = true;
                                            } else {
                                              isReferalsCode = false;
                                              isenablePayemnt = false;
                                            }
                                          });
                                        }),
                                  ),
                                ]),
                              ),
                              isLoadingCoupon
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                          Container(
                                            width: MyComponents.widthSize(
                                                    context) /
                                                2.4,
                                            height: kToolbarHeight - 16.0,
                                            margin: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    MyTheme.baseColor,
                                                elevation: 0.0,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  discountAmount = 0.00;
                                                  grandTotal = totalAmount;
                                                  isApplyCouponBox = false;
                                                  if (refferalCodes
                                                      .isNotEmpty) {
                                                    refferalCode.text =
                                                        refferalCodes;
                                                    isPromotionCode = false;
                                                  }
                                                  if (promotionCodes
                                                      .isNotEmpty) {
                                                    promotionCode.text =
                                                        promotionCodes;
                                                    isReferalsCode = false;
                                                  }
                                                });
                                              },
                                              child: FittedBox(
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.inter(
                                                      color: MyTheme.whiteColor,
                                                      fontSize: 18,
                                                      letterSpacing: 0.4,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MyComponents.widthSize(
                                                    context) /
                                                2.4,
                                            height: kToolbarHeight - 16.0,
                                            margin: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    MyTheme.whiteColor,
                                                elevation: 0.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                  side: BorderSide(
                                                      color:
                                                          MyTheme.blackColor),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (refferalCode.text.isEmpty &&
                                                    promotionCode
                                                        .text.isEmpty) {
                                                  MyComponents.toast(
                                                      'Please apply any one coupons.');
                                                  return;
                                                }
                                                MyComponents.unFocused(context);
                                                setState(() {
                                                  isLoadingCoupon = false;
                                                });
                                                if (refferalCode
                                                    .text.isNotEmpty) {
                                                  ApiService.postRefferalCode(
                                                          refferalCode.text)
                                                      .then((value) {
                                                    if (!value.status) {
                                                      setState(() {
                                                        isLoadingCoupon = true;
                                                      });
                                                      MyComponents.toast(
                                                          value.message);
                                                    } else {
                                                      setState(() {
                                                        discountAmount =
                                                            double.parse(value
                                                                .refferalsData
                                                                .amount);
                                                        grandTotal =
                                                            totalAmount -
                                                                discountAmount;
                                                        isLoadingCoupon = true;
                                                        isApplyCouponBox = true;
                                                        isApplyCoupon = false;
                                                        isenablePayemnt = true;
                                                      });
                                                    }
                                                  });
                                                } else if (promotionCode
                                                    .text.isNotEmpty) {
                                                  ApiService.postPromotionCode(
                                                          promotionCode.text)
                                                      .then((value) {
                                                    if (!value.status) {
                                                      MyComponents.toast(
                                                          value.message);
                                                      setState(() {
                                                        isLoadingCoupon = true;
                                                      });
                                                    } else if (int.parse(value
                                                            .promotionData[0]
                                                            .count) <=
                                                        0) {
                                                      MyComponents.toast(
                                                          value.message);
                                                    } else {
                                                      setState(() {
                                                        discountAmount =
                                                            double.parse(value
                                                                .promotionData[
                                                                    0]
                                                                .amount);
                                                        grandTotal =
                                                            totalAmount -
                                                                discountAmount;
                                                      });
                                                      setState(() {
                                                        isLoadingCoupon = true;
                                                        isApplyCouponBox = true;
                                                        isApplyCoupon = false;
                                                        isenablePayemnt = true;
                                                      });
                                                    }
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'Apply',
                                                style: GoogleFonts.inter(
                                                    color: MyTheme.blackColor,
                                                    fontSize: 18,
                                                    letterSpacing: 0.4,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ])
                                  : MyComponents.bottomCircularLoader(
                                      MyTheme.transparent, MyTheme.baseColor)
                            ]),
                          ),
                        ]),
                      )
                    : const SizedBox.shrink(),
                isPremium
                    ? Container(
                        width: MyComponents.widthSize(context),
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: MyTheme.greyColor),
                            borderRadius: BorderRadius.circular(8.0),
                            color: MyTheme.whiteColor),
                        child: Column(children: [
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              'Bill Summary',
                              style: GoogleFonts.rubik(
                                  fontSize: 20,
                                  color: MyTheme.blackColor,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 14.0, bottom: 8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.5,
                                    child: Text(
                                      'Total Amount',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.5,
                                    child: Text(
                                      'Rs.$totalAmount',
                                      textAlign: TextAlign.right,
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
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 14.0, bottom: 8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.4,
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Discount Amount',
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              color: MyTheme.blackColor,
                                              letterSpacing: 0.8),
                                        ),
                                        TextSpan(
                                          text: isApplyCouponBox ? ' | ' : '',
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: MyTheme.blackColor,
                                              letterSpacing: 0.4),
                                        ),
                                        WidgetSpan(
                                          child: isApplyCouponBox
                                              ? InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      discountAmount = 0.00;
                                                      grandTotal = totalAmount;
                                                      isApplyCouponBox = false;
                                                      isApplyCoupon = false;
                                                      if (refferalCodes
                                                          .isNotEmpty) {
                                                        refferalCode.text =
                                                            refferalCodes;
                                                        isPromotionCode = false;
                                                      }
                                                      if (promotionCodes
                                                          .isNotEmpty) {
                                                        promotionCode.text =
                                                            promotionCodes;
                                                        isReferalsCode = false;
                                                      }
                                                    });
                                                  },
                                                  child: Text(
                                                    'Remove',
                                                    style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        color:
                                                            MyTheme.baseColor,
                                                        letterSpacing: 0.8),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.5,
                                    child: Text(
                                      '- Rs.$discountAmount',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                  ),
                                ]),
                          ),
                          discountAmount == 0.00
                              ? const SizedBox.shrink()
                              : Container(
                                  width: MyComponents.widthSize(context),
                                  margin: const EdgeInsets.only(
                                      left: 14.0, right: 14.0, bottom: 6.0),
                                  child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                        text: 'Congratulations! you saved ',
                                        style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: MyTheme.greenColor,
                                            letterSpacing: 0.4),
                                      ),
                                      TextSpan(
                                        text: 'Rs.${discountAmount.toString()}',
                                        style: GoogleFonts.inter(
                                            fontSize: 18,
                                            color: MyTheme.blackColor,
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ]),
                                  ),
                                ),
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 14.0, bottom: 6.0),
                            child: Divider(color: MyTheme.greyColor),
                          ),
                          Container(
                            width: MyComponents.widthSize(context),
                            margin: const EdgeInsets.only(
                                left: 14.0, right: 14.0, bottom: 18.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.5,
                                    child: Text(
                                      'Grand Total',
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.5,
                                    child: Text(
                                      'Rs.$grandTotal',
                                      textAlign: TextAlign.right,
                                      style: GoogleFonts.inter(
                                          fontSize: 18,
                                          color: MyTheme.blackColor,
                                          letterSpacing: 0.4),
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: isLoading2
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: SharedPrefs.getSubscribeId == '1'
                              ? null
                              : isenablePayemnt
                                  ? () {
                                      if (totalAmount == 0.0) {
                                        MyComponents.toast(
                                            'Please choose premium package.');
                                        return;
                                      }
                                      setState(() {
                                        isLoading2 = false;
                                      });
                                      transactionId = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString();
                                      ApiService.makepayment(packageId)
                                          .then((value) {
                                        subsribedDate =
                                            MyComponents.formattedDateTime(
                                                DateTime.now(),
                                                'dd-MM-yyyy hh:mm:ss');
                                        validToDate =
                                            MyComponents.formattedDateTime(
                                                DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month + 3,
                                                  DateTime.now().day,
                                                  DateTime.now().hour,
                                                  DateTime.now().minute,
                                                  DateTime.now().second,
                                                  DateTime.now().millisecond,
                                                  DateTime.now().microsecond,
                                                ),
                                                'dd/MM/yyyy hh:mm:ss');
                                        transactionId = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();
                                        setState(() {
                                          isLoading2 = true;
                                        });
                                        getPaymentData();
                                      });
                                    }
                                  : null,
                          child: Text(
                            'Make Payment - Rs.${grandTotal.toStringAsFixed(1)}',
                            style: GoogleFonts.inter(
                                color: MyTheme.whiteColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      : MyComponents.circularLoader(
                          MyTheme.transparent, MyTheme.baseColor),
                ),
              ]),
            ),
    );
  }

  getPaymentData() async {
    var bytes = utf8.encode(
        '${MyComponents.merchantKeyLive}|$transactionId|$grandTotal|${MyComponents.appName}|$userName|$emailAddress||||||${MyComponents.merchantSaltLive}');
    var hashUrl = sha1.convert(bytes);
    var response = await PayumoneyProUnofficial.payUParams(
        email: emailAddress,
        firstName: userName,
        merchantName: MyComponents.appName,
        isProduction: true,
        merchantKey: MyComponents.merchantKeyLive,
        merchantSalt: MyComponents.merchantSaltLive,
        amount: grandTotal.toStringAsFixed(2),
        productInfo: MyComponents.appName,
        transactionId: transactionId,
        hashUrl: '$hashUrl',
        userCredentials: '${MyComponents.merchantKeyLive}:$emailAddress',
        showLogs: false,
        userPhoneNumber: contactNumber);

    if (response['status'] == PayUParams.success) {
      showDummyDialog();
      ApiService.paymentDetails(
              profileNo,
              '1',
              userName,
              contactNumber,
              emailAddress,
              grandTotal.toStringAsFixed(2),
              'success',
              transactionId,
              subsribedDate,
              packageId,
              packageId,
              validToDate)
          .then((value) {
        if (value.status) {
          ApiService.postprofilelist().then((value) {
            SharedPrefs.profileSubscribeId(
                value.message[0].subscribedPremiumId);
            MyComponents.navPop(context);
            showSucessPayment(context, transactionId);
          });
        } else {
          MyComponents.toast(MyComponents.kErrorMesage);
        }
      });
    }

    if (response['status'] == PayUParams.failed) {
      MyComponents.toast(response['message']);
    }
  }

  showDummyDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              MyComponents.navPop(context);
              MyComponents.navPushAndRemoveUntil(
                  context,
                  (p0) => const MainScreen(isVisible: false, pageIndex: 4),
                  false);
              return Future.value(true);
            },
            child: Dialog(
              insetPadding: const EdgeInsets.all(0.0),
              backgroundColor: MyTheme.whiteColor,
              child: SizedBox(
                width: MyComponents.widthSize(context),
                height: MyComponents.heightSize(context),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  MyComponents.circularLoader(
                      MyTheme.transparent, MyTheme.baseColor),
                  Container(
                    width: MyComponents.widthSize(context),
                    height: MyComponents.heightSize(context) / 2.2,
                    margin: const EdgeInsets.only(
                        left: 40.0, top: 20.0, right: 40.0, bottom: 20.0),
                    alignment: Alignment.bottomCenter,
                    child: FittedBox(
                      child: Text(
                        "Please Don't Go Back!, While Payment Details Fetching...",
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            letterSpacing: 0.8,
                            color: MyTheme.blackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  showSucessPayment(BuildContext context, String txnid) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return WillPopScope(
            onWillPop: () {
              MyComponents.navPop(context);
              MyComponents.navPushAndRemoveUntil(
                  context,
                  (p0) => const MainScreen(isVisible: false, pageIndex: 4),
                  false);
              return Future.value(true);
            },
            child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: Text(
                  MyComponents.appName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      letterSpacing: 0.4,
                      color: MyTheme.baseColor),
                ),
                content: SizedBox(
                  width: MyComponents.widthSize(context),
                  height: kToolbarHeight + 244.0,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 80.0,
                        backgroundColor: MyTheme.whiteColor,
                        backgroundImage: AssetImage(MyComponents.sucessMark),
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'Payment Successful.\n',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              letterSpacing: 0.8,
                              color: MyTheme.blackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: '\nYour Transcation ID is ',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              letterSpacing: 0.8,
                              color: MyTheme.blackColor),
                        ),
                        TextSpan(
                          text: txnid,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              letterSpacing: 0.8,
                              color: MyTheme.baseColor),
                        )
                      ]),
                    ),
                  ]),
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyTheme.whiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () {
                      MyComponents.navPushAndRemoveUntil(
                          context,
                          (p0) =>
                              const MainScreen(isVisible: false, pageIndex: 4),
                          false);
                    },
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.inter(
                          color: MyTheme.blackColor,
                          fontSize: 18,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  isLoadingBox
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            setState(() {
                              isLoadingBox = isLoadingBox;
                            });
                            askPermission(setState, txnid);
                          },
                          child: Text(
                            'Generate Invoice',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: MyComponents.circularLoader(
                              MyTheme.transparent, MyTheme.baseColor),
                        ),
                ]),
          );
        });
      },
    );
  }

  showLoadingPayment(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const SizedBox.shrink();
      },
    );
  }

  askPermission(StateSetter setState, String txnid) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      setState(() {
        isLoadingBox = false;
      });
      ApiService.getPdfInvoice(txnid).then((value) {
        generateInvoiceData(value);
      });
    }
  }

  generateInvoiceData(PDFInvoice value) async {
    String numToWord = NumberToWord().convert('en-in',
        int.parse(value.message.invoiceDetails[0].amount.split('.').first));
    final pdfTopImage = pw.MemoryImage(
      (await rootBundle.load(MyComponents.pdfTopImage)).buffer.asUint8List(),
    );
    final pdfFooterImage = pw.MemoryImage(
      (await rootBundle.load(MyComponents.pdfFooterImage)).buffer.asUint8List(),
    );
    final pdfDocument = pw.Document();
    pdfDocument.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              width: PdfPageFormat.a4.width.roundToDouble(),
              height: PdfPageFormat.a4.height.roundToDouble(),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColors.black),
              ),
              child: pw.Column(children: [
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Image(pdfTopImage),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight + 44.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() - 295.0,
                      padding: const pw.EdgeInsets.only(left: 4.0, right: 4.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'To: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: value
                                        .message.invoiceDetails[0].firstname,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Profile No.: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: value
                                        .message.invoiceDetails[0].profileNo,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Email: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: value.message.invoiceDetails[0].email,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.SizedBox(
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Mobile No.: ',
                                    style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.TextSpan(
                                    text: value.message.invoiceDetails[0].phone,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() - 413.0,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              height: kToolbarHeight - 33,
                              alignment: pw.Alignment.center,
                              color: PdfColors.red,
                              child: pw.Text(
                                'INVOICE',
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                            ),
                            pw.Container(
                              width: PdfPageFormat.a4.width.roundToDouble() -
                                  413.0,
                              height: kToolbarHeight - 28,
                              alignment: pw.Alignment.centerLeft,
                              padding: const pw.EdgeInsets.only(left: 4.0),
                              decoration: const pw.BoxDecoration(
                                border: pw.Border(
                                  bottom: pw.BorderSide(color: PdfColors.black),
                                ),
                              ),
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Date: ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: value.message.invoiceDetails[0]
                                        .subsribedDate,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            pw.Container(
                              width: PdfPageFormat.a4.width.roundToDouble() -
                                  413.0,
                              height: kToolbarHeight - 28,
                              padding: const pw.EdgeInsets.only(left: 4.0),
                              alignment: pw.Alignment.centerLeft,
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Invoice No: ',
                                    style: pw.TextStyle(
                                      fontSize: 12,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.TextSpan(
                                    text: value.message.invoiceDetails[0].id,
                                    style: const pw.TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight - 16.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Si.No',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Particulars',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      height: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.center,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                          children: [
                            pw.Text(
                              'Amount',
                              style: const pw.TextStyle(fontSize: 12),
                            ),
                            pw.Row(children: [
                              pw.Container(
                                width: kToolbarHeight + 44.0,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  'Rs',
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ),
                              pw.Container(
                                width: kToolbarHeight - 6.0,
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                  'Ps',
                                  style: const pw.TextStyle(fontSize: 12),
                                ),
                              ),
                            ]),
                          ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight + 344.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                      alignment: pw.Alignment.topCenter,
                      padding: const pw.EdgeInsets.only(top: 10.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        '1.',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      alignment: pw.Alignment.topCenter,
                      padding: const pw.EdgeInsets.only(top: 10.0),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(color: PdfColors.black),
                        ),
                      ),
                      child: pw.Text(
                        'Premium Package',
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      alignment: pw.Alignment.topCenter,
                      child: pw.Row(children: [
                        pw.Container(
                          width: kToolbarHeight + 44.0,
                          alignment: pw.Alignment.topCenter,
                          padding: const pw.EdgeInsets.only(top: 10.0),
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            value.message.invoiceDetails[0].amount
                                .split('.')
                                .first,
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                        pw.Container(
                          width: kToolbarHeight - 6.0,
                          alignment: pw.Alignment.topCenter,
                          padding: const pw.EdgeInsets.only(top: 10.0),
                          child: pw.Text(
                            '.${value.message.invoiceDetails[0].amount.split('.').last}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  height: kToolbarHeight - 26.0,
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(color: PdfColors.black),
                      bottom: pw.BorderSide(color: PdfColors.black),
                    ),
                  ),
                  child: pw.Row(children: [
                    pw.Container(
                      width: kToolbarHeight - 16.0,
                    ),
                    pw.Container(
                      width: kToolbarHeight + 225.0,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Container(
                        width: kToolbarHeight + 54.0,
                        height: kToolbarHeight - 26.0,
                        padding: const pw.EdgeInsets.all(2.0),
                        alignment: pw.Alignment.center,
                        color: PdfColors.red,
                        child: pw.Text(
                          'GRAND TOTAL',
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.white,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    pw.Container(
                      width: kToolbarHeight + 84.0,
                      alignment: pw.Alignment.center,
                      child: pw.Row(children: [
                        pw.Container(
                          width: kToolbarHeight + 44.0,
                          alignment: pw.Alignment.center,
                          decoration: const pw.BoxDecoration(
                            border: pw.Border(
                              right: pw.BorderSide(color: PdfColors.black),
                            ),
                          ),
                          child: pw.Text(
                            'Rs.${value.message.invoiceDetails[0].amount.split('.').first}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                        pw.Container(
                          width: kToolbarHeight - 16.0,
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            '.${value.message.invoiceDetails[0].amount.split('.').last}',
                            style: const pw.TextStyle(fontSize: 12),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                pw.Container(
                  width: PdfPageFormat.a4.width.roundToDouble(),
                  child: pw.Row(children: [
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() / 2.4,
                      alignment: pw.Alignment.bottomLeft,
                      padding: const pw.EdgeInsets.only(
                          left: 8.0, top: 20.0, right: 8.0, bottom: 20.0),
                      child: pw.RichText(
                        text: pw.TextSpan(children: [
                          pw.TextSpan(
                            text: 'Rupees: ',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold),
                          ),
                          pw.TextSpan(
                            text: "$numToWord Rupees Only/-",
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ]),
                      ),
                    ),
                    pw.Container(
                      width: PdfPageFormat.a4.width.roundToDouble() / 2.5,
                      padding: const pw.EdgeInsets.only(left: 8.0, right: 8.0),
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              width:
                                  PdfPageFormat.a4.width.roundToDouble() / 2.5,
                              child: pw.Image(pdfFooterImage),
                            ),
                            pw.Container(
                              width:
                                  PdfPageFormat.a4.width.roundToDouble() / 2.5,
                              alignment: pw.Alignment.bottomCenter,
                              child: pw.RichText(
                                text: pw.TextSpan(children: [
                                  pw.TextSpan(
                                    text: 'Note: ',
                                    style: pw.TextStyle(
                                        fontSize: 14,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  const pw.TextSpan(
                                    text:
                                        'This is computer generated invoice no signature required.',
                                    style: pw.TextStyle(fontSize: 12),
                                  ),
                                ]),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              ]),
            );
          }),
    );
    savepdfDoc(pdfDocument);
  }

  savepdfDoc(pw.Document pdfDocument) async {
    final dir = await getExternalStorageDirectory();
    String localPath = dir!.path;
    String fileName = '$localPath/SM_${DateTime.now().toString()}.pdf';
    File fileData = File(fileName);
    fileData.writeAsBytes(await pdfDocument.save(), flush: true).then((value) {
      MyComponents.navPush(
          context,
          (p0) => PdfPreviewScreen(
              pdfDocFile: value.path,
              titleHeader: 'PDF Preview',
              fileFormat: 'FileData'));
    });
  }
}
