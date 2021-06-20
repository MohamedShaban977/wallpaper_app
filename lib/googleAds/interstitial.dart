import 'package:flutter_google_ad_manager/interstitial_ad.dart';

class InterstitialAd {
  final String adUnitId;
  InterstitialAd(this.adUnitId);

  void showAd(){
    if(adUnitId == null || adUnitId.isEmpty) return;
    _interstitialAd = DFPInterstitialAd(
      isDevelop: false,
      adUnitId: adUnitId,
      onAdLoaded: () {
        print('interstitialAd onAdLoaded');
        _interstitialAd.show();
      },
      onAdFailedToLoad: (errorCode) {
        print('interstitialAd onAdFailedToLoad: errorCode:$errorCode');
      },
      onAdOpened: () {
        print('interstitialAd onAdOpened');
      },
      onAdClosed: () {
        print('interstitialAd onAdClosed');
      },
      onAdLeftApplication: () {
        print('interstitialAd onAdLeftApplication');
      },
    );
    _interstitialAd.load();
  }

  void disposeAd(){
    _interstitialAd.dispose();
  }

  DFPInterstitialAd _interstitialAd;

}