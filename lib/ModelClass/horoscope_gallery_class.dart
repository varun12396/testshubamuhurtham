class GenerateHoroscope {
  GenerateHoroscope({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory GenerateHoroscope.fromJson(Map<String, dynamic> json) {
    return GenerateHoroscope(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class HoroscopeMatchList {
  HoroscopeMatchList({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory HoroscopeMatchList.fromJson(Map<String, dynamic> json) {
    return HoroscopeMatchList(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class GalleryPhotoList {
  GalleryPhotoList({
    required this.status,
    required this.message,
  });

  bool status;
  List<GalleryPhotoListMessage> message;

  factory GalleryPhotoList.fromJson(Map<String, dynamic> json) =>
      GalleryPhotoList(
        status: json["status"] ?? false,
        message: json["message"] == null
            ? []
            : List<GalleryPhotoListMessage>.from(json["message"]
                .map((x) => GalleryPhotoListMessage.fromJson(x))),
      );
}

class GalleryPhotoListMessage {
  GalleryPhotoListMessage({
    required this.profilePhotoId,
    required this.profileId,
    required this.photoUrl,
    required this.isPrimary,
    required this.uploadedAt,
    required this.verifiedAt,
    required this.isSuspended,
    required this.galleryLine,
    required this.deleteStatus,
  });

  String profilePhotoId;
  String profileId;
  String photoUrl;
  String isPrimary;
  String uploadedAt;
  String verifiedAt;
  dynamic isSuspended;
  String galleryLine;
  dynamic deleteStatus;

  factory GalleryPhotoListMessage.fromJson(Map<String, dynamic> json) =>
      GalleryPhotoListMessage(
        profilePhotoId: json["profile_photo_id"] ?? '',
        profileId: json["profile_id"] ?? '',
        photoUrl: json["photo_url"] ?? '',
        isPrimary: json["is_primary"] ?? '',
        uploadedAt: json["uploaded_at"] ?? '',
        verifiedAt: json["verified_at"] ?? '',
        isSuspended: json["is_suspended"] ?? '',
        galleryLine: json["gallery_line"] ?? '',
        deleteStatus: json["delete_status"] ?? '',
      );
}

class SetPrimaryPhoto {
  SetPrimaryPhoto({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory SetPrimaryPhoto.fromJson(Map<String, dynamic> json) {
    return SetPrimaryPhoto(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class DeleteGalleryPhoto {
  DeleteGalleryPhoto({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory DeleteGalleryPhoto.fromJson(Map<String, dynamic> json) {
    return DeleteGalleryPhoto(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class UploadGalleryPhoto {
  UploadGalleryPhoto({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory UploadGalleryPhoto.fromJson(Map<String, dynamic> json) {
    return UploadGalleryPhoto(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}