import 'package:bottom_navigation_and_drawer/util/routes.dart';
import 'package:flutter/material.dart';

class MySquareGridList extends StatelessWidget {
  final String name;
  MySquareGridList({required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.speakersInfo);
      },
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                //color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: CircleAvatar(
                radius: 45,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/dr2.png",
                    // // subject['images']['large'],
                    // height: 150.0,
                    // width: 100.0,
                    fit: BoxFit.fill,
                  ),
                  // child: CachedNetworkImage(
                  //   imageUrl:  "https:// your image url path",
                  //   fit: BoxFit.cover,
                  //   width: 80,
                  //   height: 80,
                  // ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //this is heading
            Container(
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //this is subheading
            Container(
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 13),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            //this is sub subheading
            Container(
              child: Text(
                name,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                    fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
