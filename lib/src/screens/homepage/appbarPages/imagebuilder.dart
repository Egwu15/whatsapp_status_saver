import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:whatsapp_status_saver/src/controller/saved_media_controller.dart';


class ImageBuilder extends StatefulWidget {
  const ImageBuilder({Key? key}) : super(key: key);

  @override
  State<ImageBuilder> createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  @override
  Widget build(BuildContext context) {
    SavedMediaController savedMediaController = Get.put(SavedMediaController());

    return Scaffold(
      body: Obx(
        () => GridView.builder(
          itemCount: savedMediaController.imageFiles.length,
          itemBuilder: (context, index) => SizedBox(
            height: 250.0,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: GestureDetector(
                  onTap: () => savedMediaController.onImageClick(index),
                  child: Hero(
                    tag: "image$index",
                    child: Image.file(
                      savedMediaController.imageFiles[index],
                      fit: BoxFit.cover,
                      height: 217,
                      width: double.maxFinite,
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
