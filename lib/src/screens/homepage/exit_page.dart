import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../services/ads.dart';

class ExitHomePage extends StatefulWidget {
  const ExitHomePage({Key? key}) : super(key: key);

  @override
  State<ExitHomePage> createState() => _ExitHomePageState();
}

class _ExitHomePageState extends State<ExitHomePage> {
  @override
  void dispose() {
    exitBannerAd.dispose();
    exitBannerAd.load();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
            height: exitBannerAd.size.height.ceilToDouble(),
            child: AdWidget(ad: exitBannerAd)),
        const SizedBox(height: 30.0),
        Text(
          'Are you sure you want to exit?',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                'Yes',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () =>
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            ),
            const SizedBox(width: 15.0),
            ElevatedButton(
              child: const Text(
                'No',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                exitBannerAd.load();
                Get.back();
              },
            ),
          ],
        ),
      ]),
    );
  }
}
