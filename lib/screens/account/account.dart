import 'package:flutter/material.dart';

import '../drawers/sidemenu.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: Text("Account"),
      ),
    );
  }
}
