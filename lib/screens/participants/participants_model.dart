// To parse this JSON data, do
//
//     final participantsModel = participantsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ParticipantsModel> participantsModelFromJson(String str) => List<ParticipantsModel>.from(json.decode(str).map((x) => ParticipantsModel.fromJson(x)));

String participantsModelToJson(List<ParticipantsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParticipantsModel {
    int id;
    String name;
    String email;
    String mobile;
    String gender;
    String city;
    String designation;
    String institution;
    String photo;
    String otp;

    ParticipantsModel({
        required this.id,
        required this.name,
        required this.email,
        required this.mobile,
        required this.gender,
        required this.city,
        required this.designation,
        required this.institution,
        required this.photo,
        required this.otp,
    });

    factory ParticipantsModel.fromJson(Map<String, dynamic> json) => ParticipantsModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        gender: json["gender"],
        city: json["city"],
        designation: json["designation"],
        institution: json["institution"],
        photo: json["photo"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "gender": gender,
        "city": city,
        "designation": designation,
        "institution": institution,
        "photo": photo,
        "otp": otp,
    };
}
