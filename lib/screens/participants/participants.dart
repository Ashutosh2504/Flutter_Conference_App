import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/participants/participants_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyParticipants extends StatefulWidget {
  const MyParticipants({super.key});

  @override
  State<MyParticipants> createState() => _MyParticipantsState();
}

class _MyParticipantsState extends State<MyParticipants> {


List<ParticipantsModel> _participantsList = [];
  final dio = Dio();

  // Future getSpeakers() async {
  //   final response = await dio
  //       .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
  //   var jsonData = jsonDecode(response.data);
  //   for (var items in jsonData) {
  //     final participants = ParticipantsModel(successCode: '', user: null
  //        );

  //     _participantsList.add(participants);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participants "),
      ),
      body: Container(),
    );
  }
}
