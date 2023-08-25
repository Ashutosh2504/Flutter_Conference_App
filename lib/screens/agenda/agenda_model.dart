// To parse this JSON data, do
//
//     final agendaModel = agendaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Map<String, List<AgendaModel>> agendaModelFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, List<AgendaModel>>(
            k, List<AgendaModel>.from(v.map((x) => AgendaModel.fromJson(x)))));

String agendaModelToJson(Map<String, List<AgendaModel>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

class AgendaModel {
  final int id;
  final String speakerName;
  final String speakerId;
  final String hall;
  final String topic;
  final String information;
  final String date;
  final String fromTime;
  final String toTime;
  final String currentDate;
  final String status;
  String isFavourite;

  AgendaModel({
    required this.id,
    required this.speakerName,
    required this.speakerId,
    required this.hall,
    required this.topic,
    required this.information,
    required this.date,
    required this.fromTime,
    required this.toTime,
    required this.currentDate,
    required this.status,
    this.isFavourite = 'Add to Favourites',
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        id: json["id"],
        speakerName: json["speaker_name"],
        speakerId: json["speaker_id"],
        hall: json["hall"],
        topic: json["topic"],
        information: json["information"],
        date: json["date"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
        currentDate: json["current_date"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "speaker_name": speakerName,
        "speaker_id": speakerId,
        "hall": hall,
        "topic": topic,
        "information": information,
        "date": date,
        "from_time": fromTime,
        "to_time": toTime,
        "current_date": currentDate,
        "status": status,
      };
}
