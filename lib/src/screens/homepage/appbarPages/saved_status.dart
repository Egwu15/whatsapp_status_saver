import 'package:flutter/material.dart';
import 'imagebuilder.dart';
import 'videobuilder.dart';

class SavedStatus extends StatelessWidget {
  const SavedStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 25.0,
          title: Text('Saved Status',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 20.0)),
          bottom: const TabBar(
            tabs: [
              Icon(Icons.image_outlined),
              Icon(Icons.video_camera_back_outlined),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ImageBuilder(),
            VideoBuilder(),
          ],
        ),
      ),
    );
  }
}
