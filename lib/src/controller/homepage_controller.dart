import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:whatsapp_status_saver/src/services/ads.dart';
import '../screens/slider_page.dart';
import '../services/get_permission.dart';
import '../services/file_handler.dart';

class HomePageController extends GetxController {
  RxList<File> mediaFiles = <File>[].obs;
  RxInt selectedIndex = 0.obs;
  RxBool isHomeaAdLoaded = false.obs;
  RxBool isExitAdLoaded = false.obs;

  final FileHandler _fileHandler = FileHandler();

  @override
  void onInit() {
    _checkforPermissionAndGetFIles();
    homeBannerAd.load();
    exitBannerAd.load();

    super.onInit();
  }

  videoThunail(videoPath) async =>
      await _fileHandler.fetchVideoThumbnail(videoPath);

  void _checkforPermissionAndGetFIles() async {
    await DevicePermission().checkFilePermissionStatus();
    mediaFiles.value = _fileHandler.getMediaFiles();
  }

  void onMediaClick(int index) {
    selectedIndex.value = index;
    Get.to(
      () => MediaSlider(mediaFiles: mediaFiles),
      duration: const Duration(milliseconds: 500),
    );
  }

  void downloadFile(index) => _fileHandler.downlaodMedia(mediaFiles[index]);
}
