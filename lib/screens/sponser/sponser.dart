import 'package:flutter/material.dart';

class MySponsers extends StatefulWidget {
  const MySponsers({super.key});

  @override
  State<MySponsers> createState() => _MySponsersState();
}

class _MySponsersState extends State<MySponsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sponsers"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/images/join_us.jpg",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "Platinum Partners",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "These exceptional partners are the epitome of excellence, bringing their unrivaled expertise and unmatched reputation to the forefront. ",
              textAlign: TextAlign.left,
              softWrap: true,
              //overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      "assets/images/pp1.png",
                      //height: 200,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      "assets/images/pp2.png",
                      // height: 200,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.asset(
                      "assets/images/gp1.png",
                      //height: 200,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    child: Image.asset(
                      "assets/images/gp2.png",
                      // height: 200,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // RichText(
          //   text: TextSpan(
          //     text: 'Hello ',
          //     style: DefaultTextStyle.of(context).style,
          //     children: const <TextSpan>[
          //       TextSpan(
          //           text: 'bold',
          //           style: TextStyle(fontWeight: FontWeight.bold)),
          //       //TextSpan(text: ' world!'),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
