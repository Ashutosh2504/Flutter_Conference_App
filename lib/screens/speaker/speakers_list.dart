import 'dart:convert';

import 'package:bottom_navigation_and_drawer/types/gridlist.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'speaker_model.dart';

class MySpeakersList extends StatefulWidget {
  const MySpeakersList({super.key});

  @override
  State<MySpeakersList> createState() => _MySpeakersListState();
}

class _MySpeakersListState extends State<MySpeakersList> {
  // final List _speakersList = [
  //   'speaker1',
  //   'speaker2 ',
  //   'speaker3',
  //   'speaker4',
  //   'speaker5'
  // ];
  List<SpeakerModel> _speakersList = [];
  final dio = Dio();

  Future getSpeakers() async {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
    var jsonData = jsonDecode(response.data);
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

      _speakersList.add(speakers);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // speakerslist
          Expanded(
            child: FutureBuilder(
              future: getSpeakers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        //childAspectRatio: 1.2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10),
                    itemCount: _speakersList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: MySquareGridList(
                            index: index, speakerModel: _speakersList),
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
