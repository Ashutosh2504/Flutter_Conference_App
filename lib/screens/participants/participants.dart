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
  List<ParticipantsModel> _foundParticipants = [];

  final dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getParticipants();
      setState(() {
        _foundParticipants = _participantsList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participants "),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => _runFilter(value.trim()),
            decoration: InputDecoration(
              labelText: "Search Participants",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _foundParticipants.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParticipantsInfo(
                                  participant: _foundParticipants[index])));
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
                                padding: const EdgeInsets.all(16.0),
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: _foundParticipants[index]
                                            .photo
                                            .isNotEmpty
                                        ? Image.network(
                                            _foundParticipants[index].photo,
                                            fit: BoxFit.cover,
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                "assets/images/user.png"),
                                          )),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 8),
                                  // padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _foundParticipants[index].name,
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.pinkAccent),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          _foundParticipants[index].designation,
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
                                        flex: 2,
                                        child: Text(
                                          _foundParticipants[index].institution,
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          //overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black),
                                        ),
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
            ),
          ),
        ],
      ),
    );
  }

  Future getParticipants() async {
    try {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_participants.php');

      if (response.statusCode == 200) {
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
        setState(() {});
        print(_participantsList.length);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _runFilter(String enteredKeyword) {
    List<ParticipantsModel> _results = [];

    if (enteredKeyword.isEmpty) {
      _results = _participantsList;
    } else {
      _results = _participantsList
          .where((participant) => participant.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundParticipants = _results;
    });
  }
}
