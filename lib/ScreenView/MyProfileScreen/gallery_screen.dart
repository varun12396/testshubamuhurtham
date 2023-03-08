import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshubamuhurtham/ApiSection/api_service.dart';
import 'package:myshubamuhurtham/ModelClass/horoscope_gallery_class.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';
import 'package:myshubamuhurtham/MyComponents/my_theme.dart';

class GalleryScreen extends StatefulWidget {
  final String hashData;
  const GalleryScreen({Key? key, required this.hashData}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  bool isLoading = true;
  List<PlatformFile>? paths;
  String? directoryPath;
  String pickedFile = '', pickedFileName = '', isPrimaryPhotos = '';
  List<GalleryPhotoListMessage> galleryPhoto = [];
  @override
  void initState() {
    super.initState();
    getGalleryPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyComponents.appbarWithTitle(
          context, 'Gallery', true, [], MyTheme.whiteColor),
      body: WillPopScope(
        onWillPop: () {
          MyComponents.navPopWithResult(context, isPrimaryPhotos);
          return Future.value(true);
        },
        child: isLoading
            ? MyComponents.circularLoader(
                MyTheme.transparent, MyTheme.baseColor)
            : SingleChildScrollView(
                child: Column(children: [
                  Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.all(10.0),
                    child: Text(
                      'Primary Profile Picture',
                      style:
                          GoogleFonts.rubik(fontSize: 18, letterSpacing: 0.4),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        if (isPrimaryPhotos.isEmpty) {
                          MyComponents.showDialogPreview(
                              context,
                              MyComponents.kImageAssets,
                              MyComponents.profilePicture);
                        } else {
                          MyComponents.showDialogPreview(context,
                              MyComponents.kImageNetwork, isPrimaryPhotos);
                        }
                      },
                      child: Container(
                        width: kToolbarHeight + 104,
                        height: kToolbarHeight + 104,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyTheme.whiteColor,
                          image: isPrimaryPhotos.isEmpty
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage(MyComponents.profilePicture),
                                )
                              : DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(isPrimaryPhotos),
                                ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MyComponents.widthSize(context),
                    margin: const EdgeInsets.all(10.0),
                    child: Text(
                      'Images Gallery',
                      style:
                          GoogleFonts.rubik(fontSize: 18, letterSpacing: 0.4),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 8.0, top: 10.0, right: 8.0, bottom: 40.0),
                    shrinkWrap: true,
                    itemCount: galleryPhoto.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: kToolbarHeight + 144.0,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        InkWell(
                          onTap: () {
                            if (galleryPhoto[index].photoUrl.isEmpty) {
                              pickFiles(index);
                            } else {
                              MyComponents.showDialogPreview(
                                  context,
                                  MyComponents.kImageNetwork,
                                  galleryPhoto[index].photoUrl);
                            }
                          },
                          child: galleryPhoto[index].photoUrl.isNotEmpty
                              ? Container(
                                  width: kToolbarHeight + 104,
                                  height: kToolbarHeight + 104,
                                  decoration: BoxDecoration(
                                    color: MyTheme.whiteColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          galleryPhoto[index].photoUrl),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: PopupMenuButton(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        offset: const Offset(0, 40),
                                        tooltip: 'Options',
                                        icon: Card(
                                          color: MyTheme.whiteColor,
                                          child: Icon(
                                            Icons.more_vert_rounded,
                                            color: MyTheme.blackColor,
                                          ),
                                        ),
                                        onSelected: (value) {
                                          if (value == 1) {
                                            MyComponents.alertDialogBox(
                                                context,
                                                false,
                                                Text(
                                                  MyComponents.appName,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.breeSerif(
                                                    fontSize: 24,
                                                  ),
                                                ),
                                                Text(
                                                  'Are you sure! you want to delete this photo?',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.breeSerif(
                                                      fontSize: 18),
                                                ),
                                                [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      ApiService.postdeletegalleryphoto(
                                                              index.toString())
                                                          .then((value) {
                                                        ApiService.postuploadgalleryphoto(
                                                                pickedFile,
                                                                index
                                                                    .toString())
                                                            .then((value1) {
                                                          getGalleryPhotos();
                                                          MyComponents.toast(
                                                              value.message);
                                                        });
                                                      });
                                                    },
                                                    child: Text(
                                                      'Yes',
                                                      style:
                                                          GoogleFonts.breeSerif(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      MyComponents.navPop(
                                                          context);
                                                    },
                                                    child: Text(
                                                      'No',
                                                      style:
                                                          GoogleFonts.breeSerif(
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ]);
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            ApiService.postsetprimaryphoto(
                                                    index.toString())
                                                .then((value) {
                                              ApiService.postuploadgalleryphoto(
                                                      pickedFile,
                                                      index.toString())
                                                  .then((value1) {
                                                getGalleryPhotos();
                                                MyComponents.toast(
                                                    value.message);
                                              });
                                            });
                                          }
                                        },
                                        itemBuilder: (context) {
                                          if (galleryPhoto[index]
                                              .verifiedAt
                                              .isEmpty) {
                                            return [
                                              PopupMenuItem(
                                                value: 1,
                                                child: Row(children: [
                                                  Icon(
                                                    Icons.delete_rounded,
                                                    color: MyTheme.blackColor,
                                                  ),
                                                  const SizedBox(
                                                    width:
                                                        kToolbarHeight - 46.0,
                                                  ),
                                                  Text(
                                                    'Delete Picture',
                                                    style:
                                                        GoogleFonts.breeSerif(),
                                                  ),
                                                ]),
                                              ),
                                            ];
                                          } else {
                                            return [
                                              PopupMenuItem(
                                                value: 1,
                                                child: Row(children: [
                                                  Icon(Icons.delete_rounded,
                                                      color:
                                                          MyTheme.blackColor),
                                                  const SizedBox(
                                                      width: kToolbarHeight -
                                                          46.0),
                                                  Text(
                                                    'Delete Picture',
                                                    style:
                                                        GoogleFonts.breeSerif(),
                                                  ),
                                                ]),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: Row(children: [
                                                  Icon(Icons.edit_rounded,
                                                      color:
                                                          MyTheme.blackColor),
                                                  const SizedBox(
                                                      width: kToolbarHeight -
                                                          46.0),
                                                  Text(
                                                    'Make Profile Picture',
                                                    style:
                                                        GoogleFonts.breeSerif(),
                                                  ),
                                                ]),
                                              ),
                                            ];
                                          }
                                        }),
                                  ),
                                )
                              : Container(
                                  width: kToolbarHeight + 104,
                                  height: kToolbarHeight + 104,
                                  decoration: BoxDecoration(
                                    color: MyTheme.greyColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: MyTheme.whiteColor,
                                      size: 50.0,
                                    ),
                                  ),
                                ),
                        ),
                        galleryPhoto[index].photoUrl.isEmpty
                            ? const SizedBox.shrink()
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Card(
                                    color:
                                        galleryPhoto[index].verifiedAt.isEmpty
                                            ? MyTheme.redColor
                                            : MyTheme.greenColor,
                                    elevation: 10.0,
                                    shadowColor: MyTheme.whiteColor,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 4.0,
                                          right: 8.0,
                                          bottom: 4.0),
                                      child: Text(
                                        galleryPhoto[index].verifiedAt.isEmpty
                                            ? 'Unverified'
                                            : 'Verified',
                                        style: GoogleFonts.inter(
                                            fontSize: 18.0,
                                            letterSpacing: 0.4,
                                            color: MyTheme.whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ]);
                    },
                  ),
                ]),
              ),
      ),
    );
  }

  void pickFiles(int index) async {
    resetState();
    try {
      directoryPath = null;
      paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) =>
            debugPrint(status.toString()),
      ))
          ?.files;
    } on PlatformException catch (e) {
      debugPrint('Unsupported operation$e');
    } catch (e) {
      debugPrint(e.toString());
    }
    if (!mounted) return;
    setState(() {
      if (paths != null) {
        pickedFile = paths![0].path!;
        pickedFileName = paths![0].name;
        isLoading = true;
      } else {
        pickedFile = '';
        pickedFileName = '';
      }
    });
    if (pickedFile.isNotEmpty) {
      ApiService.postuploadgalleryphoto(pickedFile, index.toString())
          .then((value) {
        MyComponents.toast(value.message);
        getGalleryPhotos();
      });
    }
  }

  void resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      directoryPath = '';
      pickedFile = '';
      paths = null;
    });
  }

  getGalleryPhotos() {
    galleryPhoto.clear();
    for (var i = 0; i < MyComponents.galleryLength; i++) {
      galleryPhoto.add(
        GalleryPhotoListMessage(
            profilePhotoId: '',
            profileId: '',
            photoUrl: '',
            isPrimary: '',
            uploadedAt: '',
            verifiedAt: '',
            isSuspended: '',
            galleryLine: '',
            deleteStatus: ''),
      );
    }
    ApiService.getgalleryphotolist().then((value) {
      for (var i = 0; i < value.message.length; i++) {
        if (value.message[i].deleteStatus != '1') {
          int insertId = int.parse(value.message[i].galleryLine) - 1;
          galleryPhoto.removeAt(insertId);
          galleryPhoto.insert(
            insertId,
            GalleryPhotoListMessage(
                profilePhotoId: value.message[i].profilePhotoId,
                profileId: value.message[i].profileId,
                photoUrl:
                    '${MyComponents.imageBaseUrl}${widget.hashData}/${value.message[i].photoUrl}',
                isPrimary: value.message[i].isPrimary,
                uploadedAt: value.message[i].uploadedAt,
                verifiedAt: value.message[i].verifiedAt,
                isSuspended: value.message[i].isSuspended,
                galleryLine: value.message[i].galleryLine,
                deleteStatus: value.message[i].deleteStatus),
          );
          if (value.message[i].isPrimary == '1') {
            if (!mounted) return;
            setState(() {
              isPrimaryPhotos =
                  '${MyComponents.imageBaseUrl}${widget.hashData}/${value.message[i].photoUrl}';
            });
          }
        } else {
          int insertId = int.parse(value.message[i].galleryLine) - 1;
          galleryPhoto.removeAt(insertId);
          galleryPhoto.insert(
            insertId,
            GalleryPhotoListMessage(
                profilePhotoId: '',
                profileId: '',
                photoUrl: '',
                isPrimary: '',
                uploadedAt: '',
                verifiedAt: '',
                isSuspended: '',
                galleryLine: '',
                deleteStatus: ''),
          );
        }
      }
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    });
  }
}
