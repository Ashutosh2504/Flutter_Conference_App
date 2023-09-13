import 'package:bottom_navigation_and_drawer/main.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
    initPushNotification();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message) {
    //if message is null do nothing
    if (message == null) {
      return null;
    }
    //navigate to the screen when message is received and user taps on notification
    navigatorKey.currentState
        ?.pushNamed(MyRoutes.notification, arguments: message);
  }

  //function to initialize foreground and background settings
  Future initPushNotification() async {
    //handle notification if app was terminated and opened up
    FirebaseMessaging.instance.getInitialMessage().then((handleMessage));

    //attach eventlisteners when notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen((handleMessage));
  }
}
