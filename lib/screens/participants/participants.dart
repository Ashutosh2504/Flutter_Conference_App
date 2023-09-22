import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/participants/participants_info.dart';
import 'package:bottom_navigation_and_drawer/screens/participants/participants_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyParticipants extends StatefulWidget {
  const MyParticipants({super.key});

  @override
  State<MyParticipants> createState() => _MyParticipantsState();
}

class _MyParticipantsState extends State<MyParticipants> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);
  var prefs;
  var get_mail;
  var user_email;
  var get_logged_in;
  var logged_in;
  bool loggedIn = false;
  final Color color = Color.fromARGB(255, 15, 158, 174);

  List<ParticipantsModel> _participantsList = [];
  List<ParticipantsModel> _foundParticipants = [];

  final dio = Dio();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPreferences();
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.info_outline,
                color: titleColor,
              ),
              Text(
                "Please click on the mail icon to send connect mail to other participant",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                    color: titleColor),
              ),
            ],
          ),
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
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => ParticipantsInfo(
                      //             participant: _foundParticipants[index])));
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _foundParticipants[index].name,
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: titleColor),
                                      ),
                                      Text(
                                        _foundParticipants[index].designation,
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        _foundParticipants[index].institution,
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                        //overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await pushNotification(
                                    _foundParticipants[index].email);
                              },
                              child: Icon(
                                Icons.outgoing_mail,
                                color: titleColor,
                                size: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
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
      //_foundParticipants.sort();
    });
  }

  pushNotification(String participantMail) async {
    var prefs = await SharedPreferences.getInstance();
    var get_mail = prefs.getString("email");
    var user_email = get_mail != null ? get_mail : "";

    if (loggedIn) {
      var response = await http.get(
        Uri.parse(
            "https://globalhealth-forum.com/event_app/api/send_participant_email.php?participant_email=${participantMail}&user_email=${user_email}"),
      );
      if (response.statusCode == 200) {
        showAlert(true);
      } else {
        showAlert(false);
      }
    } else {
      QuickAlert.show(
          confirmBtnColor: color,
          context: context,
          text: "Please Login...",
          type: QuickAlertType.warning);
    }
  }

  void showAlert(bool success) {
    if (success) {
      QuickAlert.show(
          confirmBtnColor: color,
          context: context,
          text: "Mail sent..",
          type: QuickAlertType.success);
    } else {
      QuickAlert.show(
          confirmBtnColor: color,
          context: context,
          text: "Failed to send mail",
          type: QuickAlertType.error);
    }
  }

  void getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    get_mail = prefs.getString("email");
    get_logged_in = prefs.getString("logged_in");
    user_email = get_mail != null ? get_mail : "";
    logged_in = get_logged_in != null ? get_logged_in : "false";
    if (logged_in != null) {
      if (logged_in == "false") {
        loggedIn = false;
      } else {
        loggedIn = true;
      }
    }
    setState(() {});
  }
}
