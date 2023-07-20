import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MySponsers extends StatefulWidget {
  const MySponsers({super.key});

  @override
  State<MySponsers> createState() => _MySponsersState();
}

class _MySponsersState extends State<MySponsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Sponsers"),
      ),
      body: Center(
        child: Text("Sponser List"),
      ),
    );
  }
}
