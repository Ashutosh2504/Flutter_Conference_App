import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/live/live_model.dart';
import 'package:bottom_navigation_and_drawer/util/webview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyLive extends StatefulWidget {
  const MyLive({super.key});

  @override
  State<MyLive> createState() => _MyLiveState();
}

class _MyLiveState extends State<MyLive> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

  List<LiveModel> liveList = [];

  @override
  void initState() {
    // TODO: implement initState
    getLive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Live"),
      ),
      body: Container(
        child: Column(
          children: [
            Divider(),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    16.0), // Adjust the corner radius as needed
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Language spoken at the session: PORTUGUESE",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.asset("assets/images/portugal.png"),
                            ),
                            Text("Portuguese"),
                          ],
                        ),
                        Icon(Icons.arrow_forward_rounded),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctxt) => WebviewComponent(
                                        title: "Portugese",
                                        webviewUrl: liveList[0].url),
                                  ),
                                );
                              },
                              child: Text("Portuguese"),
                            ),
                            Text("For deaf people"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                  "assets/images/united-kingdom.png"),
                            ),
                            Text("English"),
                          ],
                        ),
                        Icon(Icons.arrow_forward_rounded),
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctxt) => WebviewComponent(
                                        title: "English",
                                        webviewUrl: liveList[1].url),
                                  ),
                                );
                              },
                              child: Text("English"),
                            ),
                            Text("Translation to English"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    16.0), // Adjust the corner radius as needed
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "Language spoken at the session: ENGLISH",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                    "assets/images/united-kingdom.png"),
                              ),
                              Text("English"),
                            ],
                          ),
                          Icon(Icons.arrow_forward_rounded),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctxt) => WebviewComponent(
                                          title: "English",
                                          webviewUrl: liveList[2].url),
                                    ),
                                  );
                                },
                                child: Text("English"),
                              ),
                              Text("For deaf people"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child:
                                    Image.asset("assets/images/portugal.png"),
                              ),
                              Text("Portuguese"),
                            ],
                          ),
                          Icon(Icons.arrow_forward_rounded),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctxt) => WebviewComponent(
                                          title: "Portuguese",
                                          webviewUrl: liveList[3].url),
                                    ),
                                  );
                                },
                                child: Text("Portuguese"),
                              ),
                              Text("Translation to Portuguese"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    16.0), // Adjust the corner radius as needed
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "IN-PERSON ATTENDEE",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "(I'm in Auditorium)",
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctxt) => WebviewComponent(
                                title: "LIVE", webviewUrl: liveList[4].url),
                          ),
                        );
                      },
                      child: Text("LIVE LINK"),
                    ),
                  ],
                ),
              ),
            )

            //////////////////////
          ],
        ),
      ),
    );
  }

  final dio = Dio();

  Future getLive() async {
    try {
      final response = await dio
          .get('https://globalhealth-forum.com/event_app/api/get_live.php');

      var jsonData = (response.data);
      for (var live in jsonData) {
        final liveObj = LiveModel(
            id: live['id'],
            language: live['language'],
            url: live['url'],
            status: live['status']);

        liveList.add(liveObj);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
