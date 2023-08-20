// import 'dart:convert';

// import 'package:bottom_navigation_and_drawer/screens/favourites/favourite_model.dart';
// import 'package:bottom_navigation_and_drawer/screens/speaker/speaker_info.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import '../speaker/speaker_model.dart';

// class MyFavourites extends StatefulWidget {
//   const MyFavourites({super.key});

//   @override
//   State<MyFavourites> createState() => _MyFavouritesState();
// }

// class _MyFavouritesState extends State<MyFavourites> {
//   final dio = Dio();
//   List<FavouriteModel> favouriteList = [];
//   List<SpeakerModel> speakersList_temp = [];
//   List<SpeakerModel> speakersList = [];

//   List<FavouriteModel> _foundAgendas = [];

//   Future getFavourites({required int user_id}) async {
//     final response = await dio.get(
//         'https://globalhealth-forum.com/event_app/api/get_favorite.php?user_id=$user_id');
//     var jsonData = jsonDecode(response.data);
//     for (var items in jsonData) {
//       final favourites = FavouriteModel(
//           id: items['id'],
//           user_id: items['user_id'],
//           speaker_name: items['speaker_name'],
//           agenda_id: items['agenda_id'],
//           hall: items['hall'],
//           topic: items['topic'],
//           date: items['date'],
//           time: items['time'],
//           status: items['status']);

//       favouriteList.add(favourites);
//     }
//   }

//   Future getSpeakers() async {
//     final response = await dio
//         .get('https://globalhealth-forum.com/event_app/api/get_speaker.php');
//     var jsonData = jsonDecode(response.data);

//     for (var items in jsonData) {
//       final speakers = SpeakerModel(
//           id: items['id'],
//           name: items['name'],
//           email: items['email'],
//           mobile: items['mobile'],
//           designation: items['designation'],
//           institute: items['institute'],
//           information: items['information'],
//           city: items['city'],
//           country: items['country'],
//           date: items['date'],
//           photo: items['photo'],
//           status: items['status']);

//       // speakersList_temp.add(speakers);
//       for (var i = 0; i < favouriteList.length; i++) {
//         if (favouriteList[i].agenda_id == speakers.id.toString()) {
//           speakersList.add(speakers);
//         }
//       }
//     }

//     // for (var i = 0; i < favouriteList.length; i++) {
//     //   for (var j = 0; j < speakersList_temp.length; j++) {
//     //     if (favouriteList[i].speaker_id == speakersList_temp[j]) {
//     //       speakersList.add(speakersList_temp[j]);
//     //     }
//     //   }
//     // }
//   }

//   void _runFilter(String enteredKeyword) {
//     // List<Map<String, dynamic>> _results = [];
//     List<FavouriteModel> _results = [];

//     if (enteredKeyword.isEmpty) {
//       _results = favouriteList;
//     } else {
//       _results = favouriteList
//           .where((favourite) => favourite.speaker_name
//               .toLowerCase()
//               .contains(enteredKeyword.toLowerCase()))
//           .toList();
//     }

//     setState(() {
//       _foundAgendas = _results;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     //getFavourites(user_id: 1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Favourites",
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // const SizedBox(
//             //   height: 30,
//             // ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: InputDecoration(
//                 labelText: "Select Hall",
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//             // const SizedBox(
//             //   height: 20,
//             // ),
//             Expanded(
//               child: FutureBuilder(
//                 future: getFavourites(user_id: 1),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return ListView.builder(
//                       itemCount: favouriteList.length,
//                       itemBuilder: (context, index) => Card(
//                         key: ValueKey(favouriteList[index]),
//                         color: Colors.blueGrey[50],
//                         elevation: 5,
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     RichText(
//                                       text: TextSpan(
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.blueGrey),
//                                         text: favouriteList[index].time,
//                                       ),
//                                     ),
//                                     RichText(
//                                       text: TextSpan(
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.blueGrey),
//                                         text:
//                                             "Places:${favouriteList[index].time}",
//                                       ),
//                                     ),
//                                     ElevatedButton(
//                                       onPressed: () {},
//                                       style: ButtonStyle(
//                                           backgroundColor:
//                                               MaterialStatePropertyAll(
//                                                   Colors.lightBlue)),
//                                       child: const Text(
//                                         "Attended",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             color: Colors.white),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 "Topic: ${favouriteList[index].topic} ",
//                                 style: TextStyle(
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.pinkAccent),
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.place,
//                                     color: Colors.blueAccent,
//                                   ),
//                                   Text(
//                                     favouriteList[index].hall,
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.blueGrey),
//                                   ),
//                                 ],
//                               ),
//                               Text(
//                                 "Speakers",
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.normal,
//                                     color: Colors.blueGrey),
//                               ),
//                               FutureBuilder(
//                                   future: getSpeakers(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState ==
//                                         ConnectionState.done) {
//                                       return Container(
//                                         decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: ListTile(
//                                           onTap: () {
//                                             print(_foundAgendas.toString());
//                                           },
//                                           leading: CircleAvatar(
//                                             radius: 25,
//                                             child: ClipOval(
//                                               child: Image.network(
//                                                 speakersList[index].photo,
//                                                 fit: BoxFit.fill,
//                                               ),
//                                             ),
//                                           ),
//                                           title: Text(
//                                             speakersList[index].name,
//                                             style: TextStyle(
//                                                 color: Colors.pinkAccent,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                           subtitle: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 speakersList[index].designation,
//                                                 // _foundAgendas[index]["place"],
//                                                 style: TextStyle(
//                                                     color: Colors.blueGrey),
//                                               ),
//                                               SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Text(
//                                                 speakersList[index].city,
//                                                 style: TextStyle(
//                                                     color: Colors.blueGrey),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       );
//                                     } else {
//                                       return Center(
//                                         child: CircularProgressIndicator(),
//                                       );
//                                     }
//                                   }),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 },
//               ),

//               /*  */
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
