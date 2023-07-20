import 'package:bottom_navigation_and_drawer/screens/speaker/speakers.dart';
import 'package:flutter/material.dart';

class MyHomePageUi extends StatefulWidget {
  const MyHomePageUi({super.key});

  @override
  State<MyHomePageUi> createState() => _MyHomePageUiState();
}

class _MyHomePageUiState extends State<MyHomePageUi> {
  final Color color = Color.fromARGB(255, 170, 232, 238);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          children: [
            InkWell(
              onTap: () => {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MySpeakers()))
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset("assets/images/speech.png"),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Speakers",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/exhibitor.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Exhibitors",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/favourite.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Favourites",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/scientific.png"),
                    Text(
                      "Scientific Program",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/group.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Participants",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/download2.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Downloads",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/gallery.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Gallery",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/documents2.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Documents",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/attendees.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Attendees",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/survey.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Survey",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/quiz.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Quiz",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/polling.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Polling",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/faq.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "FAQ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/sponser.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Sponsers",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/images/contact.png"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Contact Us",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
            ),
          ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: MediaQuery.of(context).size.aspectRatio * 3 / 2,
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
        ),
      ),
    );
  }
}
