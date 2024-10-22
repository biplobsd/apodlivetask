import 'dart:convert';

class Apod {
  String? hdurl;
  String? mediaType;
  String? url;

  Apod({this.hdurl, this.mediaType, this.url});

  Apod.fromJson(dynamic rawJson) {
    final json = jsonDecode(rawJson);

    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    url = json['url'];
  }
}
