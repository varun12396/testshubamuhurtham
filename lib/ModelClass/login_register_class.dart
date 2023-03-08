class RegisterOtp {
  RegisterOtp({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory RegisterOtp.fromJson(Map<String, dynamic> json) {
    return RegisterOtp(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class LoginOtpVerify {
  LoginOtpVerify({
    required this.status,
    required this.message,
    required this.userId,
    required this.myProfileId,
  });

  bool status;
  String message;
  String userId;
  String myProfileId;

  factory LoginOtpVerify.fromJson(Map<String, dynamic> json) {
    return LoginOtpVerify(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
      userId: json["user_id"] ?? '',
      myProfileId: json["my_profile_id"] ?? '',
    );
  }
}

class ChangePassword {
  ChangePassword({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class ProfilePrivacy {
  ProfilePrivacy({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory ProfilePrivacy.fromJson(Map<String, dynamic> json) {
    return ProfilePrivacy(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class HashData {
  HashData({
    required this.status,
    required this.hashEncode,
  });

  bool status;
  String hashEncode;

  factory HashData.fromJson(Map<String, dynamic> json) {
    return HashData(
      status: json["status"] ?? false,
      hashEncode: json["hash_encode"] ?? '',
    );
  }
}

class LoginActivity {
  LoginActivity({
    required this.profileData,
    required this.loginActivityData,
  });

  LogActivityProfileData profileData;
  List<LoginActivityDatum> loginActivityData;

  factory LoginActivity.fromJson(Map<String, dynamic> json) {
    return LoginActivity(
      profileData: LogActivityProfileData.fromJson(json["profile_data"]),
      loginActivityData: List<LoginActivityDatum>.from(
          json["login_activity_data"]
              .map((x) => LoginActivityDatum.fromJson(x))),
    );
  }
}

class LoginActivityDatum {
  LoginActivityDatum({
    required this.id,
    required this.actionType,
    required this.createdAt,
    required this.createdById,
  });

  String id;
  String actionType;
  String createdAt;
  String createdById;

  factory LoginActivityDatum.fromJson(Map<String, dynamic> json) {
    return LoginActivityDatum(
      id: json["id"] ?? '',
      actionType: json["action_type"] ?? '',
      createdAt: json["created_at"] ?? '',
      createdById: json["created_by_id"] ?? '',
    );
  }
}

class LogActivityProfileData {
  LogActivityProfileData({
    required this.profileId,
    required this.userId,
    required this.aboutMe,
    required this.salary,
    required this.profileNo,
    required this.isFreeProfile,
    required this.createdBy,
    required this.userName,
    required this.initialName,
    required this.surName,
    required this.gender,
    required this.profileViewCount,
    required this.profileStep,
    required this.casteId,
    required this.subCasteId,
    required this.height,
    required this.weight,
    required this.familyValues,
    required this.fatherName,
    required this.motherName,
    required this.sibiling,
    required this.companyName,
    required this.mobileNumber,
    required this.dateOfBirth,
    required this.professionId,
    required this.subscribedPremiumId,
    required this.showInterestAcceptedProfile,
    required this.professionText,
    required this.educationId,
    required this.educationText,
    required this.countryId,
    required this.countryCode,
    required this.locationId,
    required this.permanentLocationId,
    required this.locationName,
    required this.stateId,
    required this.stateCode,
    required this.districtId,
    required this.districtName,
    required this.familyType,
    required this.birthPlace,
    required this.birthTime,
    required this.gothram,
    required this.zodiac,
    required this.star,
    required this.dosham,
    required this.profileDataAvatar,
    required this.avatar,
    required this.hasAvatar,
    required this.maritalStatus,
    required this.physicalStatus,
    required this.isVerified,
    required this.verifiedAt,
    required this.motherTongueId,
    required this.religionId,
    required this.isPrimaryProfile,
    required this.email,
    required this.isEmailVerified,
    required this.uploadedHoroscope,
    required this.generatedHoroscope,
    required this.primaryHoroscope,
    required this.visibleToAll,
    required this.protectPhoto,
    required this.isAgree,
    required this.subscribedAstropackId,
    required this.subscribedPlan,
    required this.createdAt,
    required this.updatedAt,
  });

  String profileId;
  String userId;
  dynamic aboutMe;
  String salary;
  String profileNo;
  String isFreeProfile;
  String createdBy;
  String userName;
  String initialName;
  String surName;
  String gender;
  String profileViewCount;
  String profileStep;
  String casteId;
  String subCasteId;
  String height;
  String weight;
  String familyValues;
  String fatherName;
  String motherName;
  String sibiling;
  String companyName;
  String mobileNumber;
  String dateOfBirth;
  String professionId;
  dynamic subscribedPremiumId;
  dynamic showInterestAcceptedProfile;
  String professionText;
  String educationId;
  String educationText;
  String countryId;
  String countryCode;
  String locationId;
  dynamic permanentLocationId;
  dynamic locationName;
  String stateId;
  dynamic stateCode;
  String districtId;
  dynamic districtName;
  String familyType;
  String birthPlace;
  String birthTime;
  String gothram;
  String zodiac;
  String star;
  String dosham;
  String profileDataAvatar;
  String avatar;
  String hasAvatar;
  String maritalStatus;
  String physicalStatus;
  String isVerified;
  dynamic verifiedAt;
  String motherTongueId;
  String religionId;
  String isPrimaryProfile;
  String email;
  String isEmailVerified;
  String uploadedHoroscope;
  dynamic generatedHoroscope;
  String primaryHoroscope;
  String visibleToAll;
  String protectPhoto;
  String isAgree;
  dynamic subscribedAstropackId;
  String subscribedPlan;
  String createdAt;
  dynamic updatedAt;

  factory LogActivityProfileData.fromJson(Map<String, dynamic> json) {
    return LogActivityProfileData(
      profileId: json["profile_id"] ?? '',
      userId: json["user_id"] ?? '',
      aboutMe: json["about_me"] ?? '',
      salary: json["salary"] ?? '',
      profileNo: json["profile_no"] ?? '',
      isFreeProfile: json["is_free_profile"] ?? '',
      createdBy: json["created_by"] ?? '',
      userName: json["user_name"] ?? '',
      initialName: json["initial_name"] ?? '',
      surName: json["sur_name"] ?? '',
      gender: json["gender"] ?? '',
      profileViewCount: json["profile_view_count"] ?? '',
      profileStep: json["profile_step"] ?? '',
      casteId: json["caste_id"] ?? '',
      subCasteId: json["sub_caste_id"] ?? '',
      height: json["height"] ?? '',
      weight: json["weight"] ?? '',
      familyValues: json["family_values"] ?? '',
      fatherName: json["father_name"] ?? '',
      motherName: json["mother_name"] ?? '',
      sibiling: json["sibiling"] ?? '',
      companyName: json["company_name"] ?? '',
      mobileNumber: json["mobile_number"] ?? '',
      dateOfBirth: json["date_of_birth"] ?? '',
      professionId: json["profession_id"] ?? '',
      subscribedPremiumId: json["subscribed_premium_id"] ?? '',
      showInterestAcceptedProfile: json["show_interest_accepted_profile"] ?? '',
      professionText: json["profession_text"] ?? '',
      educationId: json["education_id"] ?? '',
      educationText: json["education_text"] ?? '',
      countryId: json["country_id"] ?? '',
      countryCode: json["country_code"] ?? '',
      locationId: json["location_id"] ?? '',
      permanentLocationId: json["permanent_location_id"] ?? '',
      locationName: json["location_name"] ?? '',
      stateId: json["state_id"] ?? '',
      stateCode: json["state_code"] ?? '',
      districtId: json["district_id"] ?? '',
      districtName: json["district_name"] ?? '',
      familyType: json["family_type"] ?? '',
      birthPlace: json["birth_place"] ?? '',
      birthTime: json["birth_time"] ?? '',
      gothram: json["gothram"] ?? '',
      zodiac: json["zodiac"] ?? '',
      star: json["star"] ?? '',
      dosham: json["dosham"] ?? '',
      profileDataAvatar: json["avatar"] ?? '',
      avatar: json["_avatar"] ?? '',
      hasAvatar: json["has_avatar"] ?? '',
      maritalStatus: json["marital_status"] ?? '',
      physicalStatus: json["physical_status"] ?? '',
      isVerified: json["is_verified"] ?? '',
      verifiedAt: json["verified_at"] ?? '',
      motherTongueId: json["mother_tongue_id"] ?? '',
      religionId: json["religion_id"] ?? '',
      isPrimaryProfile: json["is_primary_profile"] ?? '',
      email: json["email"] ?? '',
      isEmailVerified: json["is_email_verified"] ?? '',
      uploadedHoroscope: json["uploaded_horoscope"] ?? '',
      generatedHoroscope: json["generated_horoscope"] ?? '',
      primaryHoroscope: json["primary_horoscope"] ?? '',
      visibleToAll: json["visible_to_all"] ?? '',
      protectPhoto: json["protect_photo"] ?? '',
      isAgree: json["is_agree"] ?? '',
      subscribedAstropackId: json["subscribed_astropack_id"] ?? '',
      subscribedPlan: json["subscribed_plan"] ?? '',
      createdAt: json["created_at"] ?? '',
      updatedAt: json["updated_at"] ?? '',
    );
  }
}

class ProfileDeleteLogout {
  ProfileDeleteLogout({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory ProfileDeleteLogout.fromJson(Map<String, dynamic> json) {
    return ProfileDeleteLogout(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class UpdateEmail {
  UpdateEmail({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory UpdateEmail.fromJson(Map<String, dynamic> json) {
    return UpdateEmail(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}
class VerifyEmail {
  VerifyEmail({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory VerifyEmail.fromJson(Map<String, dynamic> json) {
    return VerifyEmail(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}