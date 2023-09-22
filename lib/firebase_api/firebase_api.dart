import 'dart:convert';

import 'package:bottom_navigation_and_drawer/main.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  //we need instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    //request permission from user prompt
    await _firebaseMessaging.requestPermission();

    //fetch the fcm token
    final fcmToken = await _firebaseMessaging.getToken();

    //print the fcm token (we will send it to the server)
    print("TOken: " + fcmToken.toString());
    await sendToken(fcmToken.toString());
    initPushNotification();
  }

  //function to handle received messages
  Future<void> handleMessage(RemoteMessage? message) async {
    //if message is null do nothing
    if (message == null) {
      return null;
    }
    //navigate to the screen when message is received and user taps on notification
    await navigatorKey.currentState
        ?.pushNamed(MyRoutes.notification, arguments: message);
  }

  Future<void> handleBackgroundMessage(RemoteMessage? message) async {
    //if message is null do nothing
    if (message == null) {
      return null;
    }
    //navigate to the screen when message is received and user taps on notification
    await navigatorKey.currentState
        ?.pushNamed(MyRoutes.notification, arguments: message);
  }

  //function to initialize foreground and background settings
  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //handle notification if app was terminated and opened up
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));

    //attach eventlisteners when notification opens the app
    // FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));

    // FirebaseMessaging.onBackgroundMessage((handleBackgroundMessage));
    // FirebaseMessaging.onMessage.listen((message) {
    //   final notification = message.notification;
    //   if (notification == null) return;
    //   _localNotifications.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //           _androidChannel.id, _androidChannel.name,
    //           channelDescription: _androidChannel.description,
    //           icon: '@drawable/ic_launcher'),
    //     ),
    //     payload: jsonEncode(message.toMap()),
    //   );
    // });
  }
}

Future<void> sendToken(String token) async {
  final response = await http.post(
    Uri.parse('https://globalhealth-forum.com/event_app/api/post_token.php'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "token_id": token,
    }),
  );
}
