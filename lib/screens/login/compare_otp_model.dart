// To parse this JSON data, do
//
//     final compareOtpModel = compareOtpModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CompareOtpModel compareOtpModelFromJson(String str) =>
    CompareOtpModel.fromJson(json.decode(str));

String compareOtpModelToJson(CompareOtpModel data) =>
    json.encode(data.toJson());

class CompareOtpModel {
  final String successcode;
  final User user;

  CompareOtpModel({
    required this.successcode,
    required this.user,
  });

  factory CompareOtpModel.fromJson(Map<String, dynamic> json) =>
      CompareOtpModel(
        successcode: json["successcode"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "successcode": successcode,
        "user": user.toJson(),
      };
}

class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String gender;
  final String city;
  final String otp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.city,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
        city: json["city"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "city": city,
        "otp": otp,
      };
}
