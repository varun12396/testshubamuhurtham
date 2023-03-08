import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/blogs_event_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool isLoading = false, isEmpty = true;
  List<EventsDetails> eventDetails = [];
  List<bool> eventIsReadMore = [];
  @override
  void initState() {
    super.initState();
    ApiService.geteventsdetails().then((value) {
      if (!mounted) return;
      setState(() {
        eventDetails.addAll(value);
        if (eventDetails.isNotEmpty) {
          for (var i = 0; i < eventDetails.length; i++) {
            eventIsReadMore.add(false);
          }
        }
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Events', true, [], MyTheme.whiteColor),
      body: isLoading
          ? eventDetails.isEmpty
              ? MyComponents.emptyDatatoshow(context, MyComponents.emptySearch,
                  'No Events data found.', '', false, () {})
              : ListView.builder(
                  itemCount: eventDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MyComponents.widthSize(context),
                      margin: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                      child: Column(children: [
                        eventDetails[index].photoUrl.isNotEmpty
                            ? Image.network(
                                eventDetails[index].photoUrl,
                                width: MyComponents.widthSize(context),
                                height: kToolbarHeight + 204.0,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox.shrink(),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Text(
                            'Title',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            eventDetails[index].title,
                            style: GoogleFonts.inter(
                                fontSize: 18, letterSpacing: 0.4),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 8.0, top: 8.0, right: 8.0),
                          child: Text(
                            'Description',
                            style: GoogleFonts.inter(
                                color: MyTheme.blackColor,
                                fontSize: 18,
                                letterSpacing: 0.4,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: eventIsReadMore[index]
                              ? Text(
                                  eventDetails[index].description,
                                  style: GoogleFonts.inter(
                                      fontSize: 18, letterSpacing: 0.4),
                                )
                              : Text(
                                  eventDetails[index].description,
                                  maxLines: 2,
                                  style: GoogleFonts.inter(
                                      fontSize: 18, letterSpacing: 0.4),
                                ),
                        ),
                        Visibility(
                          visible: eventIsReadMore[index],
                          child: Column(children: [
                            Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, right: 8.0),
                              child: Text(
                                'Venue Details',
                                style: GoogleFonts.inter(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                eventDetails[index].venue,
                                style: GoogleFonts.inter(
                                    fontSize: 18, letterSpacing: 0.4),
                              ),
                            ),
                            SizedBox(
                              width: MyComponents.widthSize(context),
                              child: Row(children: [
                                Container(
                                  width: MyComponents.widthSize(context) / 2.4,
                                  margin: const EdgeInsets.only(
                                      left: 8.0, top: 8.0, right: 8.0),
                                  child: Text(
                                    'From',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                  width: MyComponents.widthSize(context) / 2.4,
                                  margin: const EdgeInsets.only(
                                      left: 8.0, top: 8.0, right: 8.0),
                                  child: Text(
                                    'To',
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              width: MyComponents.widthSize(context),
                              child: Row(children: [
                                Container(
                                  width: MyComponents.widthSize(context) / 2.4,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: FittedBox(
                                    child: Text(
                                      eventDetails[index].fromdate,
                                      style: GoogleFonts.inter(
                                          color: MyTheme.blackColor,
                                          fontSize: 18,
                                          letterSpacing: 0.4),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MyComponents.widthSize(context) / 2.4,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Text(
                                    eventDetails[index].todate,
                                    style: GoogleFonts.inter(
                                        color: MyTheme.blackColor,
                                        fontSize: 18,
                                        letterSpacing: 0.4),
                                  ),
                                ),
                              ]),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(
                                  left: 8.0, top: 8.0, right: 8.0),
                              child: Text(
                                'Event Time',
                                style: GoogleFonts.inter(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              width: MyComponents.widthSize(context),
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                eventDetails[index].time,
                                style: GoogleFonts.inter(
                                    color: MyTheme.blackColor,
                                    fontSize: 18,
                                    letterSpacing: 0.4),
                              ),
                            ),
                          ]),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                eventIsReadMore[index] =
                                    !eventIsReadMore[index];
                              });
                            },
                            child: Text(
                              eventIsReadMore[index]
                                  ? 'Read Less'
                                  : 'Read More',
                              style: GoogleFonts.inter(
                                  color: MyTheme.blackColor,
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ]),
                    );
                  })
          : MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor),
    );
  }
}
