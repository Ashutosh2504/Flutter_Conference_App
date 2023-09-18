import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewAgendaInfo extends StatefulWidget {
  // const NewAgendaInfo({super.key});
  final NewAgendaModel agendaModel;
  NewAgendaInfo({required this.agendaModel});
  // final List<SpeakerModel> speakerList;
  @override
  State<NewAgendaInfo> createState() => _NewAgendaInfoState();
}

class _NewAgendaInfoState extends State<NewAgendaInfo> {
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);
  NewAgendaModel lateAgendaModel = NewAgendaModel(
      Topic: "",
      agenda_id: "",
      hall: "",
      agenda_info: "",
      agenda_rating: "",
      from_time: "",
      to_time: "",
      speakers: []);
  final dio = new Dio();
  var userId;
  bool loading = true;

  bool loggedIn = false;
  var prefs;
  var get_mail;
  var user_email;
  var get_logged_in;
  var logged_in;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPreferences().then((val) {
        if (loggedIn) {
          getAgendaRating(widget.agendaModel.agenda_id);
        }

        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      body: Container(
        width: queryData.size.width,
        height: queryData.size.height,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 229, 226, 226),
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                //height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          softWrap: true,
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: titleColor),
                            text: widget.agendaModel.Topic,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.agendaModel.from_time +
                                  " - " +
                                  widget.agendaModel.to_time,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.agendaModel.hall,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  semanticLabel: "Info",
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  textAlign: TextAlign.justify,
                                  "Info:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              widget.agendaModel.agenda_info,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              //overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                //height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: RatingBar.builder(
                    itemSize: 25,
                    initialRating: double.parse(
                        loggedIn && lateAgendaModel.agenda_rating.isNotEmpty
                            ? lateAgendaModel.agenda_rating
                            : "0.0"),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: loggedIn
                        ? (rating) async {
                            await sendRating(
                                rating, widget.agendaModel.agenda_id);
                            print("Rating for speaker ${rating}");
                          }
                        : (rating) async {
                            await Alerts.showAlert(loggedIn, context,
                                "Not Logged In. Please Login");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                  )),
                ),
              ),
              ...widget.agendaModel.speakers
                  .map((e) => getSpeakerDetails(e))
                  .toList()
              //getSpeakerDetails( lateAgendaModel.speakers)
            ],
          ),
        ),
      ),
    );
  }

  Widget getSpeakerDetails(SpeakerModel element) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MySpeakerInfo(speakersList: element)));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: 25,
          child: ClipOval(
            child: Image.network(
              element.photo,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          element.name,
          style: TextStyle(color: titleColor, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element.designation,
              // _foundAgendas[index]["place"],
              style: TextStyle(color: Colors.blueGrey),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              element.city,
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendRating(double rating, String id) async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    String userId = user_id != null ? user_id : "";

    final response = await http.post(
      Uri.parse('https://globalhealth-forum.com/event_app/api/post_rating.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "agenda_id": id,
        "user_id": userId,
        "rating": rating.toString()
      }),
    );
    if (response.statusCode == 200) {
      Alerts.showAlert(true, context, "Ratings added");
    } else {
      Alerts.showAlert(false, context, "Please rate again after sometime");
    }
    setState(() {});
  }

  getAgendaRating(String agendaId) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getString("user_id");
      userId = user_id != null ? user_id : "";
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_agenda_rating.php?agenda_id=${agendaId}&user_id=${userId}');

      if (response.statusCode == 200) {
        var jsonData = response.data;
        // List<dynamic> speak = jsonData[0]['speakers'];
        lateAgendaModel = NewAgendaModel(
            Topic: jsonData[0]['Topic'],
            agenda_id: jsonData[0]['agenda_id'],
            hall: jsonData[0]['hall'],
            agenda_info: jsonData[0]['agenda_info'],
            agenda_rating: jsonData[0]['agenda_rating'],
            from_time: jsonData[0]['from_time'],
            to_time: jsonData[0]['to_time'],
            speakers: List<SpeakerModel>.from(
                jsonData[0]['speakers'].map((x) => SpeakerModel.fromJson(x))));

        loading = false;
        setState(() {});
      } else {
        throw Error.safeToString("Invalid status call");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<dynamic> getPreferences() async {
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
