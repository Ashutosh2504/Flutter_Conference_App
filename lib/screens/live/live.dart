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
      appBar: AppBar(
        title: Text("Live"),
      ),
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctxt) => WebviewComponent(
                            title: "Portugese", webviewUrl: liveList[0].url),
                      ),
                    );
                  },
                  child: Text("Portugese"),
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: ElevatedButton(
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctxt) => WebviewComponent(
                          title: "English", webviewUrl: liveList[1].url),
                    ),
                  );
                },
                child: Text("English"),
              )),
            ),
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
