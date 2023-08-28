import 'package:bottom_navigation_and_drawer/screens/agenda/agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/agenda/new_agenda/new_agenda_model.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewAgendaInfo extends StatefulWidget {
  // const NewAgendaInfo({super.key});
  final NewAgendaModel agendaModel;
  NewAgendaInfo({required this.agendaModel, required this.speakerList});
  final List<SpeakerModel> speakerList;
  @override
  State<NewAgendaInfo> createState() => _NewAgendaInfoState();
}

class _NewAgendaInfoState extends State<NewAgendaInfo> {
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
                //height: MediaQuery.of(context).size.height / 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
                      Text(widget.agendaModel.hall),
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
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print("Rating for agenda ${rating}");
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
}
