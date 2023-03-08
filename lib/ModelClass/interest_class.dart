class InterestSendStatus {
  InterestSendStatus({
    required this.status,
    required this.message,
    required this.fcmKeyToken,
    required this.commentMessage,
  });

  bool status;
  String message;
  String fcmKeyToken;
  String commentMessage;

  factory InterestSendStatus.fromJson(Map<String, dynamic> json) {
    return InterestSendStatus(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
      fcmKeyToken: json["fcm_token"] ?? '',
      commentMessage: json["comment_message"] ?? '',
    );
  }
}

class RejectedHistoryData {
  RejectedHistoryData({
    required this.status,
    required this.message,
  });

  bool status;
  List<RejectedHistoryMessage> message;

  factory RejectedHistoryData.fromJson(Map<String, dynamic> json) =>
      RejectedHistoryData(
        status: json["status"],
        message: List<RejectedHistoryMessage>.from(
            json["message"].map((x) => RejectedHistoryMessage.fromJson(x))),
      );
}

class RejectedHistoryMessage {
  RejectedHistoryMessage({
    required this.profileNo,
    required this.sentAt,
    required this.senderProfileId,
    required this.receiverProfileId,
    required this.interestStatus,
  });

  String profileNo;
  String sentAt;
  String senderProfileId;
  String receiverProfileId;
  String interestStatus;

  factory RejectedHistoryMessage.fromJson(Map<String, dynamic> json) =>
      RejectedHistoryMessage(
        profileNo: json["profile_no"],
        sentAt: json["sent_at"],
        senderProfileId: json["sender_profile_id"],
        receiverProfileId: json["receiver_profile_id"],
        interestStatus: json["interest_status"],
      );
}

class AddRemoveFavorite {
  AddRemoveFavorite({
    required this.status,
    required this.message,
  });

  bool status;
  String message;

  factory AddRemoveFavorite.fromJson(Map<String, dynamic> json) {
    return AddRemoveFavorite(
      status: json["status"] ?? false,
      message: json["message"] ?? '',
    );
  }
}

class Motification {
  Motification({
    required this.status,
    required this.message,
  });

  bool status;
  List<MotificationMessage> message;

  factory Motification.fromJson(Map<String, dynamic> json) => Motification(
        status: json["status"],
        message: List<MotificationMessage>.from(
            json["message"].map((x) => MotificationMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
      };
}

class MotificationMessage {
  MotificationMessage({
    required this.notificationsId,
    required this.myProfileId,
    required this.profileId,
    required this.notificationType,
    required this.notificationComment,
    required this.status,
    required this.createdAt,
    required this.modifiedAt,
  });

  String notificationsId;
  String myProfileId;
  String profileId;
  String notificationType;
  String notificationComment;
  String status;
  String createdAt;
  dynamic modifiedAt;

  factory MotificationMessage.fromJson(Map<String, dynamic> json) =>
      MotificationMessage(
        notificationsId: json["notifications_id"] ?? '',
        myProfileId: json["my_profile_id"] ?? '',
        profileId: json["profile_id"] ?? '',
        notificationType: json["notification_type"] ?? '',
        notificationComment: json["notification_comment"] ?? '',
        status: json["status"] ?? '',
        createdAt: json["created_at"] ?? '',
        modifiedAt: json["modified_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "notifications_id": notificationsId,
        "my_profile_id": myProfileId,
        "profile_id": profileId,
        "notification_type": notificationType,
        "notification_comment": notificationComment,
        "status": status,
        "created_at": createdAt,
        "modified_at": modifiedAt,
      };
}
