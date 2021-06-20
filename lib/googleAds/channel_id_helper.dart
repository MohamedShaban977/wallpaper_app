import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'ad_model.dart';

class GoogleAdChannelIdHelper {
  static const int leaderBoardTypeId1 = 2;
  static const int leaderBoardTypeId2 = 3;

  static const int interstitialTypeId = 25;

  static const int showCase1TypeId = 5; //
  static const int showCase2TypeId = 6; //

  static const int sponsorTypeId = 4;

  static Map<int, int> mapCategoriesToChannel = {
    23: 23,
    18: 18,
    373: 373,
    40: 40,
    210: 210,
    54: 54,
    262: 262,
    34: 34,
    97: 97,
    92: 92,
    67: 67
  };
String textCode ;

  Future<AdModel> getAdUnit(int categoryId, int adType) async {
    if (!mapCategoriesToChannel.containsKey(categoryId)) return null;

    int channelId = mapCategoriesToChannel[categoryId];

    final url =
        'http://api.ams.gemini.media/api/AdCode/getAdCode?channelId=$channelId&typeId=$adType&applicationId=3';
    final response = await get(
      url,
    );
    var body = jsonDecode(response.body);
    AdModel res = AdModel.fromJson(body);

    textCode =res.codeText;
    print(body['CodeText']);

    return res;
  }

  // static Future<String> getAdUnit(int categoryId,int adType)async{
  //   if(!mapCategoriesToChannel.containsKey(categoryId)) return null;
  //   int channelId = mapCategoriesToChannel[categoryId];
  //   final String url = 'http://api.ams.gemini.media/api/AdCode/getAdCode?channelId=$channelId&typeId=$adType&applicationId=3';
  //   final response = await Dio().get(url);
  //   GoogleAdModel googleAdModel = GoogleAdModel.fromJson(response.data);
  //   return googleAdModel.codeText;
  // }

}
