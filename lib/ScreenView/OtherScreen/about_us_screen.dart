import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/privacy_policy_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/terms_condition_screen.dart';

class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MyComponents.widthSize(context),
          height: MyComponents.heightSize(context),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 16.0,
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  MyComponents.appName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      letterSpacing: 0.4,
                      color: MyTheme.baseColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 36.0,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 8.0),
              child: FittedBox(
                child: Text(
                  'Version: 1.0.3',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      letterSpacing: 0.4,
                      color: MyTheme.blackColor),
                ),
              ),
            ),
            Container(
              width: MyComponents.widthSize(context),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Image.asset(MyComponents.appIcon,
                  height: kToolbarHeight + 84.0, fit: BoxFit.contain),
            ),
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 16.0,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 10.0),
              child: FittedBox(
                child: Text(
                  '© 2022 myshubamuhurtham.com\nAll Rights Reserved.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      letterSpacing: 0.4,
                      color: MyTheme.blackColor),
                ),
              ),
            ),
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 16.0,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  MyComponents.navPush(
                      context, (p0) => const TermsConditionScreen());
                },
                child: FittedBox(
                  child: Text(
                    'Terms and Conditions'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: MyTheme.blackColor,
                        decoration: TextDecoration.underline,
                        decorationColor: MyTheme.baseColor,
                        decorationThickness: 2.0),
                  ),
                ),
              ),
            ),
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 16.0,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  MyComponents.navPush(
                      context, (p0) => const PrivacyPolicyScreen());
                },
                child: FittedBox(
                  child: Text(
                    'Privacy Policy'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: MyTheme.blackColor,
                        decoration: TextDecoration.underline,
                        decorationColor: MyTheme.baseColor,
                        decorationThickness: 2.0),
                  ),
                ),
              ),
            ),
            Container(
              width: MyComponents.widthSize(context),
              height: kToolbarHeight - 16.0,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  MyComponents.navPush(context, (p0) => const AboutScreen());
                },
                child: FittedBox(
                  child: Text(
                    'About us'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: MyTheme.blackColor,
                        decoration: TextDecoration.underline,
                        decorationColor: MyTheme.baseColor,
                        decorationThickness: 2.0),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<String> missionList = [
    'To help the youth of the Chettiyar community in finding their life partners.',
    'To provide a hassle-free, happy, and satisfying matchmaking experience.',
    'To create a strong customer relationship that lasts forever.'
  ];
  List<String> visionList = [
    'To help all communities in finding potential life partners across the globe.',
    "To be known as one of India's best matrimonial services for not only the "
        "Chettiyar community but also other communities."
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'About us', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Welcome to My ShubaMuhurtham!',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              "Are you looking for Chettiyar brides or grooms? "
              "My ShubaMuhurtham is the perfect destination to find your "
              "perfect life partner from the Chettiyar community. We are a well-known "
              "matrimonial portal among the Chettiyar community. Earlier, parents use "
              "to find a prospective life partner for their children through the local "
              "network of friends and relatives, which was tedious. However, "
              "matrimonial sites have come to their rescue. We at My ShubaMuhurtham "
              "provide a variety of choices and help you choose the best life partner "
              "for you based on your preferences like age, height, location, income, "
              "profession, education, and much more. We use the latest technology and "
              "tools to provide top-notch matrimonial services at affordable pricing "
              "and ensure that every profile on our site is genuine. We are committed "
              "to our members' safety and security. We do everything we could to protect "
              "our members' privacy.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(
              thickness: 2.0,
              color: MyTheme.blackColor,
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Who we are',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              'Our founders J.Sangabani and his wife Mrs S.Valarmathy witnessed '
              'that the parents in his community are finding it difficult to find '
              'the perfect match for their sons and daughters. They came up with '
              'an idea to simplify things for them. This laid the foundation for '
              'My ShubaMuhurtham. They created a matrimonial website to help '
              'people in their community to connect with their prospective life '
              'partners and ultimately find a suitable match according to their '
              'preferences. Mr J. Sangabani, with the support of his wife Mrs '
              'S.Valarmathy D/o Mr. N.Manian Chettiyar, Coimbatore, is all set '
              'to help their community in finding true soulmates. He is the S/o '
              'of Mr. P.Jayachandran Chettiyar & Mrs. Kaveri and the Grandson '
              'of Mr. K.C Porpatham Chettiyar, Chennai, and Mr. V. Sivarama '
              'Chettiyar, Villupuram. His parents and grandparents are well '
              'known people in the Chettiyar community.',
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(thickness: 2.0, color: MyTheme.blackColor),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Mission',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.blackColor),
            ),
          ),
          ListView.builder(
            itemCount: missionList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                minLeadingWidth: 8.0,
                leading: Icon(
                  Icons.circle_rounded,
                  color: MyTheme.blackColor,
                  size: 14.0,
                ),
                title: Text(
                  missionList[index],
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      letterSpacing: 0.4,
                      color: MyTheme.blackColor),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Divider(
              thickness: 2.0,
              color: MyTheme.blackColor,
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Vision',
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.blackColor),
            ),
          ),
          ListView.builder(
              itemCount: visionList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 8.0,
                  leading: Icon(
                    Icons.circle_rounded,
                    color: MyTheme.blackColor,
                    size: 14.0,
                  ),
                  title: Text(
                    visionList[index],
                    style: GoogleFonts.inter(
                        fontSize: 18,
                        letterSpacing: 0.4,
                        color: MyTheme.blackColor),
                  ),
                );
              }),
          SizedBox(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 36.0,
          ),
        ]),
      ),
    );
  }
}
