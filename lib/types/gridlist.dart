// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:flutter/material.dart';

import 'package:bottom_navigation_and_drawer/util/routes.dart';

class MySquareGridList extends StatelessWidget {
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

  final List<SpeakerModel> speakerModel;
  final int index;
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

  MySquareGridList({required this.index, required this.speakerModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MySpeakerInfo(index: index, speakersList: speakerModel)));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(speakerModel[index].photo),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
              text: speakerModel[index].name,
            ),
          ),
          RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w300,
                  fontSize: 13),
              text: speakerModel[index].designation,
            ),
          ),
        ],
      ),
    );
  }
}
