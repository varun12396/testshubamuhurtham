import 'dart:convert';

List<EventsDetails> eventsFromJson(String str) => List<EventsDetails>.from(
    json.decode(str).map((x) => EventsDetails.fromJson(x)));

class EventsDetails {
  String photoUrl;
  String id;
  String title;
  String description;
  String fromdate;
  String todate;
  String venue;
  String time;
  String createdBy;
  String createdDate;
  String deletedStatus;
  String deletedAt;

  EventsDetails({
    required this.photoUrl,
    required this.id,
    required this.title,
    required this.description,
    required this.fromdate,
    required this.todate,
    required this.venue,
    required this.time,
    required this.createdBy,
    required this.createdDate,
    required this.deletedStatus,
    required this.deletedAt,
  });

  factory EventsDetails.fromJson(Map<String, dynamic> json) => EventsDetails(
        photoUrl: json["photo_url"] ?? '',
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        fromdate: json["fromdate"] ?? '',
        todate: json["todate"] ?? '',
        venue: json["venue"] ?? '',
        time: json["time"] ?? '',
        createdBy: json["created_by"] ?? '',
        createdDate: json["created_date"] ?? '',
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
      );
}

List<BlogsDetails> blogFromJson(String str) => List<BlogsDetails>.from(
    json.decode(str).map((x) => BlogsDetails.fromJson(x)));

class BlogsDetails {
  BlogsDetails({
    required this.photoUrl,
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
    required this.createdDate,
    required this.deletedStatus,
    required this.deletedAt,
    required this.content,
  });

  String photoUrl;
  String id;
  String title;
  String description;
  String createdBy;
  String createdDate;
  String deletedStatus;
  String deletedAt;
  String content;

  factory BlogsDetails.fromJson(Map<String, dynamic> json) => BlogsDetails(
        photoUrl: json["photo_url"] ?? '',
        id: json["id"] ?? '',
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        createdBy: json["created_by"] ?? '',
        createdDate: json["created_date"] ?? '',
        deletedStatus: json["deleted_status"] ?? '',
        deletedAt: json["deleted_at"] ?? '',
        content: json["content"] ?? '',
      );
}
