import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyAgenda extends StatefulWidget {
  const MyAgenda({super.key});

  @override
  State<MyAgenda> createState() => _MyAgendaState();
}

class _MyAgendaState extends State<MyAgenda> {
  List<AgendaModel> agendaList = [];
  List<SpeakerModel> speakersList = [];

  List<Map<String, dynamic>> _allAgendas = [
    {"id": 1, "name": "Gregory Mole", "place": "Kolkata"},
    {"id": 2, "name": "Himanshu Mole", "place": "Kolkata"},
    {"id": 3, "name": "Ashu Mole", "place": "Kolkata"},
    {"id": 4, "name": "Messi Mole", "place": "Kolkata"},
    {"id": 5, "name": "Gregory Mole", "place": "Kolkata"},
  ];

  // List<Map<String, dynamic>> _foundAgendas = [];

  List<AgendaModel> _foundAgendas = [];

  @override
  void initState() {
    _foundAgendas = agendaList;

    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    // List<Map<String, dynamic>> _results = [];
    List<AgendaModel> _results = [];

    if (enteredKeyword.isEmpty) {
      _results = agendaList;
    } else {
      _results = agendaList
          .where((agenda) => agenda.speaker_name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAgendas = _results;
    });
  }

  final dio = Dio();

  Future getAgendas() async {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_program.php');
    var jsonData = jsonDecode(response.data);
    for (var items in jsonData) {
      final agenda = AgendaModel(
          id: items['id'],
          speaker_name: items['speaker_name'],
          speaker_id: items['speaker_id'],
          hall: items['hall'],
          topic: items['topic'],
          date: items['date'],
          time: items['time'],
          current_date: items['current_date'],
          status: items['status']);
      agendaList.add(agenda);
    }
  }

  Future getSpeakers() async {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
    var jsonData = jsonDecode(response.data);
    for (var items in jsonData) {
      final speakers = SpeakerModel(
          id: items['id'],
          name: items['name'],
          email: items['email'],
          mobile: items['mobile'],
          designation: items['designation'],
          institute: items['institute'],
          information: items['information'],
          city: items['city'],
          country: items['country'],
          date: items['date'],
          photo: items['photo'],
          status: items['status']);

      speakersList.add(speakers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Agenda",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 30,
            // ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                labelText: "Select Hall",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: FutureBuilder(
                future: getAgendas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: agendaList.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(agendaList[index]),
                        color: Colors.blueGrey[50],
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                        text: agendaList[index].time,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                        text:
                                            "Places:${agendaList[index].time}",
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  Colors.lightBlue)),
                                      child: const Text(
                                        "Book",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "Topic: ${agendaList[index].topic} ",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.pinkAccent),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Colors.blueAccent,
                                  ),
                                  Text(
                                    agendaList[index].hall,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              Text(
                                "Speakers",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.blueGrey),
                              ),
                              FutureBuilder(
                                  future: getSpeakers(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          onTap: () {
                                            print(_foundAgendas.toString());
                                          },
                                          leading: CircleAvatar(
                                            radius: 25,
                                            child: ClipOval(
                                              child: Image.network(
                                                speakersList[index].photo,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            speakersList[index].name,
                                            style: TextStyle(
                                                color: Colors.pinkAccent,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                speakersList[index].designation,
                                                // _foundAgendas[index]["place"],
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                speakersList[index].city,
                                                style: TextStyle(
                                                    color: Colors.blueGrey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

              /*  */
            ),
          ],
        ),
      ),
    );
  }
}
