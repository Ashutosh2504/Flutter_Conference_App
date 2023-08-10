class AgendaModel {
  int id;
  final String speaker_name;
  final String speaker_id;
  final String hall;
  final String topic;
  final String date;
  final String time;
  final String current_date;
  final String status;

  AgendaModel({
    required this.id,
    required this.speaker_name,
    required this.speaker_id,
    required this.hall,
    required this.topic,
    required this.date,
    required this.time,
    required this.current_date,
    required this.status,
  });
}
