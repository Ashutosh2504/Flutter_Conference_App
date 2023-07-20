import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MyScietificPrograms extends StatefulWidget {
  const MyScietificPrograms({super.key});

  @override
  State<MyScietificPrograms> createState() => _MyScietificProgramsState();
}

class _MyScietificProgramsState extends State<MyScietificPrograms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Scientific Programs"),
      ),
      body: Center(
        child: Text("Scientific Programs"),
      ),
    );
  }
}
