import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/speaker/check_speaker_rating_model.dart';
import 'package:bottom_navigation_and_drawer/types/gridlist.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'speaker_info.dart';
import 'speaker_model.dart';

class MySpeakersList extends StatefulWidget {
  const MySpeakersList({super.key});

  @override
  State<MySpeakersList> createState() => _MySpeakersListState();
}

class _MySpeakersListState extends State<MySpeakersList> {
  List<SpeakerModel> _speakersList = [];
  final dio = Dio();

  var userId;
  bool listViewEnabled = false;
  Future getSpeakers() async {
    try {
      final response = await dio
          .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
      var jsonData = response.data;
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

        _speakersList.add(speakers);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<CheckSpeakerRatingModel> getSpeakerRating(int speakerId) async {
    try {
      CheckSpeakerRatingModel checkSpeakerModelRating;
      var prefs = await SharedPreferences.getInstance();
      var user_id = prefs.getString("user_id");
      userId = user_id != null ? user_id : "";
      final response = await dio.get(
          'https://globalhealth-forum.com/event_app/api/get_speaker_rating.php?speaker_id=${speakerId}&user_id=${userId}');

      if (response.statusCode == 200) {
        var jsonData = response.data;

        checkSpeakerModelRating = CheckSpeakerRatingModel(
            id: jsonData[0]['id'],
            userId: jsonData[0]['user_id'],
            rating: jsonData[0]['rating'],
            speakerId: jsonData[0]['speaker_id'],
            name: jsonData[0]['name'],
            email: jsonData[0]['email'],
            mobile: jsonData[0]['mobile'],
            designation: jsonData[0]['designation'],
            institute: jsonData[0]['institute'],
            information: jsonData[0]['information'],
            city: jsonData[0]['city'],
            country: jsonData[0]['country'],
            linkedinUrl: jsonData[0]['linkedin_url'],
            date: jsonData[0]['date'],
            photo: jsonData[0]['photo'],
            status: jsonData[0]['status']);

        return checkSpeakerModelRating;
      } else {
        throw Error.safeToString("Invalid status call");
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speakers"),
        actions: [
          listViewEnabled
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      listViewEnabled = false;
                    });
                  },
                  icon: Icon(Icons.grid_on))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      listViewEnabled = true;
                    });
                  },
                  icon: Icon(Icons.list))
        ],
      ),
      body: Column(
        children: [
          Divider(
            height: 5,
          ),
          // speakerslist
          Expanded(
            child: FutureBuilder(
              future: getSpeakers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return listViewEnabled
                      ? ListView.builder(
                          itemCount: _speakersList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                CheckSpeakerRatingModel speaker =
                                    await getSpeakerRating(
                                        _speakersList[index].id);
                                _speakersList[index].rating = speaker.rating;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MySpeakerInfo(
                                            speakersList:
                                                _speakersList[index])));
                                await getSpeakers();
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              // decoration: BoxDecoration(
                                              //     color: Colors.blueGrey),
                                              child: _speakersList[index]
                                                      .photo
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      height: 80,
                                                      _speakersList[index]
                                                          .photo,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/user.png")),
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 0),
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.pinkAccent),
                                                  text:
                                                      _speakersList[index].name,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              RichText(
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                  text: _speakersList[index]
                                                      .designation,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              RichText(
                                                textAlign: TextAlign.left,
                                                softWrap: true,
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black),
                                                  text: _speakersList[index]
                                                      .institute,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  //childAspectRatio: 1.2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 10),
                          itemCount: _speakersList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: MySquareGridList(
                                  speakerModel: _speakersList[index]),
                            );
                          },
                        );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),

            // child: GridView.builder(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemCount: _speakersList.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //           child: MySquareGridList(name: _speakersList[index].name));
            //     }),
          ),
        ],
      ),
    );
  }
}
