import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';
import 'package:myshubamuhurtham/ScreenView/HomeScreen/view_details_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  bool isLoading = true;
  List<SearchProfileMessage> favoritedata = [];
  List<MyProfileMessage> myprofiledata = [];
  @override
  void initState() {
    super.initState();
    myprofiledata.clear();
    favoritedata.clear();
    Future<MyProfileData> values = ApiService.postprofilelist();
    values.then((value1) {
      myprofiledata.addAll(value1.message);
      SharedPrefs.userGender(value1.message[0].gender);
      SharedPrefs.profileSubscribeId(value1.message[0].subscribedPremiumId);
    });
    ApiService.getfavoritesendprofilelist().then((value) {
      favoritedata.addAll(value.message);
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
          : favoritedata.isEmpty
              ? MyComponents.emptyDatatoshow(context, MyComponents.emptySearch,
                  'No Saved data found.', '', false, () {})
              : ListView.builder(
                  itemCount: favoritedata.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 0.0,
                        color: MyTheme.backgroundBox,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: MyTheme.greyColor)),
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: Container(
                          width: MyComponents.widthSize(context),
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            getCircularImage(favoritedata[index]),
                            const SizedBox(width: kToolbarHeight - 46.0),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    child: Text(
                                      favoritedata[index].profileNo,
                                      style: GoogleFonts.inter(
                                          color: MyTheme.baseColor,
                                          fontSize: 20,
                                          letterSpacing: 0.8,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MyComponents.widthSize(context) / 2.0,
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    child: Row(children: [
                                      Icon(Icons.cake_rounded,
                                          color: MyTheme.greyColor, size: 28),
                                      Expanded(
                                        child: Text(
                                          ' ${MyComponents.formattedDateString(favoritedata[index].dateOfBirth, 'dd-MM-yyyy')}',
                                          style: GoogleFonts.inter(
                                              color: MyTheme.blackColor,
                                              fontSize: 18,
                                              letterSpacing: 0.8),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: MyTheme.baseColor),
                                    onPressed: () {
                                      MyComponents.navPush(
                                          context,
                                          (p0) => ViewProfileScreen(
                                              myprofile: myprofiledata[0],
                                              profiledata: favoritedata[index],
                                              returnPage: 'Saved',
                                              screenType: 'Viewed'));
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.visibility_rounded),
                                          Text(
                                            ' View Profile',
                                            style: GoogleFonts.rubik(
                                                color: MyTheme.whiteColor,
                                                fontSize: 18,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ]),
                                  ),
                                ]),
                          ]),
                        ));
                  },
                ),
    );
  }

  getCircularImage(SearchProfileMessage favoritedata) {
    if (SharedPrefs.getSubscribeId == '1') {
      if (favoritedata.showInterestAcceptedProfile == '1' ||
          favoritedata.visibleToAll == '1' ||
          favoritedata.protectPhoto == '1') {
        if (favoritedata.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image.network(favoritedata.messageAvatar,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
              return MyComponents.assetImageHolder();
            }),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    } else {
      if (favoritedata.protectPhoto == '1') {
        if (favoritedata.messageAvatar.isEmpty) {
          return MyComponents.assetImageHolder();
        } else {
          return InkWell(
            onTap: () {
              MyComponents.showDialogPreview(context,
                  MyComponents.kImageNetwork, favoritedata.messageAvatar);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                favoritedata.messageAvatar,
                fit: BoxFit.cover,
                width: kToolbarHeight + 64.0,
                height: kToolbarHeight + 64.0,
                errorBuilder: (context, error, stackTrace) {
                  return MyComponents.assetImageHolder();
                },
              ),
            ),
          );
        }
      } else {
        return MyComponents.assetImageHolder();
      }
    }
  }
}
