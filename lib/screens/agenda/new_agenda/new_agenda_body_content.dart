import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/check_favourite_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_info.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class NewAgendaBodyContent extends StatefulWidget {
  const NewAgendaBodyContent(
      {super.key,
      required this.agendaListFromParentComponent,
      });

  final List<NewAgendaModel> agendaListFromParentComponent;

  //final Future<dynamic> Function() getAgendas;

  @override
  State<NewAgendaBodyContent> createState() => _NewAgendaBodyContentState();
}

class _NewAgendaBodyContentState extends State<NewAgendaBodyContent> {
  var prefs;
  var get_mail;
  var user_email;
  var userId;
  var user_id;
  var get_logged_in;
  var logged_in;
  bool loggedIn = false;
  bool changeBtn = false;
  final Color color = Color.fromARGB(255, 15, 158, 174);

  List<NewAgendaModel> _foundAgendas = [];
  Dio dio = new Dio();
  void showAlert() {
    QuickAlert.show(
        confirmBtnColor: color,
        context: context,
        text: "Already added to favourites !",
        type: QuickAlertType.warning);
  }

  @override
  void initState() {
    
    getPreferences();
    setState(() {
      _foundAgendas = [...widget.agendaListFromParentComponent];
    });

    super.initState();
  }

  void getPreferences() async {
    prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString("user_id");
    get_logged_in = prefs.getString("logged_in");
    userId = user_id != null ? user_id : "";
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

  Future checkFavourite(String agendaId, String userId, int index) async {
    setState(() {
      changeBtn = true;
    });
    if (agendaId.isNotEmpty) {
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/check_favorite.php?user_id=${userId}&agenda_id=${agendaId}');
      if (response.statusCode == 200) {
        print(response.data);
        var jsonData = (response.data);
        var checkFavouriite = CheckFavouriteModel.fromJson(jsonData);

        if (checkFavouriite.msg.toString() == "Yes") {
          _foundAgendas[index].isFavourite = "Already Added";
        }

        setState(() {
          changeBtn = false;
        });
      }
    } else {
      showAlert();
    }
  }

  Future<void> addToFavourites(NewAgendaModel agenda, int index) async {
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
        "agenda_id": agenda.agenda_id.toString(),
        "user_id": userId
      }),
    );

    if (response.statusCode == 200) {
      _foundAgendas[index].isFavourite = "Already Added";
      setState(() {});
      //await widget.getAgendas();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // Alerts.showAlert(false, context, "You are not logged in");
      showAlert();
    }

    // final response = await dio
    //     .post('https://globalhealth-forum.com/event_app/api/post_favorite.php');
    // var jsonData = (response.data);
  }

  void _runFilter(String enteredKeyword) {
    List<NewAgendaModel> _results = [];

    if (enteredKeyword.isEmpty) {
      _results = widget.agendaListFromParentComponent;
    } else {
      _results = widget.agendaListFromParentComponent
          .where((agenda) =>
              agenda.Topic.toLowerCase().contains(enteredKeyword.toLowerCase()))
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
                    labelText: "Search Agendas",
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
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewAgendaInfo(
                                  agendaModel: _foundAgendas[index],
                                  speakerList: _foundAgendas[index].speakers,
                                );
                              },
                            ),
                          );
                        },
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
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blueGrey),
                                          text: _foundAgendas[index].from_time +
                                              " - " +
                                              _foundAgendas[index].to_time,
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
                                        onPressed: () async {
                                          if (loggedIn) {
                                            addToFavourites(
                                                _foundAgendas[index], index);
                                          } else {
                                            await Alerts.showAlert(
                                                loggedIn,
                                                context,
                                                "Not Logged In. Please Login");
                                          }
                                          // loggedIn
                                          //     ? await checkFavourite(
                                          //         _foundAgendas[index]
                                          //             .agenda_id,
                                          //         userId,
                                          //         index)
                                          //     : await Alerts.showAlert(
                                          //         loggedIn,
                                          //         context,
                                          //         "Not Logged In. Please Login");
                                          // loggedIn
                                          //     ? addToFavourites(
                                          //         _foundAgendas[index], index)
                                          //     : await Alerts.showAlert(
                                          //         loggedIn,
                                          //         context,
                                          //         "Not Logged In. Please Login");
                                          //                 Navigator.pushReplacement(
                                          // context,
                                          // MaterialPageRoute(
                                          //     builder: (context) => LoginPage()));
                                        },
                                        style: ButtonStyle(
                                            elevation:
                                                MaterialStatePropertyAll(3),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    (_foundAgendas[index]
                                                                .isFavourite ==
                                                            "Add to Favourites"
                                                        ? Colors.blue
                                                        : Colors.grey))),
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
                                "Topic: ${_foundAgendas[index].Topic} ",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.pinkAccent),
                              ),
                            ],
                          ),
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
