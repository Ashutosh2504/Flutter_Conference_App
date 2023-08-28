import 'dart:io';

import 'package:bottom_navigation_and_drawer/screens/downloads/download_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key, required this.download}) : super(key: key);
  final DownloadModel download;
  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    String? path;
    String fileName = widget.download.filename; //todo
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
      try {
        await await dio.download(
          widget.download.url,
          _localPath + "/" + fileName,
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

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
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

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/sdcard/download/GlobalHealthForum/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }

  @override
  void initState() {
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
}
