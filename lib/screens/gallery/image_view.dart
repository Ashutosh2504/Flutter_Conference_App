import 'package:bottom_navigation_and_drawer/screens/gallery/gallery_model.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          widget.imageModel.link,
        ),
      ),
    );
  }
}
