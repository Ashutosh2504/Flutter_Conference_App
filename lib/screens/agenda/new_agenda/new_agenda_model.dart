// To parse this JSON data, do
//
//     final agendaModel = agendaModelFromJson(jsonString);

import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:meta/meta.dart';

Map<String, List<NewAgendaModel>> agendaModelFromJson(Map str) {
  return str.map((k, v) => MapEntry<String, List<NewAgendaModel>>(
      k, List<NewAgendaModel>.from(v.map((x) => NewAgendaModel.fromJson(x)))));
}

String agendaModelToJson(Map<String, List<NewAgendaModel>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

// "Topic": "demo dbdfjs",
//                 "agenda_id": "15",
//                 "hall": "Hall-B",
//                 "agenda_info": "dsfd hdsf dsh",
//                 "agenda_rating": "",
//                 "from_time": "02:52 AM",
//                 "to_time": "02:52 PM",
//                 "speakers": [
//                     {
//                         "speaker_id": "1",
//                         "speaker_name": "Adalberto Campos Fernandes",
//                         "speaker_email": "",
//                         "speaker_designation": "GHF Chairman of the Board",
//                         "speaker_institute": "",
//                         "speaker_info": ""
//                     }
class NewAgendaModel {
  final String Topic;
  final String agenda_id;
  final String hall;
  final String agenda_info;
  final String agenda_rating;
  final String from_time;
  final String to_time;
  List<SpeakerModel> speakers;

  String isFavourite;
  // String isFavourite;

  NewAgendaModel({
    required this.Topic,
    required this.agenda_id,
    required this.hall,
    required this.agenda_info,
    required this.agenda_rating,
    required this.from_time,
    required this.to_time,
    required this.speakers,
    this.isFavourite = 'Add to Favourites',
  });

  factory NewAgendaModel.fromJson(Map<String, dynamic> json) => NewAgendaModel(
        Topic: json["Topic"],
        agenda_id: json["agenda_id"],
        hall: json["hall"],
        agenda_info: json["agenda_info"],
        agenda_rating: json["agenda_rating"],
        from_time: json["from_time"],
        to_time: json["to_time"],
        speakers: List<SpeakerModel>.from(
            json["speakers"].map((x) => SpeakerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Topic": Topic,
        "agenda_id": agenda_id,
        "hall": hall,
        "agenda_info": agenda_info,
        "agenda_rating": agenda_rating,
        "from_time": from_time,
        "to_time": to_time,
        "speakers": List<dynamic>.from(speakers.map((x) => x.toJson())),
      };
}
