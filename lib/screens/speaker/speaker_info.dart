import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'speaker_model.dart';

class MySpeakerInfo extends StatelessWidget {
  MySpeakerInfo({required this.index, required this.speakersList});
//final SpeakerModel speakerInfo;
  final dio = Dio();
  final int index;
  final List<SpeakerModel> speakersList;

  // Future getSpeakers() async {
  //   final response = await dio
  //       .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
  //   var jsonData = jsonDecode(response.data);
  //   for (var items in jsonData) {
  //     final speakers = SpeakerModel(
  //         id: items['id'],
  //         name: items['name'],
  //         email: items['email'],
  //         mobile: items['mobile'],
  //         designation: items['designation'],
  //         institute: items['institute'],
  //         information: items['information'],
  //         city: items['city'],
  //         country: items['country'],
  //         date: items['date'],
  //         photo: items['photo'],
  //         status: items['status']);

  //     speakersList.add(speakers);
  //   }
  // }

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
                        child: ClipOval(
                          child: Image.network(
                            speakersList[index].photo,
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
                              child: RichText(
                                textAlign: TextAlign.left,
                                softWrap: true,
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pinkAccent),
                                  text: speakersList[index].name,
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
                                text: speakersList[index].designation,
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
                                text: speakersList[index].institute,
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
                              "Info",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          speakersList[index].information,
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
                        Text(
                          "City",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          //overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_city,
                              semanticLabel: "City",
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              speakersList[index].city,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
