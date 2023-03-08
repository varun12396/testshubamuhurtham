import 'dart:convert';

List<Country> countryFromJson(String str) =>
    List<Country>.from(json.decode(str).map((x) => Country.fromJson(x)));

class Country {
  Country({
    required this.countryId,
    required this.countryCode,
    required this.countryStdCode,
    required this.countryText,
    required this.isDeleted,
    required this.isActive,
  });

  final String countryId;
  final String countryCode;
  final String countryStdCode;
  final String countryText;
  final String isDeleted;
  final String isActive;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json["country_id"] ?? '',
      countryCode: json["country_code"] ?? '',
      countryStdCode: json["country_std_code"] ?? '',
      countryText: json["country_text"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
      isActive: json["is_active"] ?? '',
    );
  }
}

List<States> statesFromJson(String str) =>
    List<States>.from(json.decode(str).map((x) => States.fromJson(x)));

class States {
  States({
    required this.stateId,
    required this.countryId,
    required this.stateType,
    required this.stateCapital,
    required this.stateCode,
    required this.stateName,
    required this.isDeleted,
    required this.isActive,
  });

  final String stateId;
  final String countryId;
  final String stateType;
  final String stateCapital;
  final String stateCode;
  final String stateName;
  final String isDeleted;
  final String isActive;

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      stateId: json["state_id"] ?? '',
      countryId: json["country_id"] ?? '',
      stateType: json["state_type"] ?? '',
      stateCapital: json["state_capital"] ?? '',
      stateCode: json["state_code"] ?? '',
      stateName: json["state_name"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
      isActive: json["is_active"] ?? '',
    );
  }
}

List<Location> locationFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));

class Location {
  Location({
    required this.districtId,
    required this.stateId,
    required this.districtName,
    required this.isActive,
    required this.isDeleted,
  });

  String districtId;
  String stateId;
  String districtName;
  String isActive;
  String isDeleted;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      districtId: json["district_id"] ?? '',
      stateId: json["state_id"] ?? '',
      districtName: json["district_name"] ?? '',
      isActive: json["is_active"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
    );
  }
}

List<Height> heightFromJson(String str) =>
    List<Height>.from(json.decode(str).map((x) => Height.fromJson(x)));

class Height {
  Height({
    required this.id,
    required this.name,
    required this.formattedText,
  });

  final String id;
  final String name;
  final String formattedText;

  factory Height.fromJson(Map<String, dynamic> json) {
    return Height(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      formattedText: json["formatted_text"] ?? '',
    );
  }
}

List<Mothertongue> mothertongueFromJson(String str) => List<Mothertongue>.from(
    json.decode(str).map((x) => Mothertongue.fromJson(x)));

class Mothertongue {
  Mothertongue({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Mothertongue.fromJson(Map<String, dynamic> json) {
    return Mothertongue(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
    );
  }
}

List<Religion> religionFromJson(String str) =>
    List<Religion>.from(json.decode(str).map((x) => Religion.fromJson(x)));

class Religion {
  Religion({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Religion.fromJson(Map<String, dynamic> json) {
    return Religion(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
    );
  }
}

List<Caste> casteFromJson(String str) =>
    List<Caste>.from(json.decode(str).map((x) => Caste.fromJson(x)));

class Caste {
  Caste({
    required this.casteId,
    required this.casteName,
    required this.isActive,
    required this.isDeleted,
  });

  final String casteId;
  final String casteName;
  final String isActive;
  final String isDeleted;

  factory Caste.fromJson(Map<String, dynamic> json) {
    return Caste(
      casteId: json["caste_id"] ?? '',
      casteName: json["caste_name"] ?? '',
      isActive: json["is_active"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
    );
  }
}

List<SubCaste> subCasteFromJson(String str) =>
    List<SubCaste>.from(json.decode(str).map((x) => SubCaste.fromJson(x)));

class SubCaste {
  SubCaste({
    required this.subCasteId,
    required this.casteId,
    required this.subCasteName,
    required this.isActive,
    required this.isDeleted,
  });

  final String subCasteId;
  final String casteId;
  final String subCasteName;
  final String isActive;
  final String isDeleted;

  factory SubCaste.fromJson(Map<String, dynamic> json) {
    return SubCaste(
      subCasteId: json["sub_caste_id"] ?? '',
      casteId: json["caste_id"] ?? '',
      subCasteName: json["sub_caste_name"] ?? '',
      isActive: json["is_active"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
    );
  }
}

List<Education> educationFromJson(String str) =>
    List<Education>.from(json.decode(str).map((x) => Education.fromJson(x)));

class Education {
  Education({
    required this.id,
    required this.name,
    required this.isDeleted,
  });

  final String id;
  final String name;
  final String isDeleted;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
    );
  }
}

List<Occupation> occupationFromJson(String str) =>
    List<Occupation>.from(json.decode(str).map((x) => Occupation.fromJson(x)));

class Occupation {
  Occupation({
    required this.occupationId,
    required this.occupationName,
    required this.isDeleted,
    required this.isActive,
  });

  final String occupationId;
  final String occupationName;
  final String isDeleted;
  final String isActive;

  factory Occupation.fromJson(Map<String, dynamic> json) {
    return Occupation(
      occupationId: json["occupation_id"] ?? '',
      occupationName: json["occupation_name"] ?? '',
      isDeleted: json["is_deleted"] ?? '',
      isActive: json["is_active"] ?? '',
    );
  }
}
