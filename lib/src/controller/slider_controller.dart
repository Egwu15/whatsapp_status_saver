import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:whatsapp_status_saver/src/controller/homepage_controller.dart';
import 'package:whatsapp_status_saver/src/services/file_handler.dart';

class SlideController extends GetxController {
  final CarouselController carouselController = CarouselController();
  final HomePageController _homePageController = Get.find();
  final FileHandler _fileHandler = FileHandler();

  @override
  void onInit() async {
    await carouselController.onReady.then(
      (_) =>
          carouselController.jumpToPage(_homePageController.selectedIndex.value),
    );
    super.onInit();
  }

  downloadFile() => FileHandler().downlaodMedia(
      _homePageController.mediaFiles[_homePageController.selectedIndex.value]);

  shareFile() => _fileHandler.shareFile(
      _homePageController.mediaFiles[_homePageController.selectedIndex.value]);
}
