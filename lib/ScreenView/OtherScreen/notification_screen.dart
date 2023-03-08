import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/interest_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool isLoading = true;
  List<MotificationMessage> notificationList = [];

  @override
  void initState() {
    super.initState();
    ApiService.notificationList().then((value) {
      setState(() {
        isLoading = !isLoading;
      });
      notificationList.addAll(value.message);
    });
    MyComponents.isLabelVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Notification', true, [], MyTheme.whiteColor),
      body: isLoading
          ? MyComponents.fadeShimmerList(false)
          : notificationList.isEmpty
              ? SizedBox(
                  width: MyComponents.widthSize(context),
                  height: MyComponents.heightSize(context),
                  child: MyComponents.emptyDatatoshow(
                      context,
                      MyComponents.notification,
                      'Notification is empty.',
                      '',
                      false,
                      () {}),
                )
              : ListView.builder(
                  itemCount: notificationList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MyComponents.widthSize(context),
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      decoration: index == 9
                          ? const BoxDecoration()
                          : BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: MyTheme.greyColor, width: 1.4),
                              ),
                            ),
                      child: ListTile(
                        title: Text(
                          getContentText(
                              notificationList[index].notificationType),
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.8),
                        ),
                        subtitle: Text(
                          notificationList[index].notificationComment,
                          maxLines: 4,
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              color: MyTheme.blackColor,
                              letterSpacing: 0.8),
                        ),
                      ),
                    );
                  }),
    );
  }

  String getContentText(String notificationType) {
    String data = '';
    if (notificationType == '1') {
      data = 'Sent Interest';
    } else if (notificationType == '2') {
      data = 'Intreset Accepted';
    } else if (notificationType == '3') {
      data = 'Intreset Rejected';
    }
    return data;
  }
}
