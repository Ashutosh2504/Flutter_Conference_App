// To parse this JSON data, do
//
//     final sponserModel = sponserModelFromJson(jsonString);

import 'dart:convert';

import 'patronage_model.dart';

SponserModel sponserModelFromJson(String str) =>
    SponserModel.fromJson(json.decode(str));

String sponserModelToJson(SponserModel data) => json.encode(data.toJson());

class SponserModel {
 final List<dynamic> highPatronage;
  final List<dynamic> institutionalPatronage;
  final List<dynamic> globalHealthForumPartners;
 final  List<dynamic> forumSaudeXxiPartners;

  SponserModel({
    required this.highPatronage,
    required this.institutionalPatronage,
    required this.globalHealthForumPartners,
    required this.forumSaudeXxiPartners,
  });

  factory SponserModel.fromJson(Map<String, dynamic> json) => SponserModel(
        highPatronage: List<Patronage>.from(
            json["HIGH PATRONAGE"].map((x) => Patronage.fromJson(x))),
        institutionalPatronage: List<Patronage>.from(
            json["INSTITUTIONAL PATRONAGE"].map((x) => Patronage.fromJson(x))),
        globalHealthForumPartners: List<Patronage>.from(
            json["GLOBAL HEALTH FORUM PARTNERS"].map((x) => x)),
        forumSaudeXxiPartners: List<Patronage>.from(
            json["FORUM SAUDE XXI PARTNERS"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "HIGH PATRONAGE":
            List<dynamic>.from(highPatronage.map((x) => x.toJson())),
        "INSTITUTIONAL PATRONAGE":
            List<dynamic>.from(institutionalPatronage.map((x) => x.toJson())),
        "GLOBAL HEALTH FORUM PARTNERS":
            List<dynamic>.from(globalHealthForumPartners.map((x) => x)),
        "FORUM SAUDE XXI PARTNERS":
            List<dynamic>.from(forumSaudeXxiPartners.map((x) => x)),
      };
}







// class SponserModel {
//   //  "HIGH PATRONAGE": [
//   //       {
//   //           "id": 1,
//   //           "name": "1",
//   //           "company_url": "",
//   //           "com_info": "",
//   //           "category": "HIGH PATRONAGE",
//   //           "logo": "https://globalhealth-forum.com/event_app/exhibitor_logo/logo-526.png",
//   //           "status": "1",
//   //           "date": "02-08-2023 15:37"
//   //       }
//   //   ],

//   SponserTypes sponserTypes;
//   SponserModel({
//     required this.sponserTypes,
//   });
// }

// class SponserTypes {
//   int id;
//   final String name;
//   final String company_url;
//   final String com_info;
//   final String category;
//   final String logo;
//   final String status;
//   final String date;

//   SponserTypes({
//     required this.id,
//     required this.name,
//     required this.company_url,
//     required this.com_info,
//     required this.category,
//     required this.logo,
//     required this.status,
//     required this.date,
//   });
// }
