class InvoiceHistory {
  InvoiceHistory({
    required this.status,
    required this.message,
  });

  bool status;
  InvoiceHistoryMessage message;

  factory InvoiceHistory.fromJson(Map<String, dynamic> json) => InvoiceHistory(
        status: json["status"] ?? false,
        message: InvoiceHistoryMessage.fromJson(json["message"]),
      );
}

class InvoiceHistoryMessage {
  InvoiceHistoryMessage({
    required this.profileData,
    required this.invoiceData,
  });

  List<ProfileDatum> profileData;
  List<InvoiceDatum> invoiceData;

  factory InvoiceHistoryMessage.fromJson(Map<String, dynamic> json) =>
      InvoiceHistoryMessage(
        profileData: json["profile_data"] == null
            ? []
            : List<ProfileDatum>.from(
                json["profile_data"].map((x) => ProfileDatum.fromJson(x))),
        invoiceData: json["invoice_data"] == null
            ? []
            : List<InvoiceDatum>.from(
                json["invoice_data"].map((x) => InvoiceDatum.fromJson(x))),
      );
}

class InvoiceDatum {
  InvoiceDatum({
    required this.id,
    required this.profileNo,
    required this.firstname,
    required this.phone,
    required this.email,
    required this.amount,
    required this.status,
    required this.txnid,
    required this.subsribedDate,
    required this.productinfo,
  });

  String id;
  String profileNo;
  String firstname;
  String phone;
  String email;
  String amount;
  String status;
  String txnid;
  String subsribedDate;
  String productinfo;

  factory InvoiceDatum.fromJson(Map<String, dynamic> json) => InvoiceDatum(
        id: json["id"] ?? '',
        profileNo: json["profile_no"] ?? '',
        firstname: json["firstname"] ?? '',
        phone: json["phone"] ?? '',
        email: json["email"] ?? '',
        amount: json["amount"] ?? '',
        status: json["status"] ?? '',
        txnid: json["txnid"] ?? '',
        subsribedDate: json["subsribed_date"] ?? '',
        productinfo: json["productinfo"] ?? '',
      );
}

class ProfileDatum {
  ProfileDatum({
    required this.profileId,
    required this.age,
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
    required this.mobileNumber,
    required this.sibiling,
    required this.companyName,
    required this.dateOfBirth,
    required this.professionId,
    required this.subscribedPremiumId,
    required this.subscribedPremiumCount,
    required this.educationId,
    required this.countryId,
    required this.locationId,
    required this.permanentLocationId,
    required this.stateId,
    required this.districtId,
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
    required this.isVerified,
    required this.verifiedAt,
    required this.isSuspended,
    required this.suspendedAt,
    required this.motherTongueId,
    required this.religionId,
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
    required this.wrkAbrCountry,
    required this.refferId,
    required this.promotionCode,
    required this.jobTitle,
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
    required this.partnerPreferencesLocations,
    required this.partnerPreferencesCountries,
    required this.partnerPreferencesStates,
    required this.partnerPreferencesNativePlaces,
    required this.partnerPreferencesEducations,
    required this.partnerPreferencesOccupations,
    required this.partnerPreferencesIsCasteNoBar,
    required this.partnerPreferencesMaritalStatuses,
    required this.partnerPreferencesAnnualIncome,
    required this.partnerPreferencesAboutPartner,
    required this.partnerPreferencesCreatedAt,
    required this.partnerPreferencesUpdatedAt,
    required this.partnerPreferencesCreatedById,
    required this.partnerPreferencesWrkAbrCountry,
  });

  String profileId;
  String age;
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
  dynamic profileViewCount;
  String profileStep;
  String casteId;
  String subCasteId;
  String height;
  String weight;
  String familyValues;
  String fatherName;
  String motherName;
  String mobileNumber;
  String sibiling;
  String companyName;
  String dateOfBirth;
  String professionId;
  String subscribedPremiumId;
  String subscribedPremiumCount;
  String educationId;
  String countryId;
  String locationId;
  dynamic permanentLocationId;
  String stateId;
  String districtId;
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
  String isVerified;
  String verifiedAt;
  String isSuspended;
  dynamic suspendedAt;
  String motherTongueId;
  String religionId;
  String isPrimaryProfile;
  String email;
  String isEmailVerified;
  String horoscopeVeirfiedAt;
  String uploadedHoroscope;
  dynamic generatedHoroscope;
  String primaryHoroscope;
  String visibleToAll;
  String protectPhoto;
  dynamic showInterestAcceptedProfile;
  String isAgree;
  String createdAt;
  dynamic updatedAt;
  String deletedStatus;
  String deletedAt;
  dynamic subscribedAstropackId;
  String wrkAbrCountry;
  String refferId;
  String promotionCode;
  String jobTitle;
  String partnerPreferencesId;
  String partnerPreferencesProfileId;
  String partnerPreferencesFromAge;
  String partnerPreferencesToAge;
  String partnerPreferencesFromHeight;
  String partnerPreferencesToHeight;
  String partnerPreferencesPhysicalStatus;
  String partnerPreferencesFamilyType;
  String partnerPreferencesMotherTongues;
  String partnerPreferencesSubCastes;
  String partnerPreferencesReligionId;
  String partnerPreferencesLocations;
  String partnerPreferencesCountries;
  String partnerPreferencesStates;
  String partnerPreferencesNativePlaces;
  String partnerPreferencesEducations;
  String partnerPreferencesOccupations;
  String partnerPreferencesIsCasteNoBar;
  String partnerPreferencesMaritalStatuses;
  String partnerPreferencesAnnualIncome;
  String partnerPreferencesAboutPartner;
  String partnerPreferencesCreatedAt;
  dynamic partnerPreferencesUpdatedAt;
  String partnerPreferencesCreatedById;
  String partnerPreferencesWrkAbrCountry;

  factory ProfileDatum.fromJson(Map<String, dynamic> json) => ProfileDatum(
        profileId: json["profile_id"] ?? '',
        age: json["age"] ?? '',
        userId: json["user_id"] ?? '',
        aboutMe: json["about_me"],
        salary: json["salary"] ?? '',
        profileNo: json["profile_no"] ?? '',
        isFreeProfile: json["is_free_profile"] ?? '',
        createdBy: json["created_by"] ?? '',
        userName: json["user_name"] ?? '',
        initialName: json["initial_name"] ?? '',
        surName: json["sur_name"] ?? '',
        gender: json["gender"] ?? '',
        profileViewCount: json["profile_view_count"],
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
        subscribedPremiumId: json["subscribed_premium_id"] ?? '',
        subscribedPremiumCount: json["subscribed_premium_count"] ?? '',
        educationId: json["education_id"] ?? '',
        countryId: json["country_id"] ?? '',
        locationId: json["location_id"] ?? '',
        permanentLocationId: json["permanent_location_id"],
        stateId: json["state_id"] ?? '',
        districtId: json["district_id"] ?? '',
        familyType: json["family_type"] ?? '',
        birthPlace: json["birth_place"] ?? '',
        birthTime: json["birth_time"] ?? '',
        gothram: json["gothram"] ?? '',
        zodiac: json["zodiac"] ?? '',
        star: json["star"] ?? '',
        dosham: json["dosham"] ?? '',
        avatar: json["avatar"] ?? '',
        maritalStatus: json["marital_status"] ?? '',
        physicalStatus: json["physical_status"] ?? '',
        isVerified: json["is_verified"] ?? '',
        verifiedAt: json["verified_at"] ?? '',
        isSuspended: json["is_suspended"] ?? '',
        suspendedAt: json["suspended_at"],
        motherTongueId: json["mother_tongue_id"] ?? '',
        religionId: json["religion_id"] ?? '',
        isPrimaryProfile: json["is_primary_profile"] ?? '',
        email: json["email"] ?? '',
        isEmailVerified: json["is_email_verified"] ?? '',
        horoscopeVeirfiedAt: json["horoscope_veirfied_at"] ?? '',
        uploadedHoroscope: json["uploaded_horoscope"] ?? '',
        generatedHoroscope: json["generated_horoscope"],
        primaryHoroscope: json["primary_horoscope"] ?? '',
        visibleToAll: json["visible_to_all"] ?? '',
        protectPhoto: json["protect_photo"] ?? '',
        showInterestAcceptedProfile: json["show_interest_accepted_profile"],
        isAgree: json["is_agree"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"],
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        subscribedAstropackId: json["subscribed_astropack_id"],
        wrkAbrCountry: json["wrk_abr_country"] ?? '',
        refferId: json["reffer_id"] ?? '',
        promotionCode: json["promotion_code"] ?? '',
        jobTitle: json["job_title"] ?? '',
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
        partnerPreferencesLocations:
            json["partner_preferences_locations"] ?? '',
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
        partnerPreferencesCreatedAt:
            json["partner_preferences_created_at"] ?? '',
        partnerPreferencesUpdatedAt: json["partner_preferences_updated_at"],
        partnerPreferencesCreatedById:
            json["partner_preferences_created_by_id"] ?? '',
        partnerPreferencesWrkAbrCountry:
            json["partner_preferences_wrk_abr_country"] ?? '',
      );
}
