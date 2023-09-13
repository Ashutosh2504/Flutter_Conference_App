import 'package:bottom_navigation_and_drawer/screens/sponser/patronage_model.dart';
import 'package:bottom_navigation_and_drawer/screens/sponser/sponser_content.dart';
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
  }

  final dio = Dio();
  Future getSponsers() async {
    // try {

    try {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_exhibitor.php');
      var jsonData = (response.data);

      final sponserModel = jsonData;
      print(jsonData);
      // var high = jsonData['HIGH PATRONAGE'];

      print(sponserModel.toString());
      print(sponserModel['HIGH PATRONAGE']);

      final SponserModel sponsers = SponserModel(
          highPatronage: jsonData['HIGH PATRONAGE'],
          institutionalPatronage: sponserModel['INSTITUTIONAL PATRONAGE'],
          globalHealthForumPartners:
              sponserModel['GLOBAL HEALTH FORUM PARTNERS'],
          forumSaudeXxiPartners: sponserModel['FORUM SAUDE XXI PARTNERS']);

      for (var item in sponsers.highPatronage) {
        final Patronage high = Patronage(
            id: item['id'],
            name: item['name'],
            companyUrl: item['company_url'],
            comInfo: item['com_info'],
            tags: item['tags'],
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
            companyUrl: item['company_url'],
            comInfo: item['com_info'],
            tags: item['tags'],
            category: item['category'],
            logo: item['logo'],
            status: item['status'],
            date: item['date']);
        institutionalList.add(institutional);
      }
      for (var item in sponsers.globalHealthForumPartners) {
        final Patronage globalHealthForum = Patronage(
            id: item['id'],
            name: item['name'],
            companyUrl: item['company_url'],
            comInfo: item['com_info'],
            tags: item['tags'],
            category: item['category'],
            logo: item['logo'],
            status: item['status'],
            date: item['date']);
        gloabalHealthForumList.add(globalHealthForum);
      }
      for (var item in sponsers.forumSaudeXxiPartners) {
        final Patronage forumSaude = Patronage(
            id: item['id'],
            name: item['name'],
            companyUrl: item['company_url'],
            comInfo: item['com_info'],
            tags: item['tags'],
            category: item['category'],
            logo: item['logo'],
            status: item['status'],
            date: item['date']);
        forumSaudeList.add(forumSaude);
      }
    } catch (e) {
      throw Error.safeToString("Invalid Status Code");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sponsers"),
        ),
        body: FutureBuilder(
          future: getSponsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
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
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "HIGH PATRONAGES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  createListView(highList),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "INSTITUTIONAL PATRONAGES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  createListView(institutionalList),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "GLOBAL HEALTH FORUM PATRONAGES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  createListView(gloabalHealthForumList),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          "FORUM SAUDE XXI PATRONAGES",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  createListView(forumSaudeList),

                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Container(
                  //       child: Text(
                  //         "NSTITUTIONAL PATRONAGEs",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 20,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  Widget createListView(List<Patronage> patronage) {
    return SliverGrid.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: patronage.length,
      itemBuilder: (context, index) {
        return sponserContent(patronage[index]);
      },
    );
  }

  Widget sponserContent(Patronage sponserModel) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SponserContent(
                      sponser: sponserModel,
                    )));
      },
      child: Card(
        // color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: sponserModel.logo.isNotEmpty
                      ? Image.network(sponserModel.logo, fit: BoxFit.contain)
                      : Image.asset("assets/images/sponser.png"),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  sponserModel.name,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
