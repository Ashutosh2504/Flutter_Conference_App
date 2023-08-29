// To parse this JSON data, do
//
//     final favouritesModel = favouritesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FavouritesModel> favouritesModelFromJson(String str) =>
    List<FavouritesModel>.from(
        json.decode(str).map((x) => FavouritesModel.fromJson(x)));

String favouritesModelToJson(List<FavouritesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouritesModel {
  int id;
  String userId;
  String speakerId;
  String speakerName;
  String agendaId;
  String hall;
  String topic;
  String information;
  String date;
  String fromTime;
  String toTime;
  String status;
  bool favourite;

  FavouritesModel(
      {required this.id,
      required this.userId,
      required this.speakerId,
      required this.speakerName,
      required this.agendaId,
      required this.hall,
      required this.topic,
      required this.information,
      required this.date,
      required this.fromTime,
      required this.toTime,
      required this.status,
      this.favourite = false});

  factory FavouritesModel.fromJson(Map<String, dynamic> json) =>
      FavouritesModel(
        id: json["id"],
        userId: json["user_id"],
        speakerId: json["speaker_id"],
        speakerName: json["speaker_name"],
        agendaId: json["agenda_id"],
        hall: json["hall"],
        topic: json["topic"],
        information: json["information"],
        date: json["date"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "speaker_id": speakerId,
        "speaker_name": speakerName,
        "agenda_id": agendaId,
        "hall": hall,
        "topic": topic,
        "information": information,
        "date": date,
        "from_time": fromTime,
        "to_time": toTime,
        "status": status,
      };
}
