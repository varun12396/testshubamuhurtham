import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({Key? key}) : super(key: key);

  @override
  State<LoginActivityScreen> createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  bool isColor = false, isLoading = true;
  List<LoginActivityDatum> loginactivitydata = [];
  @override
  void initState() {
    super.initState();
    Future<LoginActivity> loginactivitylist = ApiService.getloginactivity();
    loginactivitylist.then((value) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        loginactivitydata.addAll(value.loginActivityData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Login Activity', true, [], MyTheme.whiteColor),
      body: isLoading
          ? MyComponents.fadeShimmerList(false)
          : loginactivitydata.isEmpty
              ? MyComponents.emptyDatatoshow(context, MyComponents.emptySearch,
                  'No Login history data found', '', false, () {})
              : Container(
                  width: MyComponents.widthSize(context),
                  height: MyComponents.heightSize(context),
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 4.0, right: 8.0),
                  child: ListView.builder(
                    itemCount: loginactivitydata.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: ListTile(
                          leading: loginactivitydata[index].actionType == 'LI'
                              ? Icon(
                                  Icons.login_rounded,
                                  color: MyTheme.greenColor,
                                )
                              : Icon(
                                  Icons.logout_rounded,
                                  color: MyTheme.greyColor,
                                ),
                          title: Text(
                            MyComponents.formattedDateTime(
                                DateTime.parse(
                                    loginactivitydata[index].createdAt),
                                'dd-MM-yyyy hh:mm:ss a'),
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4),
                          ),
                          trailing: Text(
                            loginactivitydata[index].actionType == 'LI'
                                ? 'Log In'
                                : 'Log Out',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                letterSpacing: 0.4,
                                color:
                                    loginactivitydata[index].actionType == 'LI'
                                        ? MyTheme.greenColor
                                        : MyTheme.primaryColor),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
