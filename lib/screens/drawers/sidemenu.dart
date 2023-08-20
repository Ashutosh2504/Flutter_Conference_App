import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/contactus/contact_us.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/scientific_programs/scientific_programs.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var user_email = "";
  var user_name = "";

  @override
  void initState() {
    setData();

    // TODO: implement initState
    super.initState();
    setData();
  }

  void setData() async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.get("email");
    var name = prefs.get("name");
    user_email = email != null ? email.toString() : " ";
    user_name = name != null ? name.toString() : " ";
    setState(() {});
  }

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
              accountName: Text(user_name),
              accountEmail: Text(user_email),
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
            leading: Icon(Icons.poll),
            title: Text("Survey"),
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
            leading: Icon(Icons.call),
            title: Text("Key Contacts"),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => (MyContactUs())))
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text("FAQ"),
            onTap: () => {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyContactUs()))
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginPage()))
            },
          ),
        ],
      ),
    );
  }
}
