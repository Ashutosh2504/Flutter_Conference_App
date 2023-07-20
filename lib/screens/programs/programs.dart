import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:flutter/material.dart';

class MyPrograms extends StatefulWidget {
  const MyPrograms({super.key});

  @override
  State<MyPrograms> createState() => _MyProgramsState();
}

class _MyProgramsState extends State<MyPrograms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Programs"),
      ),
      body: Center(
        child: Text("Programs"),
      ),
    );
  }
}
