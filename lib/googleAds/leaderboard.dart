import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/ad_size.dart';
import 'package:flutter_google_ad_manager/banner.dart';
import 'package:masrawy/core/googleAds/channel_id_helper.dart';

//class LeaderBoardAd extends StatefulWidget {
//  final  adUnitId;

class LeaderBoardAd extends StatelessWidget {
  final adUnitId;

  LeaderBoardAd({this.adUnitId});

  bool isFailed = false;

  @override
  Widget build(BuildContext context) {
    return isFailed
        ? Text('')
        : DFPBanner(
          isDevelop: false,
          adUnitId: adUnitId,
          adSize: DFPAdSize.FULL_BANNER,

          onAdLoaded: () {
            print('Banner onAdLoaded');
          },
          onAdFailedToLoad: (errorCode) {
            print('Banner onAdFailedToLoad: errorCode:$errorCode');
            isFailed = true;
          },
          onAdOpened: () {
            print('Banner onAdOpened');
          },
          onAdClosed: () {
            print('Banner onAdClosed');
          },
          onAdLeftApplication: () {
            print('Banner onAdLeftApplication');
          },
        );
  }
}
