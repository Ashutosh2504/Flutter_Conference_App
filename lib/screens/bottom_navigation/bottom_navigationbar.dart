import 'package:bottom_navigation_and_drawer/screens/favourites/favourites.dart';
import 'package:bottom_navigation_and_drawer/screens/home/home.dart';
import 'package:bottom_navigation_and_drawer/screens/programs/programs.dart';
import 'package:bottom_navigation_and_drawer/screens/scientific_programs/scientific_programs.dart';
import 'package:bottom_navigation_and_drawer/screens/search/search.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speakers.dart';
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
    MySpeakers(),
    MyFavourites(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Widget currentScreen = currentIndex == 0
        ? MyHome()
        : currentIndex == 1
            ? MyPrograms()
            : currentIndex == 2
                ? MySpeakers()
                : MyFavourites();

    return Scaffold(
      body: PageStorage(child: currentScreen, bucket: bucket),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.search_rounded,
            color: Colors.white,
          ),
          backgroundColor: Color.fromARGB(255, 135, 205, 240),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MySearch()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: BottomAppBar(
        color: color,
        shape: CircularNotchedRectangle(),
        shadowColor: Colors.white,
        notchMargin: 10,
        child: Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        currentScreen = MyHome();
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
                        currentScreen = MyHome();
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
      ),
    );
  }
}
