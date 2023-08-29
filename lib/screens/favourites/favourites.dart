import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_info.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/post_favourite.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/favourites/favourite_model.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
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
  List<SpeakerModel> speakersList = [];
  List<SpeakerModel> agendaSpeakersList = [];
  List<FavouritesModel> favouritesList = [];
  final Color color = Color.fromARGB(255, 15, 158, 174);
  bool clicked = false;

  List<AgendaModel> _foundAgendas = [];
  bool isFavourite = true;
  var userId;
  @override
  void initState() {
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

    if (enteredKeyword.isEmpty) {
      _results = agendaList;
    } else {
      _results = agendaList
          .where((agenda) => agenda.speakerName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    // setState(() {
    //   _foundAgendas = _results;
    // });
  }

  final dio = Dio();
  Future getFavourites() async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    userId = user_id != null ? user_id : "";
    final response = await dio.get(
        'https://globalhealth-forum.com/event_app/api/get_favorite.php?user_id=${userId}');
    var jsonData = response.data;

    if (response.statusCode == 200) {
      for (var items in jsonData) {
        final favourites = FavouritesModel.fromJson(items);
        favouritesList.add(favourites);
        print(favouritesList.toString());
      }
      // setState(() {
      //   isFavourite = true;
      // });
    } else {
      Alerts.showAlert(false, context, "Please try after some time");
    }
  }

  Future<void> unFavourite(String agendId, int index) async {
    final response = await http.post(
      Uri.parse(
          'https://globalhealth-forum.com/event_app/api/delete_favorite.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "agenda_id": agendId,
        "user_id": userId,
      }),
    );
    if (response.statusCode == 200) {
      // Alerts.showAlert(true, context, "Removed Favourites");
      setState(() {
        isFavourite = false;
        favouritesList.removeAt(index);
      });
    } else {
      Alerts.showAlert(false, context, "Please try again after sometime");
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites"),
      ),
      body: Column(
        children: [
          Divider(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder(
                future: getFavourites(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                        itemCount: favouritesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          favouritesList[index].date,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.blueGrey),
                                                  text: favouritesList[index]
                                                          .fromTime +
                                                      " - " +
                                                      favouritesList[index]
                                                          .toTime,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    await unFavourite(
                                                        favouritesList[index]
                                                            .agendaId,
                                                        index);
                                                  },
                                                  icon: Icon(
                                                      size: 30,
                                                      isFavourite
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border_outlined,
                                                      color: Colors.redAccent),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.place,
                                            color: Colors.blueAccent,
                                          ),
                                          Text(
                                            favouritesList[index].hall,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.blueGrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        "Topic: ${favouritesList[index].topic} ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.pinkAccent),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
