import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../speaker/speaker_info.dart';
import 'agenda_info.dart';
import 'agenda_model.dart';
import 'package:http/http.dart' as http;

class AgendaBodyContent extends StatefulWidget {
  const AgendaBodyContent(
      {super.key,
      required this.agendaListFromParentComponent,
      required this.speakersOnSelectedDate,
      required this.getAgendas});

  final List<AgendaModel> agendaListFromParentComponent;
  final List<SpeakerModel> speakersOnSelectedDate;

  final Future<dynamic> Function() getAgendas;

  @override
  State<AgendaBodyContent> createState() => _AgendaBodyContentState();
}

class _AgendaBodyContentState extends State<AgendaBodyContent> {
  final Color color = Color.fromARGB(255, 15, 158, 174);

  List<AgendaModel> _foundAgendas = [];
  List<SpeakerModel> _foundSpeakers = [];

  void showAlert() {
    QuickAlert.show(
        confirmBtnColor: color,
        context: context,
        text: "Already added to favourites !",
        type: QuickAlertType.warning);
  }

  @override
  void initState() {
    setState(() {
      _foundAgendas = widget.agendaListFromParentComponent;
      _foundSpeakers = widget.speakersOnSelectedDate;
    });
    super.initState();
  }

  Future<void> addToFavourites(AgendaModel agenda, int index) async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    String userId = user_id != null ? user_id : "";
    final response = await http.post(
      Uri.parse(
          'https://globalhealth-forum.com/event_app/api/post_favorite.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "agenda_id": agenda.id.toString(),
        "user_id": userId
      }),
    );

    if (response.statusCode == 200) {
      _foundAgendas[index].isFavourite = "Already Added";
      //await widget.getAgendas();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.

      showAlert();
    }

    // final response = await dio
    //     .post('https://globalhealth-forum.com/event_app/api/post_favorite.php');
    // var jsonData = (response.data);
  }

  void _runFilter(String enteredKeyword) {
    List<AgendaModel> _results = [];

    if (enteredKeyword.isEmpty) {
      _results = widget.agendaListFromParentComponent;
    } else {
      _results = widget.agendaListFromParentComponent
          .where((agenda) =>
              agenda.topic.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAgendas = _results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.agendaListFromParentComponent.isEmpty)
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // const SizedBox(
                //   height: 30,
                // ),
                TextField(
                  onChanged: (value) => _runFilter(value.trim()),
                  decoration: InputDecoration(
                    labelText: "Select Speaker",
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _foundAgendas.length,
                    itemBuilder: (context, index) => Card(
                      // key: ValueKey(_foundAgendas[index]),
                      color: Colors.blueGrey[50],
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey),
                                        text: _foundAgendas[index].fromTime +
                                            " - " +
                                            _foundAgendas[index].toTime,
                                      ),
                                    ),
                                  ),
                                  // RichText(
                                  //   text: TextSpan(
                                  //     style: TextStyle(
                                  //         fontSize: 18,
                                  //         fontWeight:
                                  //             FontWeight.bold,
                                  //         color:
                                  //             Colors.blueGrey),
                                  //     text:
                                  //         "Places:${_foundAgendas[index].time}",
                                  //   ),
                                  // ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        addToFavourites(
                                            _foundAgendas[index], index);
                                      },
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStatePropertyAll(3),
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                                  (_foundAgendas[index]
                                                          .isFavourite
                                                          .isNotEmpty
                                                      ? Colors.grey
                                                      : Colors.blue))),
                                      child: Text(
                                        _foundAgendas[index].isFavourite,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyAgendaInfo(
                                              agendaModel: _foundAgendas[index],
                                              speakerList: _foundSpeakers,
                                            )));
                              },
                              child: Text(
                                "Topic: ${_foundAgendas[index].topic} ",
                                style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.pinkAccent),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Colors.blueAccent,
                                ),
                                Text(
                                  _foundAgendas[index].hall,
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
                          ],
                        ),
                      ),
                    ),
                  ),

                  /*  */
                ),
              ],
            ),
          );
  }
}
