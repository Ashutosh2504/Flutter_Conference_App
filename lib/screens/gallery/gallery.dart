import 'dart:convert';

import 'package:bottom_navigation_and_drawer/screens/gallery/gallery_model.dart';
import 'package:bottom_navigation_and_drawer/screens/gallery/image_view.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyGallery extends StatefulWidget {
  MyGallery({super.key});

  @override
  State<MyGallery> createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  List<GalleryModel> galleryList = [];

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Gallery"),
        ),
        body: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            Expanded(
              child: FutureBuilder(
                future: getGallery(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      itemCount: galleryList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                          // childAspectRatio: MediaQuery.of(context).size.width /
                          //     (MediaQuery.of(context).size.height / 2),
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          crossAxisCount: 2),
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MyImageViewer(
                                    imageModel: galleryList[index],
                                    // imageModel: galleryList[index],
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(2.0),
                            child: Image.network(
                              galleryList[index].link,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 6,
                              fit: BoxFit.fill,
                            ),
                          ),
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
            ),
          ],
        ),
      ),
    );
  }

  final dio = Dio();

  Future getGallery() async {
    try {
      final response = await dio
          .get('https://globalhealth-forum.com/event_app/api/get_gallery.php');

      var jsonData = (response.data);
      for (var image in jsonData) {
        final gallery = GalleryModel(
            id: image['id'],
            link: image['link'],
            status: image['status'],
            date: image['date']);

        galleryList.add(gallery);
      }
      print(galleryList.length);
    } catch (e) {
      print(e.toString());
    }
  }
}
