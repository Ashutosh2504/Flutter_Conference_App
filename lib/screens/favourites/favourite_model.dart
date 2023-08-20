// To parse this JSON data, do
//
//     final favouritesModel = favouritesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<FavouritesModel> favouritesModelFromJson(String str) => List<FavouritesModel>.from(json.decode(str).map((x) => FavouritesModel.fromJson(x)));

String favouritesModelToJson(List<FavouritesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouritesModel {
    final int id;
    final String userId;
    final String speakerName;
    final String agendaId;
    final String hall;
    final String topic;
    final String information;
    final String date;
    final String time;
    final String status;

    FavouritesModel({
        required this.id,
        required this.userId,
        required this.speakerName,
        required this.agendaId,
        required this.hall,
        required this.topic,
        required this.information,
        required this.date,
        required this.time,
        required this.status,
    });

    factory FavouritesModel.fromJson(Map<String, dynamic> json) => FavouritesModel(
        id: json["id"],
        userId: json["user_id"],
        speakerName: json["speaker_name"],
        agendaId: json["agenda_id"],
        hall: json["hall"],
        topic: json["topic"],
        information: json["information"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "speaker_name": speakerName,
        "agenda_id": agendaId,
        "hall": hall,
        "topic": topic,
        "information": information,
        "date": date,
        "time": time,
        "status": status,
    };
}
