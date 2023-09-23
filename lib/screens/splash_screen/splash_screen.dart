import 'dart:async';

import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:flutter/material.dart';

import '../login/login_page.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyBottomNavigationBar(
              selectedIndex: 0,
            ),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Image.asset(
        "assets/images/logo2.jpg",
        fit: screenWidth > 800 ? BoxFit.fill : BoxFit.cover,
        height: screenHeight,
        width: screenWidth,
        // scale: 1.6,
        //alignment: Alignment.center,
      ),
    );
  }
}
