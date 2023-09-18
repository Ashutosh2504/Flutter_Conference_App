import 'package:bottom_navigation_and_drawer/screens/gallery/gallery_model.dart';
import 'package:flutter/material.dart';

import 'image_downloader.dart';

class MyImageViewer extends StatefulWidget {
  const MyImageViewer({super.key, required this.imageModel});
  final GalleryModel imageModel;
  @override
  State<MyImageViewer> createState() => _MyImageViewerState();
}

class _MyImageViewerState extends State<MyImageViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              //height: MediaQuery.of(context).size.height / 2,
              child: Image.network(
                widget.imageModel.link,
              ),
            ),
          ),
          ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      GalleryDownloadingDialog(download: widget.imageModel),
                );
              },
              icon: Icon(Icons.download_rounded),
              label: Text("Download")),
        ],
      ),
    );
  }
}
