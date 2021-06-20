import 'package:flutter/material.dart';
import 'package:flutter_google_ad_manager/ad_size.dart';
import 'package:flutter_google_ad_manager/banner.dart';
import 'package:masrawy/core/googleAds/channel_id_helper.dart';

class SponsorAd extends StatefulWidget {
  final int categoryId;

  SponsorAd(this.categoryId);
  @override
  _SponsorAdState createState() => _SponsorAdState();
}

class _SponsorAdState extends State<SponsorAd> {
  bool isFailed = true;

  @override
  void initState() {
    // getId();
    super.initState();
  }
  String id ='';
  // getId()async{
  //   id = await GoogleAdChannelIdHelper.getAdUnit(widget.categoryId, GoogleAdChannelIdHelper.sponsorTypeId);
  //   if(id != null && id.isNotEmpty) isFailed = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return isFailed ? Text('') : Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(
        children: [
          Text('اعلان',style: TextStyle(color: Colors.white),),
          DFPBanner(
            isDevelop: false,
            adUnitId: id,
            adSize: DFPAdSize.custom(width: 320, height: 50),
            onAdLoaded: () {
              print('Banner onAdLoaded');
            },
            onAdFailedToLoad: (errorCode) {
              print('Banner onAdFailedToLoad: errorCode:$errorCode');
              setState(()=> isFailed = true);
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
      ),
    );
  }
}
