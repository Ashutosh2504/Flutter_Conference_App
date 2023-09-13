// To parse this JSON data, do
//
//     final checkSpeakerRatingModel = checkSpeakerRatingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<CheckSpeakerRatingModel> checkSpeakerRatingModelFromJson(String str) =>
    List<CheckSpeakerRatingModel>.from(
        json.decode(str).map((x) => CheckSpeakerRatingModel.fromJson(x)));

String checkSpeakerRatingModelToJson(List<CheckSpeakerRatingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CheckSpeakerRatingModel {
  int id;
  String userId;
  String rating;
  String speakerId;
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
  String status;

  CheckSpeakerRatingModel({
    required this.id,
    required this.userId,
    required this.rating,
    required this.speakerId,
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
    required this.status,
  });

  factory CheckSpeakerRatingModel.fromJson(Map<String, dynamic> json) =>
      CheckSpeakerRatingModel(
        id: json["id"],
        userId: json["user_id"],
        rating: json["rating"],
        speakerId: json["speaker_id"],
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
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rating": rating,
        "speaker_id": speakerId,
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
        "status": status,
      };
}
