import 'dart:math';

import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/notifications/notifications_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key, required this.notificationsData});
  final RemoteNotification? notificationsData;

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  final dio = Dio();
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

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
    //var message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: titleColor),
                  text: "New Notifications: ",
                ),
              ),
            ),
            widget.notificationsData != null
                ? Expanded(
                    child: Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                text: widget.notificationsData != null
                                    ? widget.notificationsData!.title.toString()
                                    : "",
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blueGrey),
                                text:
                                    widget.notificationsData?.body.toString() ??
                                        "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("No new Notifications"),
                  ),
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
                            padding: const EdgeInsets.all(4.0),
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey),
                                          text: notificationsList[index].date,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black),
                                              text: notificationsList[index]
                                                  .notiTopic,
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: titleColor),
                                              text:
                                                  notificationsList[index].msg,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
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
      ),
    );
  }
}
