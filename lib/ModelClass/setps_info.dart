class BasicStep1 {
  BasicStep1({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory BasicStep1.fromJson(Map<String, dynamic> json) {
    return BasicStep1(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class BasicStep2 {
  BasicStep2({
    required this.status,
    required this.message,
    required this.path,
  });

  bool status;
  String message;
  String path;

  factory BasicStep2.fromJson(Map<String, dynamic> json) {
    return BasicStep2(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
      path: json["path"] ?? '',
    );
  }
}

class BasicStep3 {
  BasicStep3({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory BasicStep3.fromJson(Map<String, dynamic> json) {
    return BasicStep3(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class BasicStep4 {
  BasicStep4({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory BasicStep4.fromJson(Map<String, dynamic> json) {
    return BasicStep4(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class AboutMe {
  AboutMe({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory AboutMe.fromJson(Map<String, dynamic> json) {
    return AboutMe(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class CustomerCare {
  CustomerCare({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory CustomerCare.fromJson(Map<String, dynamic> json) {
    return CustomerCare(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class RefferalCode {
  RefferalCode({
    required this.status,
    required this.message,
    required this.refferalsData,
  });

  bool status;
  String message;
  RefferalsDatum refferalsData;

  factory RefferalCode.fromJson(Map<String, dynamic> json) => RefferalCode(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        refferalsData: RefferalsDatum.fromJson(json["refferals_data"]),
      );
}

class RefferalsDatum {
  RefferalsDatum({
    required this.refferId,
    required this.refferalCode,
    required this.communityName,
    required this.communityLeader,
    required this.createdBy,
    required this.createdDate,
    required this.deletedStatus,
    required this.deletedAt,
    required this.phoneNumber,
    required this.discount,
    required this.password,
    required this.amount,
  });

  String refferId;
  String refferalCode;
  String communityName;
  String communityLeader;
  String createdBy;
  String createdDate;
  String deletedStatus;
  String deletedAt;
  String phoneNumber;
  String discount;
  String password;
  String amount;

  factory RefferalsDatum.fromJson(Map<String, dynamic> json) => RefferalsDatum(
        refferId: json["reffer_id"] ?? '',
        refferalCode: json["refferal_code"] ?? '',
        communityName: json["community_name"] ?? '',
        communityLeader: json["community_leader"] ?? '',
        createdBy: json["created_by"] ?? '',
        createdDate: json["created_date"] ?? '',
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        amount: json["amount"] ?? '',
        phoneNumber: json["phone_number"] ?? '',
        discount: json["discount"] ?? '',
        password: json["password"] ?? '',
      );
}

class PromotionCode {
  PromotionCode({
    required this.status,
    required this.message,
    required this.promotionData,
  });

  bool status;
  String message;
  List<PromotionDatum> promotionData;

  factory PromotionCode.fromJson(Map<String, dynamic> json) => PromotionCode(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        promotionData: json["promotion_data"] == null
            ? []
            : List<PromotionDatum>.from(
                json["promotion_data"].map((x) => PromotionDatum.fromJson(x))),
      );
}

class PromotionDatum {
  PromotionDatum({
    required this.promotionId,
    required this.promotionCode,
    required this.promotionName,
    required this.promotionDescription,
    required this.amount,
    required this.count,
    required this.createdBy,
    required this.createdDate,
    required this.deletedStatus,
    required this.deletedAt,
    required this.used,
    required this.balance,
  });

  String promotionId;
  String promotionCode;
  String promotionName;
  String promotionDescription;
  String amount;
  String count;
  String createdBy;
  String createdDate;
  String deletedStatus;
  String deletedAt;
  String used;
  String balance;

  factory PromotionDatum.fromJson(Map<String, dynamic> json) => PromotionDatum(
        promotionId: json["promotion_id"] ?? '',
        promotionCode: json["promotion_code"] ?? '',
        promotionName: json["promotion_name"] ?? '',
        promotionDescription: json["promotion_description"] ?? '',
        amount: json["amount"] ?? '',
        count: json["count"] ?? '',
        createdBy: json["created_by"] ?? '',
        createdDate: json["created_date"] ?? '',
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        used: json["used"] ?? '',
        balance: json["balance"] ?? '',
      );
}
