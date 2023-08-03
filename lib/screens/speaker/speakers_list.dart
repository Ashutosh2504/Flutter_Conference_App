import 'package:bottom_navigation_and_drawer/types/gridlist.dart';
import 'package:flutter/material.dart';

class MySpeakersList extends StatefulWidget {
  const MySpeakersList({super.key});

  @override
  State<MySpeakersList> createState() => _MySpeakersListState();
}

class _MySpeakersListState extends State<MySpeakersList> {
  final List _speakersList = [
    'speaker1',
    'speaker2 ',
    'speaker3',
    'speaker4',
    'speaker5'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // speakerslist
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _speakersList.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: MySquareGridList(name: _speakersList[index]));
                }),
          ),
        ],
      ),
    );
  }
}
