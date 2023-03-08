import 'package:myshubamuhurtham/MyComponents/my_components.dart';

class MyProfileData {
  MyProfileData({
    required this.status,
    required this.message,
  });

  bool status;
  List<MyProfileMessage> message;

  factory MyProfileData.fromJson(Map<String, dynamic> json) => MyProfileData(
        status: json["status"] ?? '',
        message: json["message"] == ''
            ? []
            : List<MyProfileMessage>.from(
                json["message"].map((x) => MyProfileMessage.fromJson(x))),
      );
}

class MyProfileMessage {
  MyProfileMessage({
    required this.profileId,
    required this.age,
    required this.userId,
    required this.profileNo,
    required this.isFreeProfile,
    required this.subscribedPremiumId,
    required this.subscribedPremiumCount,
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
    required this.mobileNumber,
    required this.sibiling,
    required this.companyName,
    required this.dateOfBirth,
    required this.professionId,
    required this.aboutMe,
    required this.salary,
    required this.educationId,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.wrkLocation,
    required this.wrkAbrLocation,
    required this.permanentLocationId,
    required this.familyType,
    required this.birthPlace,
    required this.birthTime,
    required this.gothram,
    required this.zodiac,
    required this.star,
    required this.dosham,
    required this.avatar,
    required this.maritalStatus,
    required this.physicalStatus,
    required this.motherTongueId,
    required this.jobTitle,
    required this.religionId,
    required this.isVerified,
    required this.verifiedAt,
    required this.isSuspended,
    required this.suspendedAt,
    required this.isPrimaryProfile,
    required this.email,
    required this.isEmailVerified,
    required this.horoscopeVeirfiedAt,
    required this.uploadedHoroscope,
    required this.generatedHoroscope,
    required this.primaryHoroscope,
    required this.visibleToAll,
    required this.protectPhoto,
    required this.showInterestAcceptedProfile,
    required this.isAgree,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedStatus,
    required this.deletedAt,
    required this.subscribedAstropackId,
    required this.refferId,
    required this.promotionCode,
    required this.createdByColumn,
    required this.fcmToken,
    required this.partnerPreferencesId,
    required this.partnerPreferencesCreatedAt,
    required this.partnerPreferencesUpdatedAt,
    required this.partnerPreferencesCreatedById,
    required this.partnerPreferencesProfileId,
    required this.partnerPreferencesFromAge,
    required this.partnerPreferencesToAge,
    required this.partnerPreferencesFromHeight,
    required this.partnerPreferencesToHeight,
    required this.partnerPreferencesPhysicalStatus,
    required this.partnerPreferencesFamilyType,
    required this.partnerPreferencesMotherTongues,
    required this.partnerPreferencesSubCastes,
    required this.partnerPreferencesReligionId,
    required this.partnerPreferencesCountries,
    required this.partnerPreferencesStates,
    required this.partnerPreferencesNativePlaces,
    required this.partnerPreferencesWrkLocations,
    required this.partnerPreferencesWrkAbrLocations,
    required this.partnerPreferencesEducations,
    required this.partnerPreferencesOccupations,
    required this.partnerPreferencesIsCasteNoBar,
    required this.partnerPreferencesMaritalStatuses,
    required this.partnerPreferencesAnnualIncome,
    required this.partnerPreferencesAboutPartner,
    required this.hasEncode,
  });

  String profileId;
  String age;
  String userId;
  String profileNo;
  String isFreeProfile;
  dynamic subscribedPremiumId;
  dynamic subscribedPremiumCount;
  String createdBy;
  String userName;
  String initialName;
  String surName;
  String gender;
  dynamic profileViewCount;
  String profileStep;
  String casteId;
  String subCasteId;
  String height;
  String weight;
  String familyValues;
  dynamic fatherName;
  dynamic motherName;
  String mobileNumber;
  dynamic sibiling;
  dynamic companyName;
  String dateOfBirth;
  String professionId;
  dynamic aboutMe;
  dynamic salary;
  String educationId;
  String countryId;
  String stateId;
  String districtId;
  dynamic wrkLocation;
  dynamic wrkAbrLocation;
  dynamic permanentLocationId;
  String familyType;
  String birthPlace;
  String birthTime;
  String gothram;
  String zodiac;
  String star;
  String dosham;
  String avatar;
  String maritalStatus;
  String physicalStatus;
  String motherTongueId;
  dynamic jobTitle;
  String religionId;
  String isVerified;
  dynamic verifiedAt;
  String isSuspended;
  dynamic suspendedAt;
  String isPrimaryProfile;
  dynamic email;
  String isEmailVerified;
  dynamic horoscopeVeirfiedAt;
  dynamic uploadedHoroscope;
  dynamic generatedHoroscope;
  dynamic primaryHoroscope;
  String visibleToAll;
  String protectPhoto;
  dynamic showInterestAcceptedProfile;
  String isAgree;
  String createdAt;
  dynamic updatedAt;
  String deletedStatus;
  dynamic deletedAt;
  dynamic subscribedAstropackId;
  dynamic refferId;
  dynamic promotionCode;
  dynamic createdByColumn;
  String fcmToken;
  String partnerPreferencesId;
  String partnerPreferencesCreatedAt;
  dynamic partnerPreferencesUpdatedAt;
  String partnerPreferencesCreatedById;
  String partnerPreferencesProfileId;
  dynamic partnerPreferencesFromAge;
  dynamic partnerPreferencesToAge;
  dynamic partnerPreferencesFromHeight;
  dynamic partnerPreferencesToHeight;
  String partnerPreferencesPhysicalStatus;
  dynamic partnerPreferencesFamilyType;
  dynamic partnerPreferencesMotherTongues;
  dynamic partnerPreferencesSubCastes;
  dynamic partnerPreferencesReligionId;
  dynamic partnerPreferencesCountries;
  dynamic partnerPreferencesStates;
  dynamic partnerPreferencesNativePlaces;
  dynamic partnerPreferencesWrkLocations;
  dynamic partnerPreferencesWrkAbrLocations;
  dynamic partnerPreferencesEducations;
  dynamic partnerPreferencesOccupations;
  String partnerPreferencesIsCasteNoBar;
  dynamic partnerPreferencesMaritalStatuses;
  dynamic partnerPreferencesAnnualIncome;
  dynamic partnerPreferencesAboutPartner;
  String hasEncode;

  factory MyProfileMessage.fromJson(Map<String, dynamic> json) =>
      MyProfileMessage(
        profileId: json["profile_id"] ?? '',
        age: json["age"] ?? '',
        userId: json["user_id"] ?? '',
        profileNo: json["profile_no"] ?? '',
        isFreeProfile: json["is_free_profile"] ?? '',
        subscribedPremiumId: json["subscribed_premium_id"] ?? '',
        subscribedPremiumCount: json["subscribed_premium_count"] ?? '',
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
        mobileNumber: json["mobile_number"] ?? '',
        sibiling: json["sibiling"] ?? '',
        companyName: json["company_name"] ?? '',
        dateOfBirth: json["date_of_birth"] ?? '',
        professionId: json["profession_id"] ?? '',
        aboutMe: json["about_me"] ?? '',
        salary: json["salary"] ?? '',
        educationId: json["education_id"] ?? '',
        countryId: json["country_id"] ?? '',
        stateId: json["state_id"] ?? '',
        districtId: json["district_id"] ?? '',
        wrkLocation: json["wrk_location"] ?? '',
        wrkAbrLocation: json["wrk_abr_location"] ?? '',
        permanentLocationId: json["permanent_location_id"] ?? '',
        familyType: json["family_type"] ?? '',
        birthPlace: json["birth_place"] ?? '',
        birthTime: json["birth_time"] ?? '',
        gothram: json["gothram"] ?? '',
        zodiac: json["zodiac"] ?? '',
        star: json["star"] ?? '',
        dosham: json["dosham"] ?? '',
        avatar: json["avatar"] == null || json["avatar"].toString().isEmpty
            ? ''
            : '${MyComponents.imageBaseUrl}/${json["has_encode"]}/${json["avatar"]}',
        maritalStatus: json["marital_status"] ?? '',
        physicalStatus: json["physical_status"] ?? '',
        motherTongueId: json["mother_tongue_id"] ?? '',
        jobTitle: json["job_title"] ?? '',
        religionId: json["religion_id"] ?? '',
        isVerified: json["is_verified"] ?? '',
        verifiedAt: json["verified_at"],
        isSuspended: json["is_suspended"] ?? '',
        suspendedAt: json["suspended_at"] ?? '',
        isPrimaryProfile: json["is_primary_profile"] ?? '',
        email: json["email"] ?? '',
        isEmailVerified: json["is_email_verified"] ?? '',
        horoscopeVeirfiedAt: json["horoscope_veirfied_at"] ?? '',
        uploadedHoroscope: json["uploaded_horoscope"] ?? '',
        generatedHoroscope: json["generated_horoscope"] ?? '',
        primaryHoroscope: json["primary_horoscope"] ?? '',
        visibleToAll: json["visible_to_all"] ?? '',
        protectPhoto: json["protect_photo"] ?? '',
        showInterestAcceptedProfile:
            json["show_interest_accepted_profile"] ?? '',
        isAgree: json["is_agree"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        subscribedAstropackId: json["subscribed_astropack_id"] ?? '',
        refferId: json["reffer_id"] ?? '',
        promotionCode: json["promotion_code"] ?? '',
        createdByColumn: json["created_by_column"] ?? '',
        fcmToken: json["fcm_token"] ?? '',
        partnerPreferencesId: json["partner_preferences_id"] ?? '',
        partnerPreferencesCreatedAt:
            json["partner_preferences_created_at"] ?? '',
        partnerPreferencesUpdatedAt:
            json["partner_preferences_updated_at"] ?? '',
        partnerPreferencesCreatedById:
            json["partner_preferences_created_by_id"] ?? '',
        partnerPreferencesProfileId:
            json["partner_preferences_profile_id"] ?? '',
        partnerPreferencesFromAge: json["partner_preferences_from_age"] ?? '',
        partnerPreferencesToAge: json["partner_preferences_to_age"] ?? '',
        partnerPreferencesFromHeight:
            json["partner_preferences_from_height"] ?? '',
        partnerPreferencesToHeight: json["partner_preferences_to_height"] ?? '',
        partnerPreferencesPhysicalStatus:
            json["partner_preferences_physical_status"] ?? '',
        partnerPreferencesFamilyType:
            json["partner_preferences_family_type"] ?? '',
        partnerPreferencesMotherTongues:
            json["partner_preferences_mother_tongues"] ?? '',
        partnerPreferencesSubCastes:
            json["partner_preferences_sub_castes"] ?? '',
        partnerPreferencesReligionId:
            json["partner_preferences_religion_id"] ?? '',
        partnerPreferencesCountries:
            json["partner_preferences_countries"] ?? '',
        partnerPreferencesStates: json["partner_preferences_states"] ?? '',
        partnerPreferencesNativePlaces:
            json["partner_preferences_native_places"] ?? '',
        partnerPreferencesWrkLocations:
            json["partner_preferences_wrk_locations"] ?? '',
        partnerPreferencesWrkAbrLocations:
            json["partner_preferences_wrk_abr_locations"] ?? '',
        partnerPreferencesEducations:
            json["partner_preferences_educations"] ?? '',
        partnerPreferencesOccupations:
            json["partner_preferences_occupations"] ?? '',
        partnerPreferencesIsCasteNoBar:
            json["partner_preferences_is_caste_no_bar"] ?? '',
        partnerPreferencesMaritalStatuses:
            json["partner_preferences_marital_statuses"] ?? '',
        partnerPreferencesAnnualIncome:
            json["partner_preferences_annual_income"] ?? '',
        partnerPreferencesAboutPartner:
            json["partner_preferences_about_partner"] ?? '',
        hasEncode: json["has_encode"] ?? '',
      );
}

class SearchProfileList {
  SearchProfileList({
    required this.status,
    required this.message,
  });

  bool status;
  List<SearchProfileMessage> message;

  factory SearchProfileList.fromJson(Map<String, dynamic> json) =>
      SearchProfileList(
        status: json["status"] ?? false,
        message: json["message"] == null
            ? []
            : List<SearchProfileMessage>.from(
                json["message"].map((x) => SearchProfileMessage.fromJson(x))),
      );
}

class SearchProfileMessage {
  SearchProfileMessage({
    required this.isSaved,
    required this.isInterestSent,
    required this.isOppInterestSent,
    required this.justViewedId,
    required this.profileId,
    required this.userId,
    required this.profileNo,
    required this.isFreeProfile,
    required this.createdBy,
    required this.initialName,
    required this.userName,
    required this.surName,
    required this.gender,
    required this.age,
    required this.dateOfBirth,
    required this.casteId,
    required this.subCasteId,
    required this.height,
    required this.weight,
    required this.familyValues,
    required this.familyType,
    required this.fatherName,
    required this.motherName,
    required this.mobileNumber,
    required this.sibiling,
    required this.educationId,
    required this.educationText,
    required this.jobTitle,
    required this.professionId,
    required this.companyName,
    required this.salary,
    required this.countryId,
    required this.countryCode,
    required this.stateId,
    required this.stateCode,
    required this.districtId,
    required this.districtName,
    required this.aboutMe,
    required this.wrkLocationId,
    required this.wrkLocationName,
    required this.wrkAbrLocationId,
    required this.birthPlace,
    required this.birthTime,
    required this.gothram,
    required this.zodiac,
    required this.star,
    required this.dosham,
    required this.messageAvatar,
    required this.avatar,
    required this.hasAvatar,
    required this.maritalStatus,
    required this.physicalStatus,
    required this.isVerified,
    required this.verifiedAt,
    required this.isSuspended,
    required this.suspendedAt,
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
    required this.showInterestAcceptedProfile,
    required this.isAgree,
    required this.createdAt,
    required this.updatedAt,
    required this.disclaimerCondition,
    required this.disclaimerStep2Condition,
    required this.disclaimerConditionForEdit,
    required this.profileInterestId,
    required this.senderProfileId,
    required this.receiverProfileId,
    required this.interestStatus,
    required this.showProfileStatus,
    required this.sentAt,
    required this.statusUpdatedAt,
    required this.partnerPreferencesId,
    required this.partnerPreferencesProfileId,
    required this.partnerPreferencesFromAge,
    required this.partnerPreferencesToAge,
    required this.partnerPreferencesFromHeight,
    required this.partnerPreferencesToHeight,
    required this.partnerPreferencesPhysicalStatus,
    required this.partnerPreferencesFamilyType,
    required this.partnerPreferencesMotherTongues,
    required this.partnerPreferencesSubCastes,
    required this.partnerPreferencesReligionId,
    required this.partnerPreferencesWrkLocations,
    required this.partnerPreferencesWrkAbrLocations,
    required this.partnerPreferencesCountries,
    required this.partnerPreferencesStates,
    required this.partnerPreferencesNativePlaces,
    required this.partnerPreferencesEducations,
    required this.partnerPreferencesOccupations,
    required this.partnerPreferencesIsCasteNoBar,
    required this.partnerPreferencesMaritalStatuses,
    required this.partnerPreferencesAnnualIncome,
    required this.partnerPreferencesAboutPartner,
    required this.partnerPreferencesCreatedById,
    required this.partnerPreferencesCreatedAt,
    required this.partnerPreferencesUpdatedAt,
    required this.profileViewCount,
    required this.subscribedPremiumId,
    required this.subscribedPremiumCount,
    required this.hasEncode,
  });

  int isSaved;
  int isInterestSent;
  int isOppInterestSent;
  String justViewedId;
  String profileId;
  String userId;
  String profileNo;
  String isFreeProfile;
  String createdBy;
  String initialName;
  String userName;
  String surName;
  String gender;
  String age;
  String dateOfBirth;
  String casteId;
  String subCasteId;
  String height;
  String weight;
  String familyValues;
  String familyType;
  String fatherName;
  String motherName;
  String mobileNumber;
  String sibiling;
  String educationId;
  String educationText;
  String jobTitle;
  String professionId;
  String companyName;
  String salary;
  String countryId;
  dynamic countryCode;
  String stateId;
  String stateCode;
  String districtId;
  String districtName;
  String aboutMe;
  String wrkLocationId;
  String wrkLocationName;
  String wrkAbrLocationId;
  String birthPlace;
  String birthTime;
  String gothram;
  String zodiac;
  String star;
  String dosham;
  String messageAvatar;
  String avatar;
  String hasAvatar;
  String maritalStatus;
  String physicalStatus;
  String isVerified;
  String verifiedAt;
  String isSuspended;
  dynamic suspendedAt;
  String motherTongueId;
  String religionId;
  String isPrimaryProfile;
  String email;
  String isEmailVerified;
  dynamic uploadedHoroscope;
  dynamic generatedHoroscope;
  String primaryHoroscope;
  String visibleToAll;
  String protectPhoto;
  dynamic showInterestAcceptedProfile;
  String isAgree;
  String createdAt;
  dynamic updatedAt;
  dynamic disclaimerCondition;
  dynamic disclaimerStep2Condition;
  String disclaimerConditionForEdit;
  dynamic profileInterestId;
  dynamic senderProfileId;
  dynamic receiverProfileId;
  dynamic interestStatus;
  dynamic showProfileStatus;
  dynamic sentAt;
  dynamic statusUpdatedAt;
  String partnerPreferencesId;
  String partnerPreferencesProfileId;
  String partnerPreferencesFromAge;
  String partnerPreferencesToAge;
  String partnerPreferencesFromHeight;
  String partnerPreferencesToHeight;
  String partnerPreferencesPhysicalStatus;
  String partnerPreferencesFamilyType;
  String partnerPreferencesMotherTongues;
  dynamic partnerPreferencesSubCastes;
  String partnerPreferencesReligionId;
  String partnerPreferencesWrkLocations;
  String partnerPreferencesWrkAbrLocations;
  String partnerPreferencesCountries;
  String partnerPreferencesStates;
  String partnerPreferencesNativePlaces;
  String partnerPreferencesEducations;
  String partnerPreferencesOccupations;
  String partnerPreferencesIsCasteNoBar;
  String partnerPreferencesMaritalStatuses;
  String partnerPreferencesAnnualIncome;
  String partnerPreferencesAboutPartner;
  String partnerPreferencesCreatedById;
  String partnerPreferencesCreatedAt;
  dynamic partnerPreferencesUpdatedAt;
  dynamic profileViewCount;
  dynamic subscribedPremiumId;
  dynamic subscribedPremiumCount;
  String hasEncode;

  factory SearchProfileMessage.fromJson(Map<String, dynamic> json) =>
      SearchProfileMessage(
        isSaved: json["is_saved"] ?? 0,
        isInterestSent: json["is_interest_sent"] ?? '',
        isOppInterestSent: json["is_opp_interest_sent"] ?? '',
        justViewedId: json["just_viewed_id"] ?? '',
        profileId: json["profile_id"] ?? '',
        userId: json["user_id"] ?? '',
        profileNo: json["profile_no"] ?? '',
        isFreeProfile: json["is_free_profile"] ?? '',
        createdBy: json["created_by"] ?? '',
        initialName: json["initial_name"] ?? '',
        userName: json["user_name"] ?? '',
        surName: json["sur_name"] ?? '',
        gender: json["gender"] ?? '',
        age: json["age"] ?? '',
        dateOfBirth: json["date_of_birth"] ?? '',
        casteId: json["caste_id"] ?? '',
        subCasteId: json["sub_caste_id"] ?? '',
        height: json["height"] ?? '',
        weight: json["weight"] ?? '',
        familyValues: json["family_values"] ?? '',
        familyType: json["family_type"] ?? '',
        fatherName: json["father_name"] ?? '',
        motherName: json["mother_name"] ?? '',
        mobileNumber: json["mobile_number"] ?? '',
        sibiling: json["sibiling"] ?? '',
        educationId: json["education_id"] ?? '',
        educationText: json["education_text"] ?? '',
        jobTitle: json["job_title"] ?? '',
        professionId: json["profession_id"] ?? '',
        companyName: json["company_name"] ?? '',
        salary: json["salary"] ?? '',
        countryId: json["country_id"] ?? '',
        countryCode: json["country_code"] ?? '',
        stateId: json["state_id"] ?? '',
        stateCode: json["state_code"] ?? '',
        districtId: json["district_id"] ?? '',
        districtName: json["district_name"] ?? '',
        aboutMe: json["about_me"] ?? '',
        wrkLocationId: json["wrk_location_id"] ?? '',
        wrkLocationName: json["wrk_location_name"] ?? '',
        wrkAbrLocationId: json["wrk_abr_location_id"] ?? '',
        birthPlace: json["birth_place"] ?? '',
        birthTime: json["birth_time"] ?? '',
        gothram: json["gothram"] ?? '',
        zodiac: json["zodiac"] ?? '',
        star: json["star"] ?? '',
        dosham: json["dosham"] ?? '',
        messageAvatar: json["avatar"] == null ||
                json["avatar"].toString().isEmpty
            ? ''
            : '${MyComponents.imageBaseUrl}/${json["has_encode"]}/${json["avatar"]}',
        avatar: json["_avatar"] ?? '',
        hasAvatar: json["has_avatar"] ?? '',
        maritalStatus: json["marital_status"] ?? '',
        physicalStatus: json["physical_status"] ?? '',
        isVerified: json["is_verified"] ?? '',
        verifiedAt: json["verified_at"] ?? '',
        isSuspended: json["is_suspended"] ?? '',
        suspendedAt: json["suspended_at"] ?? '',
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
        showInterestAcceptedProfile:
            json["show_interest_accepted_profile"] ?? '',
        isAgree: json["is_agree"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        disclaimerCondition: json["disclaimer_condition"] ?? '',
        disclaimerStep2Condition: json["disclaimer_step2_condition"] ?? '',
        disclaimerConditionForEdit: json["disclaimer_condition_for_edit"] ?? '',
        profileInterestId: json["profile_interest_id"] ?? '',
        senderProfileId: json["sender_profile_id"] ?? '',
        receiverProfileId: json["receiver_profile_id"] ?? '',
        interestStatus: json["interest_status"] ?? '',
        showProfileStatus: json["show_profile_status"] ?? '',
        sentAt: json["sent_at"] ?? '',
        statusUpdatedAt: json["status_updated_at"] ?? '',
        partnerPreferencesId: json["partner_preferences_id"] ?? '',
        partnerPreferencesProfileId:
            json["partner_preferences_profile_id"] ?? '',
        partnerPreferencesFromAge: json["partner_preferences_from_age"] ?? '',
        partnerPreferencesToAge: json["partner_preferences_to_age"] ?? '',
        partnerPreferencesFromHeight:
            json["partner_preferences_from_height"] ?? '',
        partnerPreferencesToHeight: json["partner_preferences_to_height"] ?? '',
        partnerPreferencesPhysicalStatus:
            json["partner_preferences_physical_status"] ?? '',
        partnerPreferencesFamilyType:
            json["partner_preferences_family_type"] ?? '',
        partnerPreferencesMotherTongues:
            json["partner_preferences_mother_tongues"] ?? '',
        partnerPreferencesSubCastes:
            json["partner_preferences_sub_castes"] ?? '',
        partnerPreferencesReligionId:
            json["partner_preferences_religion_id"] ?? '',
        partnerPreferencesWrkLocations:
            json["partner_preferences_wrk_locations"] ?? '',
        partnerPreferencesWrkAbrLocations:
            json["partner_preferences_wrk_abr_locations"] ?? '',
        partnerPreferencesCountries:
            json["partner_preferences_countries"] ?? '',
        partnerPreferencesStates: json["partner_preferences_states"] ?? '',
        partnerPreferencesNativePlaces:
            json["partner_preferences_native_places"] ?? '',
        partnerPreferencesEducations:
            json["partner_preferences_educations"] ?? '',
        partnerPreferencesOccupations:
            json["partner_preferences_occupations"] ?? '',
        partnerPreferencesIsCasteNoBar:
            json["partner_preferences_is_caste_no_bar"] ?? '',
        partnerPreferencesMaritalStatuses:
            json["partner_preferences_marital_statuses"] ?? '',
        partnerPreferencesAnnualIncome:
            json["partner_preferences_annual_income"] ?? '',
        partnerPreferencesAboutPartner:
            json["partner_preferences_about_partner"] ?? '',
        partnerPreferencesCreatedById:
            json["partner_preferences_created_by_id"] ?? '',
        partnerPreferencesCreatedAt:
            json["partner_preferences_created_at"] ?? '',
        partnerPreferencesUpdatedAt:
            json["partner_preferences_updated_at"] ?? '',
        profileViewCount: json["profile_view_count"] ?? '',
        subscribedPremiumId: json["subscribed_premium_id"] ?? '',
        subscribedPremiumCount: json["subscribed_premium_count"] ?? '',
        hasEncode: json["has_encode"] ?? '',
      );
}

class CountDetails {
  CountDetails({
    required this.status,
    required this.message,
  });

  bool status;
  CountDetailMessage message;

  factory CountDetails.fromJson(Map<String, dynamic> json) => CountDetails(
        status: json["status"] ?? false,
        message: CountDetailMessage.fromJson(json["message"]),
      );
}

class CountDetailMessage {
  CountDetailMessage({
    required this.detailViewCount,
    required this.noOfHoroscopeViews,
    required this.horoscopeCompatibility,
    required this.noOfSendInterest,
    required this.balanceDays,
  });

  int detailViewCount;
  int noOfHoroscopeViews;
  int horoscopeCompatibility;
  int noOfSendInterest;
  int balanceDays;

  factory CountDetailMessage.fromJson(Map<String, dynamic> json) =>
      CountDetailMessage(
        detailViewCount: json["detail_view_count"] ?? 0,
        noOfHoroscopeViews: json["no_of_horoscope_views"] ?? 0,
        horoscopeCompatibility: json["horoscope_compatibility"] ?? 0,
        noOfSendInterest: json["no_of_send_interest"] ?? 0,
        balanceDays: json["balannce_days"] ?? 0,
      );
}

class AddCountDetailProfile {
  AddCountDetailProfile({
    required this.status,
    required this.message,
  });

  bool status;
  dynamic message;

  factory AddCountDetailProfile.fromJson(Map<String, dynamic> json) =>
      AddCountDetailProfile(
        status: json["status"] ?? false,
        message: json["message"].toString(),
      );
}
