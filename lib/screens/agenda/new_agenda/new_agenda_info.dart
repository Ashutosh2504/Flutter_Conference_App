import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NewAgendaInfo extends StatefulWidget {
  // const NewAgendaInfo({super.key});
  final NewAgendaModel agendaModel;
  NewAgendaInfo({required this.agendaModel, required this.speakerList});
  final List<SpeakerModel> speakerList;
  @override
  State<NewAgendaInfo> createState() => _NewAgendaInfoState();
}

class _NewAgendaInfoState extends State<NewAgendaInfo> {
  bool loggedIn = false;
  var prefs;
  var get_mail;
  var user_email;
  var get_logged_in;
  var logged_in;

  @override
  void initState() {
    getPreferences();
    // TODO: implement initState
    super.initState();
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
                          textAlign: TextAlign.left,
                          softWrap: true,
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.pinkAccent),
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
                                  textAlign: TextAlign.left,
                                  "Info:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              widget.agendaModel.agenda_info,
                              textAlign: TextAlign.left,
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
                        widget.agendaModel.agenda_rating.isNotEmpty
                            ? widget.agendaModel.agenda_rating
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
              //getSpeakerDetails( widget.agendaModel.speakers)
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
          style:
              TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.bold),
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
