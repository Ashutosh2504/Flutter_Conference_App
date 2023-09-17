import 'package:bottom_navigation_and_drawer/firebase_api/messaging_service.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home_page_ui.dart';
import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _messaginService = MessagingService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _messaginService.init(context);
  }

  final Color color = Color.fromARGB(255, 170, 232, 238);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          "Global Health Forum",
          style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
      ),
      body: MyHomePageUi(),
    );
  }
}
