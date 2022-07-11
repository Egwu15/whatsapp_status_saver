import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:whatsapp_status_saver/src/controller/homepage_controller.dart';
import '../screens/slider_page.dart';
import '../services/get_permission.dart';
import '../services/file_handler.dart';

class SavedMediaController extends GetxController {
  RxList<File> imageFiles = <File>[].obs;
  RxList<File> videoFiles = <File>[].obs;
  RxInt selectedIndex = 0.obs;

  final FileHandler _fileHandler = FileHandler();
  final HomePageController _homePageController = Get.find();

  @override
  void onInit() {
    _checkforPermissionAndGetFIles();
    super.onInit();
  }

  videoThunail(videoPath) async =>
      await _fileHandler.fetchVideoThumbnail(videoPath);

  void _checkforPermissionAndGetFIles() async {
    await DevicePermission().checkFilePermissionStatus();
    imageFiles.value = _fileHandler.getSavedImages();
    videoFiles.value = _fileHandler.getSavedVideos();
  }

  void onVideoClick(int index) {
    _homePageController.selectedIndex.value = index;
    Get.to(
      () => MediaSlider(mediaFiles: videoFiles, showDownload: false),
      duration: const Duration(milliseconds: 500),
    );
  }

  void onImageClick(int index) {
    _homePageController.selectedIndex.value = index;
    Get.to(
      () => MediaSlider(mediaFiles: imageFiles, showDownload: false),
      duration: const Duration(milliseconds: 500),
    );
  }
}
