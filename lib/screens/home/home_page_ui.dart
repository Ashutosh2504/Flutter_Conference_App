import 'package:bottom_navigation_and_drawer/screens/home/countdown.dart';
import 'package:bottom_navigation_and_drawer/types/homegridhorizontallist.dart';
import 'package:bottom_navigation_and_drawer/util/routes.dart';
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
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/ghf.png"))),
              child: MyConutDownTimer()),
        ),
        // Expanded(
        //   child: ListView.builder(
        //     // physics: NeverScrollableScrollPhysics(),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: 3,
        //     itemBuilder: (context, index) {
        //       return MyHomeGridHorizontalList();
        //     },
        //   ),
        // ),
        Expanded(
          flex: 4,
          child: Container(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                children: [
                  InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, MyRoutes.agenda)},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/contact.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Agenda"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, MyRoutes.speakersList)},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/speech.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Speakers"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      Navigator.pushNamed(context, MyRoutes.sponsers),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/sponser.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Exhibitors"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  //Live
                  InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, MyRoutes.gallery)},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/live.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Live"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      // Navigator.pushNamed(context, MyRoutes.agenda),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/favourite.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Favourites"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //Navigator.pushNamed(context, MyRoutes.agenda),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/download.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Downloads"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //Navigator.pushNamed(context, MyRoutes.agenda),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/group.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Participants"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      // Navigator.pushNamed(context, MyRoutes.agenda),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/faq.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "FAQ"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  //Live polling
                  InkWell(
                    onTap: () => {
                      // Navigator.pushNamed(context, MyRoutes.gallery),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/live.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Live Polling"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      // Navigator.pushNamed(context, MyRoutes.agenda),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/quiz.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Quiz"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () =>
                        {Navigator.pushNamed(context, MyRoutes.gallery)},
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/gallery.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Gallery"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => {
                      //Navigator.pushNamed(context, MyRoutes.gallery),
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/location.png",
                                //fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15),
                                  text: "Venue"),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                    ),
                  ),
                ],
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                        MediaQuery.of(context).size.aspectRatio * 3 / 2,
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
