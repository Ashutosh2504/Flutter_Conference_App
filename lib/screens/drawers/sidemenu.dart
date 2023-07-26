import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/contactus/contact_us.dart';
import 'package:bottom_navigation_and_drawer/screens/scientific_programs/scientific_programs.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text("Ashutosh Patil"),
              accountEmail: Text("ashutosh@gmail.com"),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/dr2.png")),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBottomNavigationBar(
                            selectedIndex: 0,
                          )))
            },
          ),
          ListTile(
            leading: Icon(Icons.festival),
            title: Text("Programs"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBottomNavigationBar(
                            selectedIndex: 1,
                          )))
            },
          ),
          ListTile(
            leading: Icon(Icons.science),
            title: Text("Scientific Programs"),
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyScietificPrograms()))
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_support),
            title: Text("Contact Us"),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyContactUs()))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyContactUs()))
            },
          ),
        ],
      ),
    );
  }
}
