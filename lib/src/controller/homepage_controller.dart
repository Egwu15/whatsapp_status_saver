// ignore_for_file: unused_import

import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:whatsapp_status_saver/src/services/ads.dart';
import '../screens/slider_page.dart';
import '../services/get_permission.dart';
import '../services/file_handler.dart';
import '../services/lunch_url.dart';

class HomePageController extends GetxController {
  RxList<File> mediaFiles = <File>[].obs;
  RxInt selectedIndex = 0.obs;
  RxBool isHomeAdLoaded = false.obs;
  RxBool isExitAdLoaded = false.obs;

  final FileHandler _fileHandler = FileHandler();

  @override
  void onInit() {
    // _checkForPermissionAndGetFiles();
    homeBannerAd.load();
    exitBannerAd.load();

    super.onInit();
  }

  @override
  void dispose() {
    homeBannerAd.dispose();
    exitBannerAd.dispose();
    super.dispose();
  }

  videoThumbnail(videoPath) async =>
      await _fileHandler.fetchVideoThumbnail(videoPath);

  void _checkForPermissionAndGetFiles() async {
    await DevicePermission().checkFilePermissionStatus();
    mediaFiles.value = await _fileHandler.getMediaFiles();
  }

  Future<void> onRefreshHome() async => _checkForPermissionAndGetFiles();

  void onMediaClick(int index) {
    selectedIndex.value = index;
    Get.to(
      () => MediaSlider(mediaFiles: mediaFiles),
      duration: const Duration(milliseconds: 500),
    );
  }

  void downloadFile(index) => _fileHandler.downloadMedia(mediaFiles[index]);

  void lunchShareApp() => shareAppLink();
}
