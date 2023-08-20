class DownloadModel {
  //  "id": 1,
  //       "file": "https://globalhealth-forum.com/event_app/downloads/download-573.pdf",
  //       "status": "1",
  //       "date": "09-08-2023 14:56"
  int id;
  final String file;
  final String status;
  final String date;

  DownloadModel({
    required this.id,
    required this.file,
    required this.status,
    required this.date,
  });
}
