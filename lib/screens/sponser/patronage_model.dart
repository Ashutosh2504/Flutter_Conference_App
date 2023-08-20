class Patronage {
  int id;
  final String name;
  final String companyUrl;
  final String comInfo;
  final String category;
  final String logo;
  final String status;
  final String date;

  Patronage({
    required this.id,
    required this.name,
    required this.companyUrl,
    required this.comInfo,
    required this.category,
    required this.logo,
    required this.status,
    required this.date,
  });

  factory Patronage.fromJson(Map<String, dynamic> json) => Patronage(
        id: json["id"],
        name: json["name"],
        companyUrl: json["company_url"],
        comInfo: json["com_info"],
        category: json["category"],
        logo: json["logo"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_url": companyUrl,
        "com_info": comInfo,
        "category": category,
        "logo": logo,
        "status": status,
        "date": date,
      };
}
