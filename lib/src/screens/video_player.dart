import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_saver/src/controller/video_player_controller.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;
  ChewieController? chewieController;

  @override
  void initState() {
    _controller = VideoController().assignVideo(widget.file);
    initializeVideoController();
    chewieController = ChewieController(
      videoPlayerController: _controller,
      autoInitialize: true,
      autoPlay: true,
    );

    super.initState();
  }

  initializeVideoController() async {
    await _controller.initialize();

    setState(() {
      _controller.play();
    });
  }

  @override
  void dispose() {
    chewieController?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController!)
          : const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 4,
              ),
            ),
    );
  }
}
