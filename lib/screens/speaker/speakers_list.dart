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
  final Color titleColor = Color.fromARGB(255, 1, 144, 159);

  List<SpeakerModel> _speakersList = [];
  List<SpeakerModel> _foundSpeakers = [];
  final dio = Dio();

  bool listViewEnabled = false;

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpeakers();
      setState(() {
        _foundSpeakers = _speakersList;
      });
    });
  }

  void _runFilter(String enteredKeyword) {
    List<SpeakerModel> _results = [];

    if (enteredKeyword.isEmpty) {
      _results = _speakersList;
    } else {
      _results = _speakersList
          .where((participant) => participant.name
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundSpeakers = _results;
      //_foundSpeakers.sort();
    });
  }

  Future getSpeakers() async {
    try {
      final response = await dio
          .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
      if (response.statusCode == 200) {
        var jsonData = response.data;
        isLoading = false;
        setState(() {});
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
      } else {
        isLoading = true;
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
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
          TextField(
            onChanged: (value) => _runFilter(value.trim()),
            decoration: InputDecoration(
              labelText: "Search Speakers",
              suffixIcon: Icon(Icons.search),
            ),
          ),
          // speakerslist
          isLoading
              ? CircularProgressIndicator()
              : Expanded(
                  child: listViewEnabled
                      ? ListView.builder(
                          itemCount: _foundSpeakers.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                // CheckSpeakerRatingModel speaker =
                                //     await getSpeakerRating(
                                //         _foundSpeakers[index].id);
                                // _foundSpeakers[index].rating = speaker.rating;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MySpeakerInfo(
                                            speakersList:
                                                _foundSpeakers[index])));
                                await getSpeakers();
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                              child: _foundSpeakers[index]
                                                      .photo
                                                      .isNotEmpty
                                                  ? Image.network(
                                                      height: 80,
                                                      _foundSpeakers[index]
                                                          .photo,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return Icon(
                                                          Icons.person,
                                                          size: 80,
                                                        );
                                                      },
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
                                                      color: titleColor),
                                                  text: _foundSpeakers[index]
                                                      .name,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              // RichText(
                                              //   textAlign: TextAlign.left,
                                              //   softWrap: true,
                                              //   text: TextSpan(
                                              //     style: TextStyle(
                                              //         fontSize: 14,
                                              //         fontWeight:
                                              //             FontWeight.normal,
                                              //         color: Colors.black87),
                                              //     text: _foundSpeakers[index]
                                              //         .designation,
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   height: 4,
                                              // ),
                                              // RichText(
                                              //   textAlign: TextAlign.left,
                                              //   softWrap: true,
                                              //   text: TextSpan(
                                              //     style: TextStyle(
                                              //         fontSize: 18,
                                              //         fontWeight:
                                              //             FontWeight.normal,
                                              //         color: Colors.black),
                                              //     text: _foundSpeakers[index]
                                              //         .institute,
                                              //   ),
                                              //),
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
                                  mainAxisSpacing: 5),
                          itemCount: _foundSpeakers.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              child: MySquareGridList(
                                  speakerModel: _foundSpeakers[index]),
                            );
                          },
                        )

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
