import 'package:bottom_navigation_and_drawer/screens/sponser/patronage_model.dart';
import 'package:bottom_navigation_and_drawer/screens/sponser/sponser_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MySponsers extends StatefulWidget {
  const MySponsers({super.key});

  @override
  State<MySponsers> createState() => _MySponsersState();
}

class _MySponsersState extends State<MySponsers> {
  List<SponserModel> sponserList = [];
  List<Patronage> highList = [];
  List<Patronage> institutionalList = [];
  List<Patronage> gloabalHealthForumList = [];
  List<Patronage> forumSaudeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSponsers();
  }

  final dio = Dio();
  Future getSponsers() async {
    // try {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_exhibitor.php');

    var jsonData = (response.data);

    final sponserModel = jsonData;
    print(jsonData);
    // var high = jsonData['HIGH PATRONAGE'];

    print(sponserModel.toString());
    print(sponserModel['HIGH PATRONAGE']);

    final SponserModel sponsers = SponserModel(
        highPatronage: jsonData['HIGH PATRONAGE'],
        institutionalPatronage: sponserModel['INSTITUTIONAL PATRONAGE'],
        globalHealthForumPartners: sponserModel['GLOBAL HEALTH FORUM PARTNERS'],
        forumSaudeXxiPartners: sponserModel['FORUM SAUDE XXI PARTNERS']);

    for (var item in sponsers.highPatronage) {
      final Patronage high = Patronage(
          id: item['id'],
          name: item['name'],
          companyUrl: //item['companyUrl'],
              "",
          comInfo: "" //item['comInfo'],
          ,
          category: item['category'],
          logo: item['logo'],
          status: item['status'],
          date: item['date']);
      highList.add(high);
    }
    for (var item in sponsers.institutionalPatronage) {
      final Patronage institutional = Patronage(
          id: item['id'],
          name: item['name'],
          companyUrl: //item['companyUrl'],
              "",
          comInfo: "" //item['comInfo'],
          ,
          category: item['category'],
          logo: item['logo'],
          status: item['status'],
          date: item['date']);
      institutionalList.add(institutional);
    }
    for (var item in sponsers.globalHealthForumPartners) {
      final Patronage globalHealthForum = Patronage(
          id: item.id,
          name: item.name,
          companyUrl: item.companyUrl,
          comInfo: item.comInfo,
          category: item.category,
          logo: item.logo,
          status: item.status,
          date: item.date);
      gloabalHealthForumList.add(globalHealthForum);
    }
    for (var item in sponsers.forumSaudeXxiPartners) {
      final Patronage forumSaude = Patronage(
          id: item.id,
          name: item.name,
          companyUrl: item.companyUrl,
          comInfo: item.comInfo,
          category: item.category,
          logo: item.logo,
          status: item.status,
          date: item.date);
      forumSaudeList.add(forumSaude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsers"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Image.asset(
                "assets/images/join_us.jpg",
                height: 150,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "These exceptional partners are the epitome of excellence, bringing their unrivaled expertise and unmatched reputation to the forefront. ",
              textAlign: TextAlign.left,
              softWrap: true,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "Platinum Partners",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: getSponsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      //childAspectRatio: 1.2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10),
                  itemCount: highList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.network(highList[index].logo,
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.info_outline,
                                            semanticLabel: "Info",
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Info:",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        highList[index].comInfo,
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))
          // GridView.builder(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     gridDelegate:
          //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          //     itemBuilder: (context, index) {
          //       return Card(
          //         child: Container(),
          //       );
          //     })
        ],
      ),
    );
  }
}
