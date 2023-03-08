import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/blogs_event_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  bool isLoading = false;
  List<BlogsDetails> blogDetails = [];
  List<String> imageDetails = [];

  @override
  void initState() {
    super.initState();
    ApiService.getblogdetails().then((value) {
      if (!mounted) return;
      setState(() {
        blogDetails.addAll(value);
        isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Blogs', true, [], MyTheme.whiteColor),
      body: isLoading
          ? blogDetails.isEmpty
              ? MyComponents.emptyDatatoshow(
                  context, MyComponents.emptySearch, 'No Blogs data found.','',false,(){})
              : ListView.builder(
                  itemCount: blogDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MyComponents.widthSize(context),
                      margin: const EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                      child: Column(children: [
                        blogDetails[index].photoUrl.isNotEmpty
                            ? Image.network(
                                blogDetails[index].photoUrl,
                                width: MyComponents.widthSize(context),
                                height: kToolbarHeight + 204.0,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox.shrink(),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0),
                          child: Text(
                            blogDetails[index].title,
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0),
                          child: Text(
                            blogDetails[index].description,
                            style: GoogleFonts.inter(
                                fontSize: 18, letterSpacing: 0.4),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          margin: const EdgeInsets.only(
                              left: 10.0, top: 10.0, right: 10.0),
                          child: Text(
                            'Published On ${blogDetails[index].createdDate}',
                            style: GoogleFonts.inter(
                                fontSize: 18, letterSpacing: 0.4),
                          ),
                        ),
                        Container(
                          width: MyComponents.widthSize(context),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              MyComponents.navPush(
                                context,
                                (p0) => BlogDetailScreen(
                                    contentData: blogDetails[index].content),
                              );
                            },
                            child: Text(
                              'Read More',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ]),
                    );
                  })
          : MyComponents.circularLoader(MyTheme.transparent, MyTheme.baseColor),
    );
  }
}

class BlogDetailScreen extends StatefulWidget {
  final String contentData;
  const BlogDetailScreen({super.key, required this.contentData});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Blog Details', true, [], MyTheme.whiteColor),
      body: SingleChildScrollView(
        child: Html(
          data: widget.contentData,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
