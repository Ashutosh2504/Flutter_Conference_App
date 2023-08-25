// To parse this JSON data, do
//
//     final faqModel = faqModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FaqModel> faqModelFromJson(String str) =>
    List<FaqModel>.from(json.decode(str).map((x) => FaqModel.fromJson(x)));

String faqModelToJson(List<FaqModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaqModel {
  final int id;
  final String que;
  final String ans;
  final String status;

  FaqModel({
    required this.id,
    required this.que,
    required this.ans,
    required this.status,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
        id: json["id"],
        que: json["que"],
        ans: json["ans"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "que": que,
        "ans": ans,
        "status": status,
      };
}
