import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/ageda_body_content.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_info.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/post_favourite.dart';
import 'package:bottom_navigation_and_drawer/screens/drawers/sidemenu.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:quickalert/utils/images.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../speaker/speaker_info.dart';

class MyAgenda extends StatefulWidget {
  const MyAgenda({super.key});

  @override
  State<MyAgenda> createState() => _MyAgendaState();
}

class _MyAgendaState extends State<MyAgenda> {
  List<List<AgendaModel>> dateWiseAgendaList = [];
  List<AgendaModel> agendaList29th = [];
  List<AgendaModel> agendaList30th = [];
  List<SpeakerModel> agendaSpeakersList29th = [];
  List<SpeakerModel> agendaSpeakersList30th = [];
  List<SpeakerModel> speakersList = [];
  List<SpeakerModel> agendaSpeakersList = [];
  final Color color = Color.fromARGB(255, 15, 158, 174);
  bool clicked = false;
  String favoutiteBtn = "Add to Favourites";
  List<AgendaModel> _foundAgendas = [];
  bool isLoading = false;
  var userId;
  @override
  void initState() {
    initFunction();

    super.initState();
  }

  Future<void> initFunction() async {
    try {
      setState(() {
        isLoading = true;
      });
      List result = await getAgendas();
      List tempList = [];

      List<SpeakerModel> speakers = await getSpeakers();

      for (var items in result) {
        tempList.add(getSpeakersInAgenda(items, speakers));
      }
      setState(() {
        agendaSpeakersList29th = tempList.elementAt(0);
        agendaSpeakersList30th = tempList.elementAt(1);
      });
    } catch (e) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // void getPreferences() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var user_id = prefs.getString("user_id");
  //   userId = user_id != null ? user_id : "";
  // }

  final dio = Dio();

  Future<dynamic> getAgendas() async {
    try {
      final response = await http.get(Uri.parse(
          'https://globalhealth-forum.com/event_app/api/get_datewise_agenda.php'));

      Map<String, List<AgendaModel>> agendaListMap =
          agendaModelFromJson(response.body);
      print(agendaListMap);
      agendaListMap.values.forEach((value) {
        dateWiseAgendaList.add(value);
      });

      setState(() {
        agendaList29th = dateWiseAgendaList.elementAt(0);
        agendaList30th = dateWiseAgendaList.elementAt(1);
        isLoading = false;
      });

      return [
        dateWiseAgendaList.elementAt(0),
        dateWiseAgendaList.elementAt(1),
      ];
    } catch (e) {}
  }

  Future getSpeakers() async {
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
          linkedinUrl: items['linkedin_url'],
          date: items['date'],
          photo: items['photo'],
          rating: items['rating'],
          status: items['status']);

      setState(() {
        speakersList.add(speakers);
      });
    }
    return speakersList;
  }

  List<SpeakerModel> getSpeakersInAgenda(
      List<AgendaModel> agendaList, List<SpeakerModel> speakers) {
    List<SpeakerModel> speakerTo = [];
    for (var i = 0; i < agendaList.length; i++) {
      for (var j = 0; j < speakers.length; j++) {
        if (int.parse(agendaList[i].speakerId) == speakers[j].id) {
          speakerTo.add(speakers[j]);
        }
      }
    }
    return speakerTo;
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
              "Agenda",
            ),
          ),
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                          AgendaBodyContent(
                              agendaListFromParentComponent: agendaList29th,
                              speakersOnSelectedDate: agendaSpeakersList29th,
                              getAgendas: getAgendas),
                          AgendaBodyContent(
                              agendaListFromParentComponent: agendaList30th,
                              speakersOnSelectedDate: agendaSpeakersList30th,
                              getAgendas: getAgendas)
                        ],
                      ),
                    )
                  ],
                )),
    );
  }
}
