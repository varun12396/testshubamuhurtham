import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myshubamuhurtham/ApiSection/api_connection.dart';
import 'package:myshubamuhurtham/HelperClass/shared_prefs.dart';
import 'package:myshubamuhurtham/ModelClass/blogs_event_class.dart';
import 'package:myshubamuhurtham/ModelClass/drop_list_class.dart';
import 'package:myshubamuhurtham/ModelClass/horoscope_gallery_class.dart';
import 'package:myshubamuhurtham/ModelClass/interest_class.dart';
import 'package:myshubamuhurtham/ModelClass/invoice_history_class.dart';
import 'package:myshubamuhurtham/ModelClass/login_register_class.dart';
import 'package:myshubamuhurtham/ModelClass/payment_class.dart';
import 'package:myshubamuhurtham/ModelClass/profile_class.dart';
import 'package:myshubamuhurtham/ModelClass/setps_info.dart';
import 'package:myshubamuhurtham/MyComponents/my_components.dart';

class ApiService {
  static Future<List<Country>> getcountry() async {
    final response = await http.get(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}get_country'));
    return countryFromJson(response.body);
  }

  static Future<List<States>> getstates() async {
    var response = await http.get(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}get_state'));
    return statesFromJson(response.body);
  }

  static Future<List<Location>> getlocation() async {
    var response = await http.get(Uri.https(
        ApiConnection.baseurl, '${ApiConnection.apiurl}get_location'));
    return locationFromJson(response.body);
  }

  static Future<List<Height>> getheight() async {
    var response = await http.get(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}get_height'));
    return heightFromJson(response.body);
  }

  static Future<List<Mothertongue>> getmothertongue() async {
    var response = await http.get(Uri.https(
        ApiConnection.baseurl, '${ApiConnection.apiurl}get_mothertongue'));
    return mothertongueFromJson(response.body);
  }

  static Future<List<Religion>> getreligion() async {
    var url =
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}get_religion');
    var response = await http.get(url);
    return religionFromJson(response.body);
  }

  static Future<List<Caste>> getcaste() async {
    var response = await http.get(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}get_caste'));
    return casteFromJson(response.body);
  }

  static Future<List<SubCaste>> getsubcaste() async {
    var response = await http.get(Uri.https(
        ApiConnection.baseurl, '${ApiConnection.apiurl}get_sub_caste'));
    return subCasteFromJson(response.body);
  }

  static Future<List<Education>> geteducation() async {
    var response = await http.get(Uri.https(
        ApiConnection.baseurl, '${ApiConnection.apiurl}get_education'));
    return educationFromJson(response.body);
  }

  static Future<List<Occupation>> getoccupation() async {
    var response = await http.get(Uri.https(
        ApiConnection.baseurl, '${ApiConnection.apiurl}get_occupation'));
    return occupationFromJson(response.body);
  }

  static Future<String> sendFcmNotification(
      String fcmKeyToken, String contentMessage) async {
    var headerData = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Key=${MyComponents.fcmServerKey}',
    };
    var bodyData = jsonEncode({
      "to": fcmKeyToken,
      "notification": {"title": MyComponents.appName, "body": contentMessage}
    });
    final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: headerData,
        body: bodyData);
    return response.body;
  }

  static Future<RegisterOtp> postregister(
      String userName, String mobileNumber, String gender) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}auth_register_otp'),
        body: {
          'name': userName,
          'mobile_number': mobileNumber,
          'gender': gender,
        });
    Map<String, dynamic> data = json.decode(response.body);
    RegisterOtp values = RegisterOtp.fromJson(data);
    return values;
  }

  static Future<LoginOtpVerify> postloginmobileotp(
      String loginType, String mobileNumber, String otpPassword) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}login'),
        body: {
          'login_type': loginType,
          'mobile_number': mobileNumber,
          'password': otpPassword,
          'fcm_token': SharedPrefs.fcmToken,
        });
    Map<String, dynamic> data = json.decode(response.body);
    LoginOtpVerify values = LoginOtpVerify.fromJson(data);
    return values;
  }

  static Future<LoginOtpVerify> postverifyotp(
      String otpcode, String mobilenumber, String otpstatus) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}auth_verify_otp'),
        body: {
          'mobile_number': mobilenumber,
          'otp_code': otpcode,
          'otp_operation': otpstatus,
          'fcm_token': SharedPrefs.fcmToken,
        });
    Map<String, dynamic> data = json.decode(response.body);
    LoginOtpVerify values = LoginOtpVerify.fromJson(data);
    return values;
  }

  static Future<UpdateEmail> postemailverifyotp(
      String otpcode, String emailAddress) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}ev_verify_otp'),
        body: {
          'email': emailAddress,
          'otp_code': otpcode,
          'profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    UpdateEmail values = UpdateEmail.fromJson(data);
    return values;
  }

  static Future<RefferalCode> postRefferalCode(String refferalCode) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}refferal_code'),
        body: {
          'refferal_code': refferalCode,
        });
    Map<String, dynamic> data = json.decode(response.body);
    RefferalCode values = RefferalCode.fromJson(data);
    return values;
  }

  static Future<PromotionCode> postPromotionCode(String promotionCode) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}promotion_code'),
        body: {
          'promotion_code': promotionCode,
        });
    Map<String, dynamic> data = json.decode(response.body);
    PromotionCode values = PromotionCode.fromJson(data);
    return values;
  }

  static Future<BasicStep1> postbasicinformation(
    String promotionCode,
    String refferalCode,
    String profileCreatedBy,
    String initialName,
    String userName,
    String surName,
    String gender,
    String dateOfBirth,
    String maritalStatus,
    String physicalStatus,
    String motherTongueId,
    String religionId,
    String casteId,
    String subCasteId,
    String jobTitle,
    String professionId,
    String companyName,
    String salary,
    String locationId,
    String workLocationId,
    String educationId,
    String countryId,
    String stateId,
    String districtId,
    String height,
    String weight,
    String familyValues,
    String familytype,
    String fatherName,
    String motherName,
    String sibiling,
    String email,
    String password,
    String filepath,
    int isAgree,
  ) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://${ApiConnection.baseurl}${ApiConnection.apiurl}user_register_step1'));
    if (filepath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('avatar', filepath));
    }
    request.fields['user_id'] = SharedPrefs.getUserId;
    request.fields['profile_id'] = SharedPrefs.getProfileId;
    request.fields['promotion_code'] = promotionCode;
    request.fields['reffer_id'] = refferalCode;
    request.fields['created_by'] = profileCreatedBy;
    request.fields['initial_name'] = initialName;
    request.fields['user_name'] = userName;
    request.fields['sur_name'] = surName;
    request.fields['gender'] = gender;
    request.fields['date_of_birth'] = dateOfBirth;
    request.fields['marital_status'] = maritalStatus;
    request.fields['physical_status'] = physicalStatus;
    request.fields['mother_tongue_id'] = motherTongueId;
    request.fields['religion_id'] = religionId;
    request.fields['caste_id'] = casteId;
    request.fields['sub_caste_id'] = subCasteId;
    request.fields['job_title'] = jobTitle;
    request.fields['profession_id'] = professionId;
    request.fields['company_name'] = companyName;
    request.fields['salary'] = salary;
    request.fields['location_id'] = locationId;
    request.fields['wrk_abr_country'] = workLocationId;
    request.fields['education_id'] = educationId;
    request.fields['country_id'] = countryId;
    request.fields['state_id'] = stateId;
    request.fields['district_id'] = districtId;
    request.fields['height'] = height;
    request.fields['weight'] = weight;
    request.fields['family_values'] = familyValues;
    request.fields['family_type'] = familytype;
    request.fields['father_name'] = fatherName;
    request.fields['mother_name'] = motherName;
    request.fields['sibiling'] = sibiling;
    request.fields['is_agree'] = isAgree.toString();

    if (!SharedPrefs.getDashboard) {
      request.fields['profile_step'] = '2';
      request.fields['email'] = email;
      request.fields['password'] = password;
    }

    final res = await request.send();
    final response = await http.Response.fromStream(res);
    Map<String, dynamic> data = json.decode(response.body);
    BasicStep1 values = BasicStep1.fromJson(data);
    return values;
  }

  static Future<BasicStep2> postastrologydetails(
      String birthplace,
      String birthtime,
      String dateofbirth,
      String gothram,
      String zodiac,
      String star,
      String dosham,
      String uploadhoroscope,
      String defaulthoroscope) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://${ApiConnection.baseurl}${ApiConnection.apiurl}user_register_step2'));
    if (uploadhoroscope.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'upload_horoscope', uploadhoroscope));
    }
    request.fields['user_id'] = SharedPrefs.getUserId;
    request.fields['profile_id'] = SharedPrefs.getProfileId;
    request.fields['birth_place'] = birthplace;
    request.fields['birth_time'] = birthtime;
    request.fields['date_of_birth'] = dateofbirth;
    request.fields['gothram'] = gothram;
    request.fields['zodiac'] = zodiac;
    request.fields['star'] = star;
    request.fields['dosham'] = dosham;
    request.fields['default_horoscope'] = defaulthoroscope;

    if (!SharedPrefs.getDashboard) {
      request.fields['profile_step'] = '3';
    }

    final res = await request.send();
    final response = await http.Response.fromStream(res);
    Map<String, dynamic> data = json.decode(response.body);
    BasicStep2 values = BasicStep2.fromJson(data);
    return values;
  }

  static Future<BasicStep3> postpartnerpreference(
    String fromAge,
    String toAge,
    String fromHeight,
    String toHeight,
    String physicalStatus,
    String familyType,
    String motherTongue,
    String annualIncome,
    String religionId,
    String isNoCaste,
    String subCaste,
    String educations,
    String occupations,
    String countries,
    String states,
    String nativeplaces,
    String locations,
    String abroadLocations,
    String maritalStatuses,
    String aboutPartner,
  ) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}user_register_step3'),
        body: SharedPrefs.getDashboard || !SharedPrefs.getStep3Complete
            ? {
                'profile_id': SharedPrefs.getProfileId,
                'from_age': fromAge,
                'to_age': toAge,
                'from_height': fromHeight,
                'to_height': toHeight,
                'physical_status': physicalStatus,
                'family_type': familyType,
                'mother_tongues': motherTongue,
                'annual_income': annualIncome,
                'religion_id': religionId,
                'is_caste_no_bar': isNoCaste,
                'sub_castes': subCaste,
                'educations': educations,
                'occupations': occupations,
                'countries': countries,
                'states': states,
                'native_places': nativeplaces,
                'locations': locations,
                'wrk_abr_country': abroadLocations,
                'marital_statuses': maritalStatuses,
                'about_partner': aboutPartner,
              }
            : {
                'profile_id': SharedPrefs.getProfileId,
                'from_age': fromAge,
                'to_age': toAge,
                'from_height': fromHeight,
                'to_height': toHeight,
                'physical_status': physicalStatus,
                'family_type': familyType,
                'mother_tongues': motherTongue,
                'annual_income': annualIncome,
                'religion_id': religionId,
                'is_caste_no_bar': isNoCaste,
                'sub_castes': subCaste,
                'educations': educations,
                'occupations': occupations,
                'countries': countries,
                'states': states,
                'native_places': nativeplaces,
                'locations': locations,
                'wrk_abr_country': abroadLocations,
                'marital_statuses': maritalStatuses,
                'about_partner': aboutPartner,
                'profile_step': '4',
              });
    Map<String, dynamic> data = json.decode(response.body);
    BasicStep3 values = BasicStep3.fromJson(data);
    return values;
  }

  static Future<BasicStep4> postProfileStepComplete() async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}user_register_step4'),
        body: {
          'profile_id': SharedPrefs.getProfileId,
          'profile_step': '0',
          'fcm_token': SharedPrefs.fcmToken,
        });
    Map<String, dynamic> data = json.decode(response.body);
    BasicStep4 values = BasicStep4.fromJson(data);
    return values;
  }

  static Future<AboutMe> postprofileaboutme(String aboutMe) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}profile_aboutme'),
        body: {
          'user_id': SharedPrefs.getUserId,
          'about_me': aboutMe,
        });
    Map<String, dynamic> data = json.decode(response.body);
    AboutMe values = AboutMe.fromJson(data);
    return values;
  }

  static Future<ChangePassword> postChangePassword(
      String oldpassword, String newpassword, String confirmpassword) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}change_password'),
        body: {
          'user_id': SharedPrefs.getUserId,
          'old_password': oldpassword,
          'new_password': newpassword,
          'confirm_new_password': confirmpassword,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ChangePassword values = ChangePassword.fromJson(data);
    return values;
  }

  static Future<ChangePassword> postForgetPassword(
      String userId, String newpassword, String confirmpassword) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}forgot_password'),
        body: {
          'user_id': userId,
          'new_password': newpassword,
          'confirm_new_password': confirmpassword,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ChangePassword values = ChangePassword.fromJson(data);
    return values;
  }

  static Future<MyProfileData> postprofilelist() async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}profilelist'),
        body: {
          'profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    MyProfileData values = MyProfileData.fromJson(data);
    return values;
  }

  static Future<VerifyEmail> postUpdateVerifyEmail(
      String updateEmailAddress) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}update_verifiy_email_address'),
        body: {
          'user_id': SharedPrefs.getUserId,
          'profile_id': SharedPrefs.getProfileId,
          'email': updateEmailAddress,
        });
    Map<String, dynamic> data = json.decode(response.body);
    VerifyEmail values = VerifyEmail.fromJson(data);
    return values;
  }

  static Future<SearchProfileList> filterprofilelist(
      String profileNo,
      String educationId,
      String fromAge,
      String toAge,
      String isCasteBar,
      String subCasteId,
      String fromHeight,
      String toHeight,
      String star,
      String zodiac,
      String dosham,
      String gallerySettings,
      String maritalStatusesId,
      String horoscope,
      String salary,
      String countryId,
      String stateId,
      String districtId,
      String locationId,
      String wrkAbrCountry,
      String jobTitle,
      String professionId,
      String sortList,
      String offsetLimit) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https(ApiConnection.baseurl,
              '${ApiConnection.apiurl}filter_profile_list'),
          body: {
            'my_profile_id': SharedPrefs.getProfileId,
            'gender': SharedPrefs.getGender == 'M' ? 'F' : 'M',
            'profile_no': profileNo,
            'education_id': educationId,
            'from_age': fromAge,
            'to_age': toAge,
            'is_caste_no_bar': isCasteBar,
            'sub_caste_id': subCasteId,
            'from_height': fromHeight,
            'to_height': toHeight,
            'star': star,
            'zodiac': zodiac,
            'dosham': dosham,
            'gallery_settings': gallerySettings,
            'marital_statuses_id': maritalStatusesId,
            'horoscope': horoscope,
            'salary': salary,
            'country_id': countryId,
            'state_id': stateId,
            'district_id': districtId,
            'location_id': locationId,
            'wrk_abr_country': wrkAbrCountry,
            'job_title': jobTitle,
            'profession_id': professionId,
            'sort_by': sortList,
            'offset_limit': offsetLimit,
            'dprofile_id': '',
            'sender_subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
                ? SharedPrefs.getSubscribeId
                : '0'
          });
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      SearchProfileList values = SearchProfileList.fromJson(data);
      return values;
    } finally {
      client.close();
    }
  }

  static Future<AddCountDetailProfile> addViewDetails(
      String partnerId, String userPrimeCount) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}add_detail_view'),
        body: {
          'sender_profile_id': SharedPrefs.getProfileId,
          'receiver_profile_id': partnerId,
          'subscribed_premium_count':
              userPrimeCount.isEmpty ? '0' : userPrimeCount,
          'subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
              ? SharedPrefs.getSubscribeId
              : '0'
        });
    Map<String, dynamic> data = json.decode(response.body);
    AddCountDetailProfile values = AddCountDetailProfile.fromJson(data);
    return values;
  }

  static Future<AddCountDetailProfile> addViewHoroscopeDetails(
      String partnerId, String userPrimeCount) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}horoscope_view'),
        body: {
          'sender_profile_id': SharedPrefs.getProfileId,
          'receiver_profile_id': partnerId,
          'subscribed_premium_count':
              userPrimeCount.isEmpty ? '0' : userPrimeCount,
          'subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
              ? SharedPrefs.getSubscribeId
              : '0'
        });
    Map<String, dynamic> data = json.decode(response.body);
    AddCountDetailProfile values = AddCountDetailProfile.fromJson(data);
    return values;
  }

  static Future<AddCountDetailProfile> addMatchHoroscopeDetails(
      String partnerId, String userPrimeCount) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}horoscope_match'),
        body: {
          'sender_profile_id': SharedPrefs.getProfileId,
          'receiver_profile_id': partnerId,
          'subscribed_premium_count':
              userPrimeCount.isEmpty ? '0' : userPrimeCount,
          'subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
              ? SharedPrefs.getSubscribeId
              : '0'
        });
    Map<String, dynamic> data = json.decode(response.body);
    AddCountDetailProfile values = AddCountDetailProfile.fromJson(data);
    return values;
  }

  static Future<CountDetails> countListDetails() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}count_list'),
          body: {'profile_id': SharedPrefs.getProfileId});
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      CountDetails values = CountDetails.fromJson(data);
      return values;
    } finally {
      client.close();
    }
  }

  static Future<Motification> notificationList() async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.https(ApiConnection.baseurl,
              '${ApiConnection.apiurl}notification_list'),
          body: {'profile_id': SharedPrefs.getProfileId});
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      Motification values = Motification.fromJson(data);
      return values;
    } finally {
      client.close();
    }
  }

  static Future<InterestSendStatus> postinterestsend(String receiverProfileId,
      String photoStatus, String userPrimeCount) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}sent_interest'),
        body: {
          'sender_profile_id': SharedPrefs.getProfileId,
          'receiver_profile_id': receiverProfileId,
          'subscribed_premium_count':
              userPrimeCount.isEmpty ? '0' : userPrimeCount,
          'photo_status': photoStatus
        });
    Map<String, dynamic> data = json.decode(response.body);
    InterestSendStatus values = InterestSendStatus.fromJson(data);
    return values;
  }

  static Future<InterestSendStatus> postintereststatus(
      String profileInterestId, String status, String rejectReason) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}interest_status'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'my_subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
              ? SharedPrefs.getSubscribeId
              : '0',
          'profile_interest_id': profileInterestId,
          'status': status,
          'reject_reason': rejectReason,
        });
    Map<String, dynamic> data = json.decode(response.body);
    InterestSendStatus values = InterestSendStatus.fromJson(data);
    return values;
  }

  static Future<SearchProfileList> getsenthistory() async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}interests_send_history'),
        body: {'profile_id': SharedPrefs.getProfileId});
    Map<String, dynamic> data = json.decode(response.body);
    SearchProfileList values = SearchProfileList.fromJson(data);
    return values;
  }

  static Future<SearchProfileList> getreceivehistory() async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}interests_received_history'),
        body: {'profile_id': SharedPrefs.getProfileId});
    Map<String, dynamic> data = json.decode(response.body);
    SearchProfileList values = SearchProfileList.fromJson(data);
    return values;
  }

  static Future<RejectedHistoryData> getrejectedhistory() async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}interests_rejected_history'),
        body: {'profile_id': SharedPrefs.getProfileId});
    Map<String, dynamic> data = json.decode(response.body);
    RejectedHistoryData values = RejectedHistoryData.fromJson(data);
    return values;
  }

  static Future<AddRemoveFavorite> postaddremovefavorite(
      String favouritedProfileId) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}add_remove_favourite'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'favourited_profile_id': favouritedProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    AddRemoveFavorite values = AddRemoveFavorite.fromJson(data);
    return values;
  }

  static Future<SearchProfileList> getfavoritesendprofilelist() async {
    var response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}favourite_send_profile_list'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    SearchProfileList values = SearchProfileList.fromJson(data);
    return values;
  }

  static Future<ProfilePrivacy> postprofileprivacy(
      String visibletoall, String protectphoto) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}profile_privacy'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'visible_to_all': visibletoall,
          'protect_photo': protectphoto,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ProfilePrivacy values = ProfilePrivacy.fromJson(data);
    return values;
  }

  static Future<GenerateHoroscope> postgeneratehoroscope(
      String userId, String language) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}generate_horoscope'),
        body: {'my_user_id': userId, 'language': language});
    Map<String, dynamic> data = json.decode(response.body);
    GenerateHoroscope values = GenerateHoroscope.fromJson(data);
    return values;
  }

  static Future<GenerateHoroscope> postdeletehoroscope(
      String horoscopeImg) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}delete_horoscope_file'),
        body: {
          'profile_id': SharedPrefs.getProfileId,
          'horoscope_img_url': horoscopeImg
        });
    Map<String, dynamic> data = json.decode(response.body);
    GenerateHoroscope values = GenerateHoroscope.fromJson(data);
    return values;
  }

  static Future<HoroscopeMatchList> posthoroscopematchlist(
      String horoscopeLanguage,
      String genderIdMatching,
      String name,
      String dateOfBirth,
      String birthTime,
      String birthPlace,
      String oppositeGenderIdMatching,
      String toName,
      String toDateOfBirth,
      String toBirthTime,
      String toBirthPlace) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}horoscope_match_list'),
        body: {
          'horoscope_language': horoscopeLanguage,
          'gender_id_matching': genderIdMatching,
          'name': name,
          'date_of_birth': dateOfBirth,
          'birth_time': birthTime,
          'birth_place': birthPlace,
          'opp_gender_id_matching': oppositeGenderIdMatching,
          'to_name': toName,
          'to_date_of_birth': toDateOfBirth,
          'to_birth_time': toBirthTime,
          'to_birth_place': toBirthPlace,
        });
    Map<String, dynamic> data = json.decode(response.body);
    HoroscopeMatchList values = HoroscopeMatchList.fromJson(data);
    return values;
  }

  static Future<UploadGalleryPhoto> postuploadgalleryphoto(
      String avatar, String frameOrder) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://${ApiConnection.baseurl}${ApiConnection.apiurl}upload_gallery_photo'));
    if (avatar.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('file', avatar));
    }
    request.fields['my_profile_id'] = SharedPrefs.getProfileId;
    request.fields['frame_order'] = frameOrder;
    final res = await request.send();
    final response = await http.Response.fromStream(res);
    Map<String, dynamic> data = json.decode(response.body);
    UploadGalleryPhoto values = UploadGalleryPhoto.fromJson(data);
    return values;
  }

  static Future<GalleryPhotoList> getgalleryphotolist() async {
    var response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}gallery_photo_list'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    GalleryPhotoList values = GalleryPhotoList.fromJson(data);
    return values;
  }

  static Future<DeleteGalleryPhoto> postdeletegalleryphoto(
      String frameOrder) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl,
            '${ApiConnection.apiurl}delete_gallery_photo'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'frame_order': frameOrder,
        });
    Map<String, dynamic> data = json.decode(response.body);
    DeleteGalleryPhoto values = DeleteGalleryPhoto.fromJson(data);
    return values;
  }

  static Future<SetPrimaryPhoto> postsetprimaryphoto(String frameOrder) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}set_primary_photo'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'frame_order': frameOrder,
        });
    Map<String, dynamic> data = json.decode(response.body);
    SetPrimaryPhoto values = SetPrimaryPhoto.fromJson(data);
    return values;
  }

  static Future<ReportPaymentData> reportDetails(
      String profileNo,
      String profileNo2,
      String incorrect,
      String foundMatch,
      String others) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}report'),
        body: {
          'my_profile_id': profileNo,
          'issue_id': profileNo2,
          'incorrect_details': incorrect,
          'already_found_match': foundMatch,
          'others_textarea': others,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ReportPaymentData values = ReportPaymentData.fromJson(data);
    return values;
  }

  static Future<PackageList> listPackage() async {
    final response = await http.get(
      Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}Package'),
    );
    Map<String, dynamic> data = json.decode(response.body);
    PackageList values = PackageList.fromJson(data);
    return values;
  }

  static Future<MakePayment> makepayment(String basepackage) async {
    final response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}make_payment'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'base_package': basepackage,
        });
    Map<String, dynamic> data = json.decode(response.body);
    MakePayment values = MakePayment.fromJson(data);
    return values;
  }

  static Future<ReportPaymentData> paymentDetails(
      String profileNo,
      String subscribedPremiumId,
      String firstName,
      String phoneNumber,
      String emailaddress,
      String amount,
      String status,
      String transitionId,
      String subsribedDate,
      String productInfo,
      String packageId,
      String validTo) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}payment_status'),
        body: {
          'user_id': SharedPrefs.getUserId,
          'profile_id': SharedPrefs.getProfileId,
          'profile_no': profileNo,
          'subscribed_premium_id': subscribedPremiumId,
          'firstname': firstName,
          'phone': phoneNumber,
          'email': emailaddress,
          'amount': amount,
          'status': status,
          'txnid': transitionId,
          'subsribed_date': subsribedDate,
          'productinfo': productInfo,
          'package_id': packageId,
          'valid_to': validTo,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ReportPaymentData values = ReportPaymentData.fromJson(data);
    return values;
  }

  static Future<PDFInvoice> getPdfInvoice(String transactionId) async {
    var response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}pdf_data'),
        body: {
          'transaction_id': transactionId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    PDFInvoice values = PDFInvoice.fromJson(data);
    return values;
  }

  static Future<InvoiceHistory> getinvoiceHistory() async {
    var response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}invoice_history'),
        body: {
          'profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    InvoiceHistory values = InvoiceHistory.fromJson(data);
    return values;
  }

  static Future<LoginActivity> getloginactivity() async {
    var response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}get_log_activity'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
          'my_user_id': SharedPrefs.getUserId,
          'my_subscribed_premium_id': SharedPrefs.getSubscribeId == '1'
              ? SharedPrefs.getSubscribeId
              : '0',
        });
    Map<String, dynamic> data = json.decode(response.body);
    LoginActivity values = LoginActivity.fromJson(data);
    return values;
  }

  static Future<CustomerCare> postCustomerCare(String username, String email,
      String contactnumber, String message) async {
    final response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}customerdetail_add'),
        body: {
          'name': username,
          'email': email,
          'contact_number': contactnumber,
          'message': message,
        });
    Map<String, dynamic> data = json.decode(response.body);
    CustomerCare values = CustomerCare.fromJson(data);
    return values;
  }

  static Future<List<EventsDetails>> geteventsdetails() async {
    var response = await http
        .get(Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}events'));
    return eventsFromJson(response.body);
  }

  static Future<List<BlogsDetails>> getblogdetails() async {
    var response = await http
        .get(Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}blogs'));
    return blogFromJson(response.body);
  }

  static Future<ProfileDeleteLogout> getlogout() async {
    var response = await http.post(
        Uri.https(ApiConnection.baseurl, '${ApiConnection.apiurl}logout'),
        body: {
          'my_profile_id': SharedPrefs.getProfileId,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ProfileDeleteLogout values = ProfileDeleteLogout.fromJson(data);
    return values;
  }

  static Future<ProfileDeleteLogout> deleteProfile(
      String deleteProfileStatus) async {
    var response = await http.post(
        Uri.https(
            ApiConnection.baseurl, '${ApiConnection.apiurl}delete_profile'),
        body: {
          'user_id': SharedPrefs.getUserId,
          'profile_id': SharedPrefs.getProfileId,
          'delete_profile_status': deleteProfileStatus,
        });
    Map<String, dynamic> data = json.decode(response.body);
    ProfileDeleteLogout values = ProfileDeleteLogout.fromJson(data);
    return values;
  }
}
