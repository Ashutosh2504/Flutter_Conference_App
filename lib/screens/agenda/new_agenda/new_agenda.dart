import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/ageda_body_content.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_body_content.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/favourites/favourite_model.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyNewAgenda extends StatefulWidget {
  const MyNewAgenda({super.key});

  @override
  State<MyNewAgenda> createState() => _MyNewAgendaState();
}

class _MyNewAgendaState extends State<MyNewAgenda> {
  List<FavouritesModel> favouritesList = [];
  Dio dio = Dio();
  List<List<NewAgendaModel>> dateWiseAgendaList = [];
  List<NewAgendaModel> agendaList29th = [];
  List<NewAgendaModel> agendaList30th = [];

  final Color color = Color.fromARGB(255, 15, 158, 174);
  bool clicked = false;
  String favoutiteBtn = "Add to Favourites";
  List<NewAgendaModel> _foundAgendas = [];
  bool isLoading = true;
  var userId;
  @override
  void initState() {
    super.initState();
    getAgendas();
    getFavourites();
  }

  Future<dynamic> getAgendas() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.get(
          Uri.parse('https://globalhealth-forum.com/event_app/api/agenda.php'));

      Map<String, List<NewAgendaModel>> agendaList29thMap =
          agendaModelFromJson(jsonDecode(response.body)["29/09/2023"]);
      Map<String, List<NewAgendaModel>> agendaList30thMap =
          agendaModelFromJson(jsonDecode(response.body)["30/09/2023"]);

      setState(() {
        agendaList29th = agendaList29thMap["agenda"]!;
        agendaList30th = agendaList30thMap["agenda"]!;

        isLoading = false;
      });

      return [
        dateWiseAgendaList.elementAt(0),
        dateWiseAgendaList.elementAt(1),
      ];
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Agenda",
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        text: "29th Sept",
                      ),
                      Tab(
                        text: "30th Sept",
                      )
                    ]),
                    Expanded(
                      child: TabBarView(
                        children: [
                          NewAgendaBodyContent(
                            agendaListFromParentComponent:
                                checkFavouriteFromList(agendaList29th),
                          ),
                          NewAgendaBodyContent(
                            agendaListFromParentComponent:
                                checkFavouriteFromList(agendaList30th),
                          )
                        ],
                      ),
                    )
                  ],
                )),
    );
  }

  List<NewAgendaModel> checkFavouriteFromList(List<NewAgendaModel> aList) {
    List<NewAgendaModel> newAgendaList = [];
    if (favouritesList.isNotEmpty) {
      for (NewAgendaModel agenda in aList) {
        for (FavouritesModel favouriteAgenda in favouritesList) {
          if (agenda.agenda_id == favouriteAgenda.agendaId) {
            agenda.isFavourite = "Already added";
            newAgendaList.add(agenda);
          } else {
            agenda.isFavourite = "Add to Favourites";
            newAgendaList.add(agenda);
          }
        }
      }
      return newAgendaList;
    } else {
      return aList;
    }
  }

  Future getFavourites() async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    userId = user_id != null ? user_id : "";
    final response = await dio.get(
        'https://globalhealth-forum.com/event_app/api/get_favorite.php?user_id=${userId}');
    var jsonData = response.data;

    try {
      if (response.statusCode == 200 && response.data != null) {
        for (var items in jsonData) {
          final favourites = FavouritesModel.fromJson(items);
          favouritesList.add(favourites);
          // print(favouritesList.toString());
          setState(() {});
        }
        // setState(() {
        //   isFavourite = true;
        // });
      } else {
        Alerts.showAlert(false, context, "Please try after some time");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
