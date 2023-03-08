import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/payment_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List<Color?> colorData = [MyTheme.whiteColor, MyTheme.greyColor];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Subscription', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.all(10.0),
            child: Text('Choose the right plan for your life.',
                style: GoogleFonts.rubik(
                    fontSize: 20,
                    letterSpacing: 0.4,
                    color: MyTheme.blackColor,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: MyTheme.premiumColor,
              ),
            ),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: ListTile(
                  horizontalTitleGap: 4.0,
                  title: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 30.0),
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 4.0, bottom: 4.0),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: MyTheme.backgroundBox, width: 2.0),
                    ),
                    child: Text(
                      'Premium Member',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  trailing: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Rs.',
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor),
                      ),
                      TextSpan(
                        text: '2500',
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor,
                            fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: '/90 Days\n',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor),
                      ),
                      TextSpan(
                        text: ' *(All Inclusive)',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 75 Detailed Profiles \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 75 View Horoscopes \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 75 Send Interests \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 50 Horoscope Matchs \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' Computer Generated Horoscope \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' Profile Search with Advanced Filters \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' Photo Privacy Option \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                  ]),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 18.0, right: 18.0, bottom: 30.0),
                child: SharedPrefs.getSubscribeId == '1'
                    ? ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(
                                kToolbarHeight + 164.0, kToolbarHeight - 6.0),
                            disabledBackgroundColor: MyTheme.premiumTextColor,
                            backgroundColor: MyTheme.premiumTextColor),
                        child: FittedBox(
                          child: Text(
                            'Subscribed',
                            style: GoogleFonts.inter(
                                letterSpacing: 0.4,
                                fontSize: 18.0,
                                color: MyTheme.whiteColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          MyComponents.navPush(
                              context, (p0) => const PaymentScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            fixedSize: const Size(
                                kToolbarHeight + 164.0, kToolbarHeight - 6.0),
                            backgroundColor: MyTheme.whiteColor),
                        child: FittedBox(
                          child: Text(
                            'Subscribe Now',
                            style: GoogleFonts.inter(
                                letterSpacing: 0.4,
                                fontSize: 18.0,
                                color: MyTheme.premiumTextColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
              ),
            ]),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyTheme.basicColor),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: ListTile(
                  horizontalTitleGap: 4.0,
                  title: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 30.0),
                    padding: const EdgeInsets.only(
                        left: 10.0, top: 4.0, bottom: 4.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: MyTheme.backgroundBox, width: 2.0)),
                    child: Text(
                      'Standard Member',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  trailing: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Free',
                        style: GoogleFonts.inter(
                            fontSize: 24,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor,
                            fontWeight: FontWeight.w800),
                      ),
                      TextSpan(
                        text: '/Unlimited Days\n',
                        style: GoogleFonts.inter(
                            fontSize: 16,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor),
                      ),
                      TextSpan(
                        text: ' *(Includes Free Trail\nPack Offers)',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            letterSpacing: 0.4,
                            color: MyTheme.whiteColor),
                      ),
                    ]),
                  ),
                ),
              ),
              Container(
                width: MyComponents.widthSize(context),
                margin: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 5 Detailed Profiles \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 5 View Horoscopes \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' 2 Horoscope Matchs \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' Computer Generated Horoscope \n\n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(Icons.circle_rounded,
                            color: MyTheme.whiteColor, size: 10.0),
                      ),
                    ),
                    TextSpan(
                      text: ' Profile Search with Advanced Filters \n',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          letterSpacing: 0.4,
                          color: MyTheme.whiteColor),
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
}
