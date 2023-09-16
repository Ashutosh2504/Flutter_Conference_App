// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<ContactUsModel> contactUsModelFromJson(String str) =>
    List<ContactUsModel>.from(
        json.decode(str).map((x) => ContactUsModel.fromJson(x)));

String contactUsModelToJson(List<ContactUsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactUsModel {
  int id;
  String department;
  String name;
  String phone;

  ContactUsModel({
    required this.id,
    required this.department,
    required this.name,
    required this.phone,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
        id: json["id"],
        department: json["department"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department": department,
        "name": name,
        "phone": phone,
      };
}
