import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/drop_list_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/dashboard_screen.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/home_screen.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/favourite_screen.dart';
import 'package:myshubamuhurtham/ScreenView/InterestHistoryScreen/interest_screen.dart';
import 'package:myshubamuhurtham/ScreenView/MyProfileScreen/my_profile_screen.dart';
import 'package:myshubamuhurtham/ScreenView/OtherScreen/notification_screen.dart';

class MainScreen extends StatefulWidget {
  final bool isVisible;
  final int pageIndex;
  const MainScreen({Key? key, required this.isVisible, required this.pageIndex})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<StatefulWidget> pages = [];
  List<BottomNavigationBarItem> itemsBottom = [];

  @override
  void initState() {
    super.initState();
    SharedPrefs.dashboard(true);
    MyComponents.pageIndex = widget.pageIndex;
    if (widget.isVisible) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDisclaimerDialog(context);
      });
    }

    if (SharedPrefs.isVerified) {
      pages = const [
        DashboardScreen(),
        HomeScreen(),
        InterestScreen(),
        FavouriteScreen(),
        MyProfileScreen()
      ];
      itemsBottom = [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: 'Home',
          backgroundColor: MyTheme.baseColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.people_rounded),
          label: 'Matches',
          backgroundColor: MyTheme.baseColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_rounded),
          label: 'Activities',
          backgroundColor: MyTheme.baseColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.bookmark_rounded),
          label: 'Saved',
          backgroundColor: MyTheme.baseColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_rounded),
          label: 'My Profile',
          backgroundColor: MyTheme.baseColor,
        ),
      ];
    } else {
      pages = const [DashboardScreen(), MyProfileScreen()];
      itemsBottom = [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: 'Home',
          backgroundColor: MyTheme.baseColor,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle_rounded),
          label: 'My Profile',
          backgroundColor: MyTheme.baseColor,
        ),
      ];
    }
    MyComponents.mothertongueData.clear();
    MyComponents.countryData.clear();
    MyComponents.stateData.clear();
    MyComponents.locationData.clear();
    MyComponents.heightData.clear();
    MyComponents.religionData.clear();
    MyComponents.casteData.clear();
    MyComponents.subcasteData.clear();
    MyComponents.educationData.clear();
    MyComponents.occupationData.clear();
    MyComponents.mothertongueData.clear();
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
    listMotherTongue.then((mothertonguevalue) {
      MyComponents.mothertongueData.addAll(mothertonguevalue);
    });
    listCountry.then((countryvalue) {
      MyComponents.countryData.addAll(countryvalue);
    });
    listState.then((statevalue) {
      MyComponents.stateData.addAll(statevalue);
    });
    listLocation.then((locationvalue) {
      MyComponents.locationData.addAll(locationvalue);
    });
    listHeight.then((heightvalue) {
      MyComponents.heightData.addAll(heightvalue);
    });
    listReligion.then((religionvalue) {
      MyComponents.religionData.addAll(religionvalue);
    });
    listCaste.then((castevalue) {
      MyComponents.casteData.addAll(castevalue);
    });
    listSubcaste.then((subcastevalue) {
      MyComponents.subcasteData.addAll(subcastevalue);
    });
    listEducation.then((educationvalue) {
      MyComponents.educationData.addAll(educationvalue);
    });
    listOccupation.then((occupationvalue) {
      MyComponents.occupationData.addAll(occupationvalue);
    });
  }

  void onItemTapped(int index) {
    setState(() {
      MyComponents.pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyTheme.baseColor,
        toolbarHeight: MyComponents.pageIndex == 2 ? 0.0 : kToolbarHeight,
        title: Image.asset(MyComponents.appLogo,
            width: kToolbarHeight + 154.0, height: kToolbarHeight),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              highlightColor: MyTheme.transparent,
              splashColor: MyTheme.transparent,
              tooltip: 'Notification',
              onPressed: () {
                MyComponents.navPush(
                    context, (p0) => const NotificationScreen());
              },
              icon: Badge(
                isLabelVisible: MyComponents.isLabelVisible,
                smallSize: 8.0,
                backgroundColor: MyTheme.greenColor,
                alignment: AlignmentDirectional.topEnd,
                child: Icon(Icons.notifications_outlined,
                    size: 30, color: MyTheme.whiteColor),
              ),
            ),
          ),
        ],
      ),
      body: pages[MyComponents.pageIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: MyComponents.pageIndex,
          selectedFontSize: 16.0,
          unselectedFontSize: 14.0,
          selectedLabelStyle: GoogleFonts.rubik(),
          unselectedLabelStyle: GoogleFonts.rubik(),
          type: BottomNavigationBarType.fixed,
          onTap: onItemTapped,
          items: itemsBottom),
    );
  }

  showDisclaimerDialog(BuildContext context) {
    MyComponents.alertDialogBox(
        context,
        false,
        Text(
          'Disclaimer',
          textAlign: TextAlign.center,
          style: GoogleFonts.rubik(
              fontSize: 24, color: MyTheme.baseColor, letterSpacing: 0.4),
        ),
        Text(
          'We hereby declare that "My Shubamuhurtham" mobile application is not a dating '
          'mobile application and it is strictly for matrimonial purpose only.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 18, color: MyTheme.blackColor, letterSpacing: 0.4),
        ),
        [
          ElevatedButton(
            onPressed: () {
              MyComponents.navPop(context);
            },
            child: Text(
              'Got It',
              style: GoogleFonts.inter(
                  fontSize: 18, color: MyTheme.whiteColor, letterSpacing: 0.4),
            ),
          ),
        ]);
  }
}
