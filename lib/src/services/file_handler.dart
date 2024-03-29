import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:media_scanner/media_scanner.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:saf/saf.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/src/config/config.dart';
import 'package:whatsapp_status_saver/src/services/get_permission.dart';

class FileHandler {
  List<File> _sortAndSeparateFiles(Directory dir) {
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

  resetAndroid11Cache() async{
      Saf? android11 = await DevicePermission().getAndroid11Permission();
      await android11?.clearCache();
  }

  _getAndroid11Files() async {
    Saf? android11 = await DevicePermission().getAndroid11Permission();
    List<File> android11Files = [];
    await android11?.sync();

    List<String>? android11FilesPath = await android11?.getCachedFilesPath();
    if (android11FilesPath != null) {
      for (String element in android11FilesPath) {
        if (element.endsWith("mp4") || element.endsWith("jpg")) {
          android11Files.add(File(element));
        }
      }
    }
    return android11Files;
  }

  Future<List<File>> getMediaFiles() async {
    List<File> mediaFiles = [];

    try {
      Directory whatsappDir = Directory(Config.whatsAppPath);
      Directory whatsappAndroid11FullPath =
          Directory(Config.whatsappAndroid11FullPath);
      Directory gbWhatsAppDir = Directory(Config.gbWhatsAppPath);
      Directory whatsappBusinessDir = Directory(Config.whatsappBusinessPath);

      if (whatsappAndroid11FullPath.existsSync()) {
        mediaFiles.addAll(await _getAndroid11Files());
      }
      if (whatsappDir.existsSync()) {
        mediaFiles.addAll(_sortAndSeparateFiles(whatsappDir));
      }
      if (gbWhatsAppDir.existsSync()) {
        mediaFiles.addAll(_sortAndSeparateFiles(gbWhatsAppDir));
      }
      if (whatsappBusinessDir.existsSync()) {
        mediaFiles.addAll(_sortAndSeparateFiles(whatsappBusinessDir));
      }

      mediaFiles
          .sort((a, b) => b.lastModifiedSync().compareTo(a.lastModifiedSync()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    //TODO: refactor this into a separate function that takes an action (function as a parameter)
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

  downloadMedia(File file) {
    Directory dir = Directory(Config.saveDir);

    if (!dir.existsSync()) {
      dir.createSync();
    }

    File newFile = file.copySync("${dir.path}/${basename(file.path)}");

    if (newFile.existsSync()) {
      MediaScanner.loadMedia(path: newFile.path);
      Get.snackbar("", "",
          titleText: Center(
            
              child: Text(
            "Status saved successfully",
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
