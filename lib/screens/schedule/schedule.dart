import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:flutter/material.dart';

class MyScheduler extends StatefulWidget {
  const MyScheduler({super.key});

  @override
  State<MyScheduler> createState() => _MySchedulerState();
}

class _MySchedulerState extends State<MyScheduler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Scheduler"),
      ),
      body: Center(
        child: Text("Scheduler"),
      ),
    );
  }
}
