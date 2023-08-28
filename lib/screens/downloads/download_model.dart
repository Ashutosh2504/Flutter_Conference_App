class DownloadModel {
  //  "id": 1,
  //       "file": "https://globalhealth-forum.com/event_app/downloads/download-573.pdf",
  //       "status": "1",
  //       "date": "09-08-2023 14:56"
  String id;
  final String url;
  final String filename;
  final String description;

  DownloadModel({
    required this.id,
    required this.url,
    required this.filename,
    required this.description,
  });
}
