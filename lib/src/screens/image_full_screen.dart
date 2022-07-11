import 'dart:io';

import 'package:flutter/material.dart';

class ImageFullScreen extends StatefulWidget {
  const ImageFullScreen({Key? key, required this.image}) : super(key: key);

  final File image;

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(
        widget.image,
      ),
    );
  }
}
