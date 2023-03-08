import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/interest_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class RejectedHistoryScreen extends StatefulWidget {
  const RejectedHistoryScreen({Key? key}) : super(key: key);

  @override
  State<RejectedHistoryScreen> createState() => _RejectedHistoryScreenState();
}

class _RejectedHistoryScreenState extends State<RejectedHistoryScreen> {
  bool isLoading = true;
  List<RejectedHistoryMessage> rejectedhistory = [];
  @override
  void initState() {
    super.initState();
    ApiService.getrejectedhistory().then((value) {
      rejectedhistory.addAll(value.message);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? MyComponents.fadeShimmerList(true)
          : rejectedhistory.isEmpty
              ? MyComponents.emptyDatatoshow(context, MyComponents.emptySearch,
                  'Not accepted history is empty.', '', false, () {})
              : ListView.builder(
                  itemCount: rejectedhistory.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 0.0,
                      color: MyTheme.backgroundBox,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: MyTheme.greyColor)),
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Row(children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: assetImageHolder()),
                            const SizedBox(width: kToolbarHeight - 50.0),
                            SizedBox(
                              width: MyComponents.widthSize(context) / 2.2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      rejectedhistory[index].profileNo,
                                      style: GoogleFonts.inter(
                                          color: MyTheme.baseColor,
                                          fontSize: 20,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 4.0, bottom: 4.0),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          WidgetSpan(
                                            child: Icon(
                                                Icons.calendar_month_rounded,
                                                color: MyTheme.greyColor),
                                          ),
                                          TextSpan(
                                            text: MyComponents
                                                .formattedDateString(
                                                    rejectedhistory[index]
                                                        .sentAt,
                                                    'dd-MM-yyyy hh:mm:ss'),
                                            style: GoogleFonts.inter(
                                                color: MyTheme.blackColor,
                                                fontSize: 18,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w400),
                                          )
                                        ]),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        disabledBackgroundColor:
                                            MyTheme.redColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      ),
                                      onPressed: null,
                                      child: Text(
                                        'Not Accepted',
                                        style: GoogleFonts.inter(
                                            color: MyTheme.whiteColor,
                                            fontSize: 18,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ]),
                            ),
                          ]),
                        ]),
                      ),
                    );
                  },
                ),
    );
  }

  assetImageHolder() {
    if (SharedPrefs.getGender == 'M') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: Image.network(
          MyComponents.femaleNetPicture,
          fit: BoxFit.cover,
          width: 120.0,
          height: 120.0,
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(80.0),
        child: Image.network(
          MyComponents.maleNetPicture,
          fit: BoxFit.cover,
          width: 120.0,
          height: 120.0,
        ),
      );
    }
  }
}
