import 'dart:io';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  VideoPlayerController assignVideo(File video) => VideoPlayerController.file(video);
  
  
}
