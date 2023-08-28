import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/participants/participants_info.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participants "),
      ),
      body: FutureBuilder(
          future: getParticipants(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: ListView.builder(
                  itemCount: _participantsList.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ParticipantsInfo(
                                    participant: _participantsList[index])));
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                            height: MediaQuery.of(context).size.height / 6,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      _participantsList[index].photo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 16),
                                    // padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _participantsList[index].name,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.pinkAccent),
                                        ),
                                        Text(
                                          _participantsList[index].designation,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          _participantsList[index].institution,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future getParticipants() async {
    try {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_participants.php');

      var jsonData = (response.data);
      for (var item in jsonData) {
        final participant = ParticipantsModel(
            id: item['id'],
            name: item['name'],
            email: item['email'],
            mobile: item['mobile'],
            gender: item['gender'],
            city: item['city'],
            designation: item['designation'],
            institution: item['institution'],
            photo: item['photo'],
            otp: item['otp']);
        _participantsList.add(participant);
      }
      print(_participantsList.length);
    } catch (e) {
      print(e.toString());
    }
  }
}
