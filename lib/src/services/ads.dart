import 'package:get/instance_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:whatsapp_status_saver/src/controller/homepage_controller.dart';

import '../config/ad_config.dart';

BannerAdListener homeBannerListenerService = BannerAdListener(
  onAdLoaded: (Ad ad) {
    HomePageController homePageController = Get.find();
    homePageController.isHomeAdLoaded.value = true;
  },
);

final BannerAd homeBannerAd = BannerAd(
    adUnitId: AdsConfig.homePageAdBanner,
    size: AdSize.banner,
    request: const AdRequest(nonPersonalizedAds: false),
    listener: homeBannerListenerService);

BannerAdListener exitBannerListenerService = BannerAdListener(
  onAdLoaded: (Ad ad) {
    HomePageController homePageController = Get.find();
    homePageController.isHomeAdLoaded.value = true;
  },
);

final BannerAd exitBannerAd = BannerAd(
    adUnitId: AdsConfig.exitPageBanner,
    size: AdSize.mediumRectangle,
    request: const AdRequest(nonPersonalizedAds: false),
    listener: homeBannerListenerService);
