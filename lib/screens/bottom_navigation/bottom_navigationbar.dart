import 'package:bottom_navigation_and_drawer/screens/agenda/agenda.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda.dart';
import 'package:bottom_navigation_and_drawer/screens/downloads/downlads.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/favourites/favourites.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:bottom_navigation_and_drawer/screens/live/live.dart';
import 'package:bottom_navigation_and_drawer/screens/notifications/notification.dart';
import 'package:bottom_navigation_and_drawer/screens/programs/programs.dart';
import 'package:bottom_navigation_and_drawer/screens/quiz/quiz.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speakers_list.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  int selectedIndex = 0;

  MyBottomNavigationBar({required this.selectedIndex});

  @override
  State<MyBottomNavigationBar> createState() => My_BottomNavigationBarState();
}

class My_BottomNavigationBarState extends State<MyBottomNavigationBar> {
  int currentIndex = 0;
  final Color color = Color.fromARGB(255, 42, 172, 175);

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      currentIndex = widget.selectedIndex;
    });
  }

  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    super.initState();
  }

  final List<Widget> pages = [
    MyHome(),
    MyPrograms(),
    MySpeakersList(),
    MyFavourites(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });
    }

    Widget currentScreen = currentIndex == 0
        ? MyHome()
        : currentIndex == 1
            ? MyNewAgenda()
            : currentIndex == 2
                ? MyNotifications(
                    notificationsData: null,
                  )
                : MyLive();

    return Scaffold(
      drawer: SideMenu(),
      body: PageStorage(child: currentScreen, bucket: bucket),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(
      //     Icons.search_rounded,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Color.fromARGB(255, 135, 205, 240),
      //   onPressed: () => {
      //     Navigator.pushNamed(context, MyRoutes.search),
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 38, 156, 179),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_agenda),
            label: 'Agenda',
            backgroundColor: Color.fromARGB(255, 38, 156, 179),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: Color.fromARGB(255, 38, 156, 179),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
            backgroundColor: Color.fromARGB(255, 38, 156, 179),
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      /*  BottomAppBar(
        color: color,
        shape: CircularNotchedRectangle(),
        shadowColor: Colors.white,
        notchMargin: 10,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyHome();
                        currentIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentIndex == 0
                              ? Colors.lightGreenAccent
                              : Colors.white,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentIndex == 0
                                ? Colors.lightGreenAccent
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyPrograms();
                        currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.festival,
                          color: currentIndex == 1
                              ? Colors.lightGreenAccent
                              : Colors.white,
                        ),
                        Text(
                          "Programs",
                          style: TextStyle(
                            color: currentIndex == 1
                                ? Colors.lightGreenAccent
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyDownloads();
                        currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download,
                          color: currentIndex == 2
                              ? Colors.lightGreenAccent
                              : Colors.white,
                        ),
                        Text(
                          "Downloads",
                          style: TextStyle(
                            color: currentIndex == 2
                                ? Colors.lightGreenAccent
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 50,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyFavourites();
                        currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          color: currentIndex == 3
                              ? Colors.lightGreenAccent
                              : Colors.white,
                        ),
                        Text(
                          " Favourites",
                          style: TextStyle(
                            color: currentIndex == 3
                                ? Colors.lightGreenAccent
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ), */
    );
  }
}
