import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_info.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/post_favourite.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/favourites/favourite_model.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../speaker/speaker_info.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  List<List<AgendaModel>> dateWiseAgendaList = [];
  List<AgendaModel> agendaList29th = [];
  List<AgendaModel> agendaList30th = [];
  List<SpeakerModel> speakersList = [];
  List<SpeakerModel> agendaSpeakersList = [];
  List<FavouritesModel> favouritesList = [];
  final Color color = Color.fromARGB(255, 15, 158, 174);
  bool clicked = false;
  String favoutiteBtn = "Add to Favourites";
  List<AgendaModel> _foundAgendas = [];
  bool isLoading = false;
  var userId;
  @override
  void initState() {
    getFavourites();

    setState(() {
      _foundAgendas = agendaList29th;
      print("List of agendas: " + _foundAgendas.toString());
    });
    super.initState();
  }

  // void getPreferences() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var user_id = prefs.getString("user_id");
  //   userId = user_id != null ? user_id : "";
  // }

  void _runFilter(String enteredKeyword, int date) {
    List<AgendaModel> _results = [];
    List<AgendaModel> agendaList = [];
    if (date == 29) {
      agendaList = agendaList29th;
    } else {
      agendaList = agendaList30th;
    }
    if (enteredKeyword.isEmpty) {
      _results = agendaList;
    } else {
      _results = agendaList
          .where((agenda) => agenda.speakerName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundAgendas = _results;
    });
  }

  final dio = Dio();
  Future getFavourites() async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    userId = user_id != null ? user_id : "";
    final response = await dio.get(
        'https://globalhealth-forum.com/event_app/api/get_favorite.php?user_id=${2}');
    var jsonData = response.data;

    if (response.statusCode == 200) {
      for (var items in jsonData) {
        final favourites = FavouritesModel.fromJson(items);
        favouritesList.add(favourites);
        print(favouritesList.toString());
      }
      setState(() {
        // agendaList29th = dateWiseAgendaList.elementAt(0);

        // _foundAgendas = agendaList29th;
        // agendaList30th = dateWiseAgendaList.elementAt(1);
        isLoading = false;
      });

      print(favouritesList.toString());
    } else {}
  }

  // Future getAgendas() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://globalhealth-forum.com/event_app/api/get_datewise_agenda.php'));

  //     Map<String, List<AgendaModel>> agendaListMap =
  //         agendaModelFromJson(response.body);
  //     print(agendaListMap);
  //     agendaListMap.values.forEach((value) {
  //       dateWiseAgendaList.add(value);
  //     });

  //     setState(() {
  //       agendaList29th = dateWiseAgendaList.elementAt(0);

  //       _foundAgendas = agendaList29th;
  //       agendaList30th = dateWiseAgendaList.elementAt(1);
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future getSpeakers(int date) async {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
    var jsonData = (response.data);
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

    getSpeakersInAgenda(date);
  }

  void getSpeakersInAgenda(int date) {
    if (date == 29) {
      for (var i = 0; i < favouritesList.length; i++) {
        for (var j = 0; j < speakersList.length; j++) {
          if ((favouritesList[i].speakerName) == speakersList[j].name) {
            agendaSpeakersList.add(speakersList[j]);
          }
        }
      }
    } else {
      for (var i = 0; i < agendaList30th.length; i++) {
        for (var j = 0; j < speakersList.length; j++) {
          if (int.parse(agendaList30th[i].speakerId) == speakersList[j].id) {
            agendaSpeakersList.add(speakersList[j]);
          }
        }
      }
    }
  }

  void showAlert() {
    QuickAlert.show(
        confirmBtnColor: color,
        context: context,
        text: "Already added to favourites !",
        type: QuickAlertType.warning);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          drawer: SideMenu(),
          appBar: AppBar(
            title: Text(
              "My Favourites",
            ),
          ),
          body: Column(
            children: [
              TabBar(tabs: [
                Tab(
                  text: " 29,Sept",
                ),
                Tab(
                  text: "Sept 30",
                )
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          // TextField(
                          //   onChanged: (value) => _runFilter(value, 29),
                          //   decoration: InputDecoration(
                          //     labelText: "Select Speaker",
                          //     suffixIcon: Icon(Icons.search),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          isLoading
                              ? Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: favouritesList.length,
                                    itemBuilder: (context, index) => Card(
                                      key: ValueKey(favouritesList[index]),
                                      color: Colors.blueGrey[50],
                                      elevation: 5,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Center(
                                                      child: RichText(
                                                        text: TextSpan(
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .blueGrey),
                                                          text: "Time: " +
                                                              favouritesList[
                                                                      index]
                                                                  .time,
                                                        ),
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
                                                  // Expanded(
                                                  //   child: ElevatedButton(
                                                  //     onPressed: () {
                                                  //       addToFavourites(
                                                  //           _foundAgendas[
                                                  //               index]);
                                                  //       clicked = true;
                                                  //       favoutiteBtn =
                                                  //           "Attended";
                                                  //     },
                                                  //     style: ButtonStyle(
                                                  //         elevation:
                                                  //             MaterialStatePropertyAll(
                                                  //                 3),
                                                  //         backgroundColor:
                                                  //             MaterialStatePropertyAll(
                                                  //                 (clicked
                                                  //                     ? Colors
                                                  //                         .grey
                                                  //                     : Colors
                                                  //                         .blue))),
                                                  //     child: Text(
                                                  //       favoutiteBtn,
                                                  //       textAlign:
                                                  //           TextAlign.center,
                                                  //       style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight
                                                  //                   .normal,
                                                  //           color:
                                                  //               Colors.white),
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyAgendaInfo(
                                                                agendaModel:
                                                                    _foundAgendas[
                                                                        index])));
                                              },
                                              child: Text(
                                                "Topic: ${favouritesList[index].topic} ",
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                                  favouritesList[index].hall,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                future: getSpeakers(29),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: ListTile(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MySpeakerInfo(
                                                                          speakersList:
                                                                              agendaSpeakersList[index])));
                                                        },
                                                        leading: CircleAvatar(
                                                          radius: 25,
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .photo,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          agendaSpeakersList[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .pinkAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .designation,
                                                              // _foundAgendas[index]["place"],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .city,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /*  */
                                ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // const SizedBox(
                          //   height: 30,
                          // ),
                          TextField(
                            onChanged: (value) => _runFilter(value, 30),
                            decoration: InputDecoration(
                              labelText: "Select Speaker",
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          isLoading
                              ? Expanded(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : Expanded(
                                  child: ListView.builder(
                                    itemCount: _foundAgendas.length,
                                    itemBuilder: (context, index) => Card(
                                      key: ValueKey(_foundAgendas[index]),
                                      color: Colors.blueGrey[50],
                                      elevation: 5,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .blueGrey),
                                                        text: _foundAgendas[
                                                                    index]
                                                                .fromTime +
                                                            " - " +
                                                            _foundAgendas[index]
                                                                .toTime,
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
                                                  // Expanded(
                                                  //   child: ElevatedButton(
                                                  //     onPressed: () {
                                                  //       addToFavourites(
                                                  //           _foundAgendas[
                                                  //               index]);
                                                  //       clicked = true;
                                                  //     },
                                                  //     style: ButtonStyle(
                                                  //         elevation:
                                                  //             MaterialStatePropertyAll(
                                                  //                 3),
                                                  //         backgroundColor:
                                                  //             MaterialStatePropertyAll(
                                                  //                 (clicked
                                                  //                     ? Colors
                                                  //                         .blue
                                                  //                     : Colors
                                                  //                         .grey))),
                                                  //     child: const Text(
                                                  //       textAlign:
                                                  //           TextAlign.center,
                                                  //       "Add to Favourites",
                                                  //       style: TextStyle(
                                                  //           fontWeight:
                                                  //               FontWeight
                                                  //                   .normal,
                                                  //           color:
                                                  //               Colors.white),
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              "Topic: ${_foundAgendas[index].topic} ",
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
                                                  _foundAgendas[index].hall,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                future: getSpeakers(30),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: ListTile(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MySpeakerInfo(
                                                                          speakersList:
                                                                              agendaSpeakersList[index])));
                                                          print(_foundAgendas
                                                              .toString());
                                                        },
                                                        leading: CircleAvatar(
                                                          radius: 25,
                                                          child: ClipOval(
                                                            child:
                                                                Image.network(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .photo,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          agendaSpeakersList[
                                                                  index]
                                                              .name,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .pinkAccent,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        subtitle: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .designation,
                                                              // _foundAgendas[index]["place"],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              agendaSpeakersList[
                                                                      index]
                                                                  .city,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueGrey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  /*  */
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
