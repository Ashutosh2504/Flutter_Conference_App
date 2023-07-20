import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MySpeakers extends StatefulWidget {
  const MySpeakers({super.key});

  @override
  State<MySpeakers> createState() => _MySpeakersState();
}

class _MySpeakersState extends State<MySpeakers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Speakers"),
      ),
      body: Center(
        child: Text("Speakers"),
      ),
    );
  }
}
