import 'package:get/instance_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_status_saver/src/controller/homepage_controller.dart';

BannerAdListener homeBannerlistnerService = BannerAdListener(
  onAdLoaded: (Ad ad) {
    HomePageController homePageController = Get.find();
    homePageController.isHomeaAdLoaded.value = true;
  },
);

final BannerAd homeBannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.banner,
    request: const AdRequest(nonPersonalizedAds: false),
    listener: homeBannerlistnerService);

BannerAdListener exitBannerlistnerService = BannerAdListener(
  onAdLoaded: (Ad ad) {
    HomePageController homePageController = Get.find();
    homePageController.isHomeaAdLoaded.value = true;
  },
);

final BannerAd exitBannerAd = BannerAd(
    adUnitId: 'ca-app-pub-3940256099942544/6300978111',
    size: AdSize.mediumRectangle,
    request: const AdRequest(nonPersonalizedAds: false),
    listener: homeBannerlistnerService);
