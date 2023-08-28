import 'dart:convert';

class NotoficationsModel {
  final int id;
  final String notiTopic;
  final String msg;
  final String date;
  final String status;

  NotoficationsModel({
    required this.id,
    required this.notiTopic,
    required this.msg,
    required this.date,
    required this.status,
  });

  factory NotoficationsModel.fromRawJson(String str) =>
      NotoficationsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotoficationsModel.fromJson(Map<String, dynamic> json) =>
      NotoficationsModel(
          id: json["id"],
          notiTopic: json["noti_topic"],
          msg: json["msg"],
          date: json["date"],
          status: json["status"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "noti_topic": notiTopic,
        "msg": msg,
        "status": status,
      };
}
