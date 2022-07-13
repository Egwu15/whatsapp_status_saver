import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/src/config/config.dart';

class FileHandler {
  List<File> _sortAndSepeateFiles(Directory dir) {
    List<File> files = [];
    try {
      files = dir
          .listSync()
          .map((item) => item.path)
          .where(
              (element) => element.endsWith('.jpg') || element.endsWith('.mp4'))
          .map((item) => File(item))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return files;
  }

  List<File> getMediaFiles() {
    List<File> mediaFiles = [];

    try {
      Directory whatsappDir = Directory(Config.whatsAppPath);
      Directory whatsappDirAndroid11 =
          Directory(Config.whatsappBusinessPathAndroid11);
      Directory gbWhatsAppDir = Directory(Config.gbWhatsAppPath);
      Directory whatsappBusinessDir = Directory(Config.whatsappBusinessPath);

      if (whatsappDirAndroid11.existsSync()) {
        mediaFiles.addAll(_sortAndSepeateFiles(whatsappDirAndroid11));
      }
      if (whatsappDir.existsSync()) {
        mediaFiles.addAll(_sortAndSepeateFiles(whatsappDir));
      }
      if (gbWhatsAppDir.existsSync()) {
        mediaFiles.addAll(_sortAndSepeateFiles(gbWhatsAppDir));
      }
      if (whatsappBusinessDir.existsSync()) {
        mediaFiles.addAll(_sortAndSepeateFiles(whatsappBusinessDir));
      }
      mediaFiles
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return mediaFiles;
  }

  Future<Uint8List?> fetchVideoThumbnail(String path) async {
    return await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
    );
  }

  List<File> getSavedImages() {
    List<File> images = [];

    try {
      Directory dir = Directory(Config.saveDir);
      images = dir
          .listSync()
          .map((item) => item.path)
          .where((element) => element.endsWith('.jpg'))
          .map((item) => File(item))
          .toList();
      images
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return images;
  }

  List<File> getSavedVideos() {
    List<File> videos = [];

    try {
      Directory dir = Directory(Config.saveDir);
      videos = dir
          .listSync()
          .map((item) => item.path)
          .where((element) => element.endsWith('mp4'))
          .map((item) => File(item))
          .toList();
      videos
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return videos;
  }

  downlaodMedia(File file) {
    Directory dir = Directory(Config.saveDir);

    if (!dir.existsSync()) {
      dir.createSync();
    }

    File newFile = file.copySync("${dir.path}/${basename(file.path)}");
    if (newFile.existsSync()) {
      Get.snackbar("", "",
          titleText: Center(
              child: Text(
            "Status saved scusessfully",
            style: Theme.of(Get.context!).textTheme.headline3,
          )),
          messageText: Container(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green[900]?.withOpacity(0.8));
    }
  }

  shareFile(File file) {
    Share.shareFiles([file.path]);
  }
}
