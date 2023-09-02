// To parse this JSON data, do
//
//     final liveModel = liveModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<LiveModel> liveModelFromJson(String str) =>
    List<LiveModel>.from(json.decode(str).map((x) => LiveModel.fromJson(x)));

String liveModelToJson(List<LiveModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveModel {
  final int id;
  final String language;
  final String url;
  final String status;

  LiveModel({
    required this.id,
    required this.language,
    required this.url,
    required this.status,
  });

  factory LiveModel.fromJson(Map<String, dynamic> json) => LiveModel(
        id: json["id"],
        language: json["language"],
        url: json["url"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "url": url,
        "status": status,
      };
}
