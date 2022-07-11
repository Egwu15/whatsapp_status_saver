import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import '../../src/controller/homepage_controller.dart';
import '../../src/controller/slider_controller.dart';
import '../../src/screens/image_full_screen.dart';
import '../../src/screens/video_player.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MediaSlider extends StatefulWidget {
  const MediaSlider(
      {Key? key, this.showDownload = true, required this.mediaFiles})
      : super(key: key);
  final bool showDownload;
  final List<File> mediaFiles;

  @override
  State<MediaSlider> createState() => _MediaSliderState();
}

class _MediaSliderState extends State<MediaSlider> {
  HomePageController homePageController = Get.find();
  SlideController slideController = Get.put(SlideController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.centerRight, children: [
        CarouselSlider(
          carouselController: slideController.carouselController,
          options: CarouselOptions(
              height: Get.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                homePageController.selectedIndex.value = index;
              }),
          items: widget.mediaFiles.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return i.path.endsWith("jpg")
                    ? ImageFullScreen(
                        image: i,
                      )
                    : VideoPlayerWidget(file: i);
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 50.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: Colors.green[900]?.withOpacity(0.8),
              ),
              child: IntrinsicHeight(
                child: Row(children: [
                  if (widget.showDownload)
                    IconButton(
                      icon: const Icon(Icons.download_outlined),
                      onPressed: () => slideController.downloadFile(),
                    ),
                  if (widget.showDownload)
                    const VerticalDivider(
                      thickness: 2,
                      color: Colors.green,
                    ),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () => slideController.shareFile(),
                  ),
                ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
