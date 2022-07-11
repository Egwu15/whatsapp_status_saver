import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../services/file_handler.dart';

class BuildVideoThumbnail extends StatefulWidget {
  const BuildVideoThumbnail({Key? key, required this.file}) : super(key: key);
  final File file;

  @override
  State<BuildVideoThumbnail> createState() => _BuildVideoThumbnailState();
}

class _BuildVideoThumbnailState extends State<BuildVideoThumbnail> {
  @override
  Widget build(BuildContext context) {
    FileHandler fileHandler = FileHandler();
    return FutureBuilder<Uint8List?>(
      future: fileHandler.fetchVideoThumbnail(widget.file.path),
      builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.hasData) {
          return Stack(
            alignment: Alignment.center,
            
            children: [
              Center(
                child: Image.memory(
                  snapshot.data!,
                  fit: BoxFit.cover,
                  height: 217,
                  width: MediaQuery.of(context).size.width / 0.40,
                ),
              ),
              CircleAvatar(
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.6),
                child: const Icon(
                  Icons.play_arrow_outlined,
                ),
              )
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 4,
            ),
          );
        }
      },
    );
  }
}
