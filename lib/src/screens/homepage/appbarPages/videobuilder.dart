import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:whatsapp_status_saver/src/common/widgets/video_thumbnail_widget.dart';
import 'package:whatsapp_status_saver/src/controller/saved_media_controller.dart';


class VideoBuilder extends StatefulWidget {
  const VideoBuilder({Key? key}) : super(key: key);

  @override
  State<VideoBuilder> createState() => _VideoBuilderState();
}

class _VideoBuilderState extends State<VideoBuilder> {
  @override
  Widget build(BuildContext context) {
    SavedMediaController savedMediaController = Get.put(SavedMediaController());

    return Scaffold(
     
      body: Obx(
        () => GridView.builder(
          itemCount: savedMediaController.videoFiles.length,
          itemBuilder: (context, index) => SizedBox(
            height: 250.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: GestureDetector(
                         onTap: () => savedMediaController.onVideoClick(index),
                         child: Hero(
                           tag: "image$index",
                           child: BuildVideoThumbnail(
                             file: savedMediaController.videoFiles[index],
                           ),
                         ),
                       ),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 3.0,
            mainAxisExtent: 280,
            mainAxisSpacing: 3.0,
          ),
        ),
      ),
    );
  }
}
