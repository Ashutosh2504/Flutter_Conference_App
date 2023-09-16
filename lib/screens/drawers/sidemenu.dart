import 'package:bottom_navigation_and_drawer/screens/bottom_navigation/bottom_navigationbar.dart';
import 'package:bottom_navigation_and_drawer/screens/contactus/contact_us.dart';
import 'package:bottom_navigation_and_drawer/screens/faq/faq.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/scientific_programs/scientific_programs.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:bottom_navigation_and_drawer/util/webview.dart';
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
  var user_id = "";
  var logged_in;
  bool loggedIn = false;
  var get_logged_in;

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
    var logIn = prefs.get("logged_in");
    var userId = prefs.get("user_id");
    user_id = userId != null ? userId.toString() : " ";
    user_email = email != null ? email.toString() : " ";
    user_name = name != null ? name.toString() : " ";
    logged_in = logIn != null ? logIn : "false";
    if (logged_in != null) {
      if (logged_in == "false") {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
    }
    setState(() {});
  }

  Future<void> logOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
                backgroundImage: AssetImage("assets/images/user.png"),
                backgroundColor: Colors.white,
              ),
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
            onTap: loggedIn
                ? () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctxt) => WebviewComponent(
                            title: "Survey",
                            webviewUrl:
                                "https://globalhealth-forum.com/event_app/survey.php?user_id=${user_id}&email_id=${user_email}"),
                      ),
                    );
                  }
                : () async {
                    await Alerts.showAlert(
                        loggedIn, context, "Not Logged In. Please Login");
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()));
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyFaq()))
            },
          ),
          loggedIn
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                  onTap: () async {
                    await logOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHome()));
                  },
                )
              : ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Login"),
                  onTap: () async {
                    await logOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
        ],
      ),
    );
  }
}
