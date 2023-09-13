import 'package:bottom_navigation_and_drawer/firebase_api/firebase_api.dart';
import 'package:bottom_navigation_and_drawer/firebase_options.dart';
import 'package:bottom_navigation_and_drawer/screens/notifications/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bottom_navigation_and_drawer/screens/agenda/agenda.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda.dart';
import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/downloads/downlads.dart';
import 'package:bottom_navigation_and_drawer/screens/faq/faq.dart';
import 'package:bottom_navigation_and_drawer/screens/favourites/favourites.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:bottom_navigation_and_drawer/screens/live/live.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/quiz/quiz.dart';
import 'package:bottom_navigation_and_drawer/screens/search/search.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speakers_list.dart';
import 'package:bottom_navigation_and_drawer/screens/sponser/sponser.dart';
import 'package:bottom_navigation_and_drawer/screens/venue/venue.dart';

import 'screens/gallery/gallery.dart';
import 'screens/login/compare_otp.dart';
import 'screens/participants/participants.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'util/routes.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final Color color = const Color(0xFF01909f);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portugal Health Forum',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
      ),
      // home: MyBottomNavigationBar(
      //   selectedIndex: 0,
      // ),
      navigatorKey: navigatorKey,
      routes: {
        "/": (context) => MySplashScreen(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => MyHome(),
        // MyRoutes.splashScreen: (context) => MySpashScreen(),
        // MyRoutes.speakersInfo: (context) => MySpeakerInfo(),
        MyRoutes.speakersList: (context) => MySpeakersList(),
        MyRoutes.gallery: (context) => MyGallery(),
        MyRoutes.sponsers: (context) => MySponsers(),
        MyRoutes.agenda: (context) => MyAgenda(),
        MyRoutes.search: (context) => MySearch(),
        MyRoutes.favourite: (context) => MyFavourites(),
        MyRoutes.download: (context) => MyDownloads(),
        MyRoutes.participants: (context) => MyParticipants(),
        MyRoutes.compareOTP: (context) => MyCompareOTP(),
        MyRoutes.faq: (context) => MyFaq(),
        MyRoutes.venue: (context) => MyVenue(),
        MyRoutes.quiz: (context) => MyQuiz(),
        MyRoutes.new_agenda: (context) => MyNewAgenda(),
        MyRoutes.live: (context) => MyLive(),
        MyRoutes.notification: (context) => MyNotifications(),
      },
    );
  }
}
