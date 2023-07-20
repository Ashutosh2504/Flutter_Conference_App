import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MyContactUs extends StatefulWidget {
  const MyContactUs({super.key});

  @override
  State<MyContactUs> createState() => _MyContactUsState();
}

class _MyContactUsState extends State<MyContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Center(
        child: Text("Contacts: 9999988888"),
      ),
    );
  }
}
