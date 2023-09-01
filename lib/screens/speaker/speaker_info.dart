import 'dart:convert';
import 'dart:ffi';

import 'package:bottom_navigation_and_drawer/screens/login/login_page.dart';
import 'package:bottom_navigation_and_drawer/util/alerts.dart';
import 'package:bottom_navigation_and_drawer/util/webview.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'speaker_model.dart';
import 'package:http/http.dart' as http;

class MySpeakerInfo extends StatefulWidget {
  MySpeakerInfo({required this.speakersList});
  final SpeakerModel speakersList;

  @override
  State<MySpeakerInfo> createState() => _MySpeakerInfoState();
}

class _MySpeakerInfoState extends State<MySpeakerInfo> {
  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  var prefs;
  var get_mail;
  var user_email;
  var get_logged_in;
  var logged_in;
  bool loggedIn = false;
  final Color color = Color.fromARGB(255, 15, 158, 174);
  bool success = false;
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

//final SpeakerModel speakerInfo;
  final dio = Dio();
  pushNotification(String speakerMail) async {
    var prefs = await SharedPreferences.getInstance();
    var get_mail = prefs.getString("email");
    var user_email = get_mail != null ? get_mail : "";
    var response = await http.get(
      Uri.parse(
          "https://globalhealth-forum.com/event_app/api/email_notification.php?speaker_email=${speakerMail}&user_email=${user_email}"),
    );
    if (response.statusCode == 200) {
      showAlert(true);
    } else {
      showAlert(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
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
                height: MediaQuery.of(context).size.height / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blueGrey,
                        child: ClipOval(
                          child: Image.network(
                            widget.speakersList.photo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pinkAccent),
                                    text: widget.speakersList.name,
                                  ),
                                ),
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.left,
                              softWrap: true,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                text: widget.speakersList.designation,
                              ),
                            ),
                            RichText(
                              textAlign: TextAlign.left,
                              softWrap: true,
                              text: TextSpan(
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                                text: widget.speakersList.institute,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
                          widget.speakersList.rating.isNotEmpty
                              ? widget.speakersList.rating
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
                              await sendRating(rating, widget.speakersList.id);
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
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
                              "Info:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          widget.speakersList.information,
                          textAlign: TextAlign.start,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
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
                              "LinkedIn:",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctxt) => WebviewComponent(
                                    title: "LinkedIn",
                                    webviewUrl:
                                        widget.speakersList.linkedinUrl),
                              ),
                            );
                          },
                          child: Text(
                            widget.speakersList.linkedinUrl,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_city,
                          semanticLabel: "City",
                        ),
                        Text(
                          "Country:",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.speakersList.city,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 3),
                        onPressed: () {
                          pushNotification(widget.speakersList.email);
                        },
                        child: Text(
                          "Request Meeting",
                          style:
                              TextStyle(fontSize: 20, color: Colors.redAccent),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<void> sendRating(double rating, int id) async {
    var prefs = await SharedPreferences.getInstance();
    var user_id = prefs.getString("user_id");
    String userId = user_id != null ? user_id : "";

    final response = await http.post(
      Uri.parse(
          'https://globalhealth-forum.com/event_app/api/post_speaker_rating.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "speaker_id": id.toString(),
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

  //  Future<void> addToFavourites(AgendaModel agenda, int index) async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var user_id = prefs.getString("user_id");
  //   String userId = user_id != null ? user_id : "";
  //   final response = await http.post(
  //     Uri.parse(
  //         'https://globalhealth-forum.com/event_app/api/post_favorite.php'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "agenda_id": agenda.id.toString(),
  //       "user_id": userId
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     _foundAgendas[index].isFavourite = "Already Added";
  //     //await widget.getAgendas();
  //   } else {
  //     // If the server did not return a 201 CREATED response,
  //     // then throw an exception.

  //     showAlert();
  //   }
}
