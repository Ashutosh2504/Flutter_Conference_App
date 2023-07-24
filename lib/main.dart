import 'package:bottom_navigation_and_drawer/screens/agenda/agenda.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speakers_list.dart';
import 'package:bottom_navigation_and_drawer/screens/sponser/sponser.dart';
import 'package:flutter/material.dart';

import 'screens/gallery/gallery.dart';
import 'util/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final Color color = const Color(0xFF01909f);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
      ),
      home: MyBottomNavigationBar(
        selectedIndex: 0,
      ),
      routes: {
        // "/": (context) => MySpashScreen(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => MyHome(),
        // MyRoutes.splashScreen: (context) => MySpashScreen(),
        MyRoutes.speakersInfo: (context) => MySpeakerInfo(),
        MyRoutes.speakersList: (context) => MySpeakersList(),
        MyRoutes.gallery: (context) => MyGallery(),
        MyRoutes.sponsers: (context) => MySponsers(),
        MyRoutes.agenda: (context) => MyAgenda(),
      },
    );
  }
}
