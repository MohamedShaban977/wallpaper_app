class AdModel {
  int id;
  Channel channel;
  Type type;
  Type app;
  String codeText;

  AdModel({this.id, this.channel, this.type, this.app, this.codeText});

  AdModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    channel =
    json['Channel'] != null ? new Channel.fromJson(json['Channel']) : null;
    type = json['Type'] != null ? new Type.fromJson(json['Type']) : null;
    app = json['App'] != null ? new Type.fromJson(json['App']) : null;
    codeText = json['CodeText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    if (this.channel != null) {
      data['Channel'] = this.channel.toJson();
    }
    if (this.type != null) {
      data['Type'] = this.type.toJson();
    }
    if (this.app != null) {
      data['App'] = this.app.toJson();
    }
    data['CodeText'] = this.codeText;
    return data;
  }
}

class Channel {
  int id;
  String name;
  Portal portal;
  Null parentChannel;

  Channel({this.id, this.name, this.portal, this.parentChannel});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    portal =
    json['Portal'] != null ? new Portal.fromJson(json['Portal']) : null;
    parentChannel = json['ParentChannel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    if (this.portal != null) {
      data['Portal'] = this.portal.toJson();
    }
    data['ParentChannel'] = this.parentChannel;
    return data;
  }
}

class Portal {
  int id;
  String name;
  String logoPath;

  Portal({this.id, this.name, this.logoPath});

  Portal.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    logoPath = json['LogoPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['LogoPath'] = this.logoPath;
    return data;
  }
}

class Type {
  int id;
  String name;

  Type({this.id, this.name});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}