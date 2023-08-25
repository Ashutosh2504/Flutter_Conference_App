class Patronage {
  final int id;
  final String name;
  final String companyUrl;
  final String comInfo;
  final String tags;
  final String category;
  final String logo;
  final String status;
  final String date;

  Patronage({
    required this.id,
    this.name = "",
    this.companyUrl = "",
    this.comInfo = "",
    this.tags = "",
    this.category = "",
    this.logo = "",
    this.status = "",
    this.date = "",
  });

  factory Patronage.fromJson(Map<String, dynamic> json) => Patronage(
        id: json["id"],
        name: json["name"],
        companyUrl: json["company_url"],
        comInfo: json["com_info"],
        tags: json["tags"],
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
        "tags": tags,
        "category": category,
        "logo": logo,
        "status": status,
        "date": date,
      };
}
