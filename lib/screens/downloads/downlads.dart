import 'dart:convert';
import 'dart:io';

// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bottom_navigation_and_drawer/screens/downloads/download_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import '../drawers/sidemenu.dart';
import 'download_dialog.dart';

class MyDownloads extends StatefulWidget {
  const MyDownloads({super.key});

  @override
  State<MyDownloads> createState() => _MyDownloadsState();
}

class _MyDownloadsState extends State<MyDownloads> {
  final dio = Dio();
  List<DownloadModel> downloadList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getDownloads() async {
    final response = await dio
        .get('https://globalhealth-forum.com/event_app/api/get_download.php');
    var jsonData = (response.data);
    for (var items in jsonData) {
      final download = DownloadModel(
        id: items['id'],
        url: items['url'],
        filename: items['filename'],
        description: items['discription'],
      );
      downloadList.add(download);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Downloads "),
        ),
        body: FutureBuilder(
          future: getDownloads(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: downloadList.length,
                  itemBuilder: (context, index) => Card(
                        key: ValueKey(downloadList[index]),
                        color: Colors.blueGrey[50],
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Column(
                            children: [
                              Text(downloadList[index].filename),
                              Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                          downloadList[index].description)),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DownloadingDialog(
                                            download: downloadList[index]),
                                      );
                                    },
                                    child: Text("Download File."),
                                  ),
                                ],
                              )
                            ],
                          )),
                        ),
                      ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
