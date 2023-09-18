import 'dart:io';

import 'package:bottom_navigation_and_drawer/screens/gallery/gallery_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryDownloadingDialog extends StatefulWidget {
  const GalleryDownloadingDialog({super.key, required this.download});
  final GalleryModel download;

  @override
  State<GalleryDownloadingDialog> createState() =>
      _GalleryDownloadingDialogState();
}

class _GalleryDownloadingDialogState extends State<GalleryDownloadingDialog> {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  Dio dio = Dio();
  double progress = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
    startDownloading();
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  void startDownloading() async {
    String? path;
    String fileName = widget.download.id.toString(); //todo
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
      try {
        await await dio.download(
          widget.download.link,
          _localPath + "/" + fileName + ".jpg",
          onReceiveProgress: (recivedBytes, totalBytes) {
            setState(() {
              progress = recivedBytes / totalBytes;
            });

            print(progress);
            print(path);
          },
          deleteOnError: true,
        ).then((_) {
          Navigator.pop(context);
        });
        print("Download Completed.");
      } catch (e) {}
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/GlobalHealthForum/Gallery";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }
}
