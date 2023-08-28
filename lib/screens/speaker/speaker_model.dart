// To parse this JSON data, do
//
//     final speakerModel = speakerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SpeakerModel> speakerModelFromJson(String str) => List<SpeakerModel>.from(
    json.decode(str).map((x) => SpeakerModel.fromJson(x)));

String speakerModelToJson(List<SpeakerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpeakerModel {
  int id;
  String name;
  String email;
  String mobile;
  String designation;
  String institute;
  String information;
  String city;
  String country;
  String linkedinUrl;
  String date;
  String photo;
  String rating;
  String status;

  SpeakerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.designation,
    required this.institute,
    required this.information,
    required this.city,
    required this.country,
    required this.linkedinUrl,
    required this.date,
    required this.photo,
    required this.rating,
    required this.status,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) => SpeakerModel(
        id: int.tryParse(json["id"]) ?? json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        designation: json["designation"],
        institute: json["institute"],
        information: json["information"],
        city: json["city"],
        country: json["country"],
        linkedinUrl: json["linkedin_url"],
        date: json["date"],
        photo: json["photo"],
        rating: json["rating"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "designation": designation,
        "institute": institute,
        "information": information,
        "city": city,
        "country": country,
        "linkedin_url": linkedinUrl,
        "date": date,
        "photo": photo,
        "rating": rating,
        "status": status,
      };
}
