import 'package:bottom_navigation_and_drawer/screens/notifications/notifications_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  final dio = Dio();
  List<NotoficationsModel> notificationsList = [];
  Future getNotifications() async {
    try {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_notification.php');

      var jsonData = (response.data);
      for (var image in jsonData) {
        final notification = NotoficationsModel(
          id: image['id'],
          notiTopic: image['noti_topic'],
          msg: image['msg'],
          date: image['date'],
          status: image['status'],
        );

        notificationsList.add(notification);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Divider(
                color: Colors.blueGrey,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                      itemCount: notificationsList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueGrey),
                                      text: notificationsList[index].notiTopic,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        // RichText(
                                        //   textAlign: TextAlign.center,
                                        //   text: TextSpan(
                                        //     style: TextStyle(
                                        //         fontSize: 15,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.black),
                                        //     text: "Date:",
                                        //   ),
                                        // ),
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey),
                                            text: notificationsList[index].date,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        // RichText(
                                        //   textAlign: TextAlign.center,
                                        //   text: TextSpan(
                                        //     style: TextStyle(
                                        //         fontSize: 15,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Colors.black),
                                        //     text: "Msg:",
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.blueGrey),
                                              text:
                                                  notificationsList[index].msg,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            // child: ListView.builder(
            //     itemCount: notificationsList.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Column(
            //           children: [
            //             RichText(
            //               text: TextSpan(
            //                 style: TextStyle(
            //                     fontSize: 18,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.blueGrey),
            //                 text: notificationsList[index].notiTopic,
            //               ),
            //             ),
            //             RichText(
            //               text: TextSpan(
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.normal,
            //                     color: Colors.black),
            //                 text: notificationsList[index].msg,
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     }),
          )
        ],
      ),
    );
  }
}
