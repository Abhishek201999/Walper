import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class UnsplashWallpaper {
  final String id;
  final String height;
  final String width;
  final String altDescription;
  final String regularWallpaper;
  final String fullWallpaper;
  final String downloadWallpaper;
  final String creatorUsername;
  final String creatorInstagramUsername;
  final String creatorProfileImage;
  final String firstName;
  final String lastName;
  final String bio;
  bool isFavorite;

  UnsplashWallpaper({
    @required this.id,
    @required this.height,
    @required this.width,
    @required this.altDescription,
    @required this.regularWallpaper,
    @required this.fullWallpaper,
    @required this.downloadWallpaper,
    @required this.creatorUsername,
    @required this.creatorInstagramUsername,
    @required this.creatorProfileImage,
    @required this.firstName,
    @required this.lastName,
    @required this.bio,
    this.isFavorite = false,
  });

  void setFavorite() {
    isFavorite = !isFavorite;
  }

  factory UnsplashWallpaper.fromJson(Map<String, dynamic> json) {
    return UnsplashWallpaper(
      id: json['id'],
      height: json['height'].toString(),
      width: json['width'].toString(),
      altDescription: json['alt_description'],
      regularWallpaper: json['urls']['regular'],
      fullWallpaper: json['urls']['full'],
      downloadWallpaper: json['links']['download'],
      creatorUsername: json['user']['username'],
      creatorInstagramUsername: json['user']['instagram_username'],
      creatorProfileImage: json['user']['profile_image']['large'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      bio: json['user']['bio'],
    );
  }
}
