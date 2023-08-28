// To parse this JSON data, do
//
//     final checkFavouriteModel = checkFavouriteModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CheckFavouriteModel checkFavouriteModelFromJson(String str) =>
    CheckFavouriteModel.fromJson(json.decode(str));

String checkFavouriteModelToJson(CheckFavouriteModel data) =>
    json.encode(data.toJson());

class CheckFavouriteModel {
  String status;
  String msg;

  CheckFavouriteModel({
    required this.status,
    required this.msg,
  });

  factory CheckFavouriteModel.fromJson(Map<String, dynamic> json) =>
      CheckFavouriteModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
