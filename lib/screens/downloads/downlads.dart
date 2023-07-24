import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MyDownloads extends StatefulWidget {
  const MyDownloads({super.key});

  @override
  State<MyDownloads> createState() => _MyDownloadsState();
}

class _MyDownloadsState extends State<MyDownloads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Downloads "),
      ),
      body: Center(
        child: Text("Downloads"),
      ),
    );
  }
}
