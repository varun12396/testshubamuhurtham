import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/received_history_screen.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/rejected_history_screen.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/sent_history__screen.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key}) : super(key: key);

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  List<Widget> tabList = [];
  List<Widget> childrenList = [];

  @override
  void initState() {
    super.initState();
    if (SharedPrefs.getSubscribeId == '1') {
      tabList = const [
        Tab(
          text: 'Sent',
        ),
        Tab(
          text: 'Received',
        ),
        Tab(
          text: 'Rejected',
        ),
      ];
      childrenList = const [
        SentHistoryScreen(),
        ReceivedHistoryScreen(),
        RejectedHistoryScreen(),
      ];
    } else {
      tabList = const [
        Tab(
          text: 'Received',
        ),
      ];
      childrenList = const [
        ReceivedHistoryScreen(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(children: [
          SizedBox(
            width: MyComponents.widthSize(context),
            height: kToolbarHeight - 10,
            child: TabBar(
                labelColor: MyTheme.baseColor,
                labelStyle: GoogleFonts.rubik(
                    fontSize: 18.0,
                    color: MyTheme.baseColor,
                    letterSpacing: 0.4,
                    fontWeight: FontWeight.w500),
                indicatorColor: MyTheme.baseColor,
                unselectedLabelColor: MyTheme.blackColor,
                tabs: tabList),
          ),
          Expanded(
            child: TabBarView(
              children: childrenList,
            ),
          ),
        ]),
      ),
    );
  }
}
