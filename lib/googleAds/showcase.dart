import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/ad_size.dart';
import 'package:flutter_google_ad_manager/banner.dart';

class ShowCaseAd extends StatelessWidget {
  final adUnitId;

  ShowCaseAd({this.adUnitId});

  bool isFailed = false;

  @override
  Widget build(BuildContext context) {
    return isFailed
        ? Text('')
        : Column(
            children: [
              Text('اعلان'),
              DFPBanner(
                isDevelop: false,
                adUnitId: adUnitId,
                adSize: DFPAdSize.MEDIUM_RECTANGLE,
                onAdLoaded: () {
                  print('Banner onAdLoaded');
                },
                onAdFailedToLoad: (errorCode) {
                  print('Banner onAdFailedToLoad: errorCode:$errorCode');
                  if (isFailed) isFailed = true;
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
              ),
            ],
          );
  }
}
