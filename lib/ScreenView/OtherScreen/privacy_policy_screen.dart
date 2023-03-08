import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, MyComponents.appName, true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Privacy Policy',
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
              'Myshubamuhurtham.com is an online matrimonial portal endeavouring constantly to provide you with matrimonial services. This privacy statement is common to all the matrimonial Website/apps operated under Myshubamuhurtham.com Since we are strongly committed to your right to privacy, we have drawn out a privacy statement with regard to the information we collect from you. You acknowledge that you are disclosing information voluntarily. By accessing /using the website/apps and/or by providing your information, you consent to the collection and use of the info you disclose on the website/apps in accordance with this Privacy Policy. If you do not agree for use of your information, please do not use or access this website/apps.',
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'What information you need to give in to use this Website/apps?',
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
              'The information we gather from members and visitors who apply for the various services our website/apps offers includes, but may not be limited to, email address, name, date of birth, educational qualifications a user-specified password, mailing address, zip/pin code and telephone/mobile number or fax number. We use a secure server for credit card transactions to protect the credit card information of our users and Cookies are used to store the login information. Cookies are small files placed on your hard drive that will assist us in providing our services. You may also encounter Cookies or identical/related devices on certain pages of the website/apps that are placed by third parties. We do not control the use of cookies by third parties.'
              'If you establish a credit account with us to pay the fees we charge, some additional information, including a billing address, a credit/debit card number and a credit/debit card expiration date and tracking information from cheques or demand drafts is collected.\nThe user information we collect depends on the context of your interactions with us and the website or Apps, the choices you make and the products and features you use. The User Information is used for authentication and account access, If a user registers using social networking platforms such as Facebook, Google, LinkedIn and others we may collect personal data you choose to allow us to access through their APIs. When the user accesses our websites or apps, data relating to device ID, log files ,Geographic Location, device Information/specification are also collected automatically.\n'
              "We may use also your personal information for analysis of data, usage trends and to evaluate and improve our site/App, marketing research , preventing of frauds. In our efforts to continually improve our product and service offerings, we collect and analyse demographic and profile data about our users' activity on our website/apps. We identify and use your IP address to help diagnose problems with our server, and to administer our website/apps. Your IP address is also used to help identify you and to gather broad demographic information.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'How the website/apps uses the information it collects/tracks?',
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
              "Myshubamuhurtham.com collects information for data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our websites or apps, products, and services ,marketing research from our users primarily to ensure that we are able to fulfil your requirements and to deliver Personalized experience.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'With whom the website/apps shares the information it collects/tracks?',
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
              "We may share such identifiable information with our associates/affiliates/subsidiaries and such associates/affiliates/subsidiaries may market to you as a result of such sharing. Any information you give us is held with the utmost care and security. We are also bound to cooperate fully should a situation arise where we are required by law or legal process to provide information about a customer/visitor.\nWhere required or permitted by law, information may be provided to others, such as regulators and law enforcement agencies or to protect the rights ,property or personal safety of other members or the general public . We may voluntarily share your information with law enforcement agencies / Gateway service providers / anti-fraud solution provider(s) if we feel that the transaction is of suspicious nature.\nFrom time to time, we may consider corporate transactions such as a merger, acquisition, reorganization, asset sale, or similar. In these instances, we may transfer or allow access to information to enable the assessment and undertaking of that transaction. If we buy or sell any business or assets, personal information may be transferred to third parties involved in the transaction.\nOur website/apps links to other website/apps that may collect personally identifiable information about you. We are not responsible for the privacy policy or the contents of those linked website/apps.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'How Long Do We Keep Your Information?',
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
              "We may share such identifiable information with our associates/affiliates/subsidiaries and such associates/affiliates/subsidiaries may market to you as a result of such sharing. Any information you give us is held with the utmost care and security. We are also bound to cooperate fully should a situation arise where we are required by law or legal process to provide information about a customer/visitor.\nWhere required or permitted by law, information may be provided to others, such as regulators and law enforcement agencies or to protect the rights ,property or personal safety of other members or the general public . We may voluntarily share your information with law enforcement agencies / Gateway service providers / anti-fraud solution provider(s) if we feel that the transaction is of suspicious nature.\nFrom time to time, we may consider corporate transactions such as a merger, acquisition, reorganization, asset sale, or similar. In these instances, we may transfer or allow access to information to enable the assessment and undertaking of that transaction. If we buy or sell any business or assets, personal information may be transferred to third parties involved in the transaction.\nOur website/apps links to other website/apps that may collect personally identifiable information about you. We are not responsible for the privacy policy or the contents of those linked website/apps.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'What are the Security Precautions in respect of your personal information?',
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
              "We aim to protect your personal information through a system of organizational and technical security measures. We have implemented appropriate internal control measures designed to protect the security of any personal information we process. However, please also remember that we cannot guarantee that the internet itself is 100% secure. Once your information is in our possession, we adhere to security guidelines protecting it against unauthorised access.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 10.0, bottom: 10.0),
            child: Text(
              'Change of Privacy Policy',
              style: GoogleFonts.rubik(
                  fontSize: 20,
                  letterSpacing: 0.4,
                  fontWeight: FontWeight.w600,
                  color: MyTheme.blackColor),
            ),
          ),
          Container(
            width: MyComponents.widthSize(context),
            margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
            child: Text(
              "We may change this Privacy Policy without notice from time to time without any notice to you. However, changes will be updated in the Privacy Policy page.",
              style: GoogleFonts.inter(
                  fontSize: 18, letterSpacing: 0.4, color: MyTheme.blackColor),
            ),
          ),
        ]),
      ),
    );
  }
}
