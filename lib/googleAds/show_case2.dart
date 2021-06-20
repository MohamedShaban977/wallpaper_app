import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/flutter_google_ad_manager.dart';
import 'package:masrawy/core/googleAds/ad_model.dart';

import 'channel_id_helper.dart';

class ShowCaseAd2 extends StatefulWidget {
  // final adUnitId;
  //
  // ShowCaseAd({this.adUnitId});

  @override
  _ShowCaseAd2State createState() => _ShowCaseAd2State();
}

class _ShowCaseAd2State extends State<ShowCaseAd2> {
  bool isFailed = false;
  GoogleAdChannelIdHelper _googleAdChannelIdHelper = GoogleAdChannelIdHelper();
  Future<AdModel> _futuregetAdShowCase2;
  // AdModel showCase2;

  getshow() {
   if (_futuregetAdShowCase2 != null)return;

    _futuregetAdShowCase2 = _googleAdChannelIdHelper.getAdUnit(
        GoogleAdChannelIdHelper.mapCategoriesToChannel[23],
        GoogleAdChannelIdHelper.showCase1TypeId);
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getshow();
  }
  @override
  Widget build(BuildContext context) {
    return isFailed
        ? Text('')
        : Column(
            children: [
              Text('اعلان'),
              FutureBuilder<AdModel>(
                  future: _futuregetAdShowCase2,
                  builder: (contect, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('else banner');
                    }
                    return DFPBanner(
                      isDevelop: false,
                      adUnitId: snapshot.data.codeText,
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
                    );
                  }),
            ],
          );
  }
}
