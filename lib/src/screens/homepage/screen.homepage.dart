import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_status_saver/src/common/widgets/video_thumbnail_widget.dart';
import 'package:whatsapp_status_saver/src/screens/homepage/exit_page.dart';
import 'package:whatsapp_status_saver/src/services/ads.dart';
import '../../controller/homepage_controller.dart';
import 'app_drawer.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.put(HomePageController());

    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: const Text('Status Saver WhatsApp'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.dialog(const ExitHomePage());
          return false;
        },
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () => homePageController.onRefreshHome(),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: homePageController.onLoadHome(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          return GridView.builder(
                            itemCount: homePageController.mediaFiles.length,
                            itemBuilder: (context, index) => SizedBox(
                              height: 250.0,
                              width: double.infinity,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      homePageController.mediaFiles[index].path
                                              .endsWith("jpg")
                                          ? GestureDetector(
                                              onTap: () => homePageController
                                                  .onMediaClick(index),
                                              child: Hero(
                                                tag: "image$index",
                                                child: Image.file(
                                                  homePageController
                                                      .mediaFiles[index],
                                                  fit: BoxFit.cover,
                                                  height: 217,
                                                  width: double.maxFinite,
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () => homePageController
                                                  .onMediaClick(index),
                                              child: Hero(
                                                tag: "image$index",
                                                child: BuildVideoThumbnail(
                                                  file: homePageController
                                                      .mediaFiles[index],
                                                ),
                                              ),
                                            ),
                                      TextButton(
                                        onPressed: () => homePageController
                                            .downloadFile(index),
                                        style: TextButton.styleFrom(
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                        ),
                                        child:
                                            const Icon(Icons.download_outlined),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 3.0,
                              mainAxisExtent: 280,
                              mainAxisSpacing: 3.0,
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        }
                      }),
                ),
                if (homePageController.isHomeAdLoaded.value)
                  SizedBox(
                      height: homeBannerAd.size.height.ceilToDouble(),
                      child: AdWidget(ad: homeBannerAd))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
