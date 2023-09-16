// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:flutter/material.dart';

class MySquareGridList extends StatefulWidget {
  // final int id;
  // final String name;
  // final String email;
  // final String mobile;
  // final String designation;
  // final String institute;
  // final String information;
  // final String city;
  // final String country;
  // final String photo;
  // final String date;
  // final String status;

  // final List<SpeakerModel> speakerModel;
  final SpeakerModel speakerModel;
  //final int index;
  // MySquareGridList({
  //   required this.id,
  //   required this.name,
  //   required this.email,
  //   required this.mobile,
  //   required this.designation,
  //   required this.institute,
  //   required this.information,
  //   required this.city,
  //   required this.country,
  //   required this.photo,
  //   required this.date,
  //   required this.status,
  // });

  MySquareGridList({required this.speakerModel});

  @override
  State<MySquareGridList> createState() => _MySquareGridListState();
}

class _MySquareGridListState extends State<MySquareGridList> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MySpeakerInfo(speakersList: widget.speakerModel)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 8,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    widget.speakerModel.photo,
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
                text: widget.speakerModel.name,
              ),
            ),
          ),
          // RichText(
          //   softWrap: true,
          //   textAlign: TextAlign.center,
          //   text: TextSpan(
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontWeight: FontWeight.w300,
          //         fontSize: 13),
          //     text: widget.speakerModel.designation,
          //   ),
          // ),
        ],
      ),
    );
  }
}
