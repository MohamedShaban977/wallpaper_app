// To parse this JSON data, do
//
//     final googleAdModel = googleAdModelFromJson(jsonString);

import 'dart:convert';

GoogleAdModel googleAdModelFromJson(String str) => GoogleAdModel.fromJson(json.decode(str));

String googleAdModelToJson(GoogleAdModel data) => json.encode(data.toJson());

class GoogleAdModel {
  GoogleAdModel({
    this.id,
    this.channel,
    this.type,
    this.app,
    this.codeText,
  });

  int id;
  Channel channel;
  App type;
  App app;
  String codeText;

  factory GoogleAdModel.fromJson(Map<String, dynamic> json) => GoogleAdModel(
    id: json["Id"],
    channel: Channel.fromJson(json["Channel"]),
    type: App.fromJson(json["Type"]),
    app: App.fromJson(json["App"]),
    codeText: json["CodeText"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Channel": channel.toJson(),
    "Type": type.toJson(),
    "App": app.toJson(),
    "CodeText": codeText,
  };
}

class App {
  App({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory App.fromJson(Map<String, dynamic> json) => App(
    id: json["Id"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
  };
}

class Channel {
  Channel({
    this.id,
    this.name,
    this.portal,
    this.parentChannel,
  });

  int id;
  String name;
  Portal portal;
  dynamic parentChannel;

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["Id"],
    name: json["Name"],
    portal: Portal.fromJson(json["Portal"]),
    parentChannel: json["ParentChannel"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Portal": portal.toJson(),
    "ParentChannel": parentChannel,
  };
}

class Portal {
  Portal({
    this.id,
    this.name,
    this.logoPath,
  });

  int id;
  String name;
  String logoPath;

  factory Portal.fromJson(Map<String, dynamic> json) => Portal(
    id: json["Id"],
    name: json["Name"],
    logoPath: json["LogoPath"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "LogoPath": logoPath,
  };
}
