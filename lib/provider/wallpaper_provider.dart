import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/wallpaper.dart';
import 'package:http/http.dart' as http;
import '../models/api_key.dart';

class WallpaperProvider with ChangeNotifier {
  List<UnsplashWallpaper> _wallpapers = [];
  List<UnsplashWallpaper> _popularWallpaper = [];
  List<UnsplashWallpaper> _searchWallpaper = [];
  List<UnsplashWallpaper> searchWalls = [];
  List<UnsplashWallpaper> _listOfUserWalls = [];

  List<UnsplashWallpaper> get listOfUserWalls {
    return [..._listOfUserWalls];
  }

  List<UnsplashWallpaper> get wallpapers {
    return [..._wallpapers];
  }

  List<UnsplashWallpaper> get popularWallpaper {
    return [..._popularWallpaper];
  }

  List<UnsplashWallpaper> get searchWall {
    return [..._searchWallpaper];
  }

  Future<List<UnsplashWallpaper>> fetchWallpaper(
      http.Client client, int page, String order) async {
    final url =
        'https://api.unsplash.com/photos/?page=$page&per_page=30&order_by=$order&client_id=$apiKey';

    final response = await client.get(url);
    return parsePhotos(response.body);
  }

  List<UnsplashWallpaper> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<UnsplashWallpaper>((json) => UnsplashWallpaper.fromJson(json))
        .toList();
  }

  Future<List<UnsplashWallpaper>> searchWallpaper(
      http.Client client, String searchKeyword, int page) async {
    final url =
        'https://api.unsplash.com/search/photos/?page=$page&per_page=30&query=$searchKeyword&client_id=$apiKey';
    final response = await client.get(url);
    final parsed = json.decode(response.body) as Map<String, dynamic>;
    Iterable list = parsed['results'];
    print(list.runtimeType);

    return list
        .map<UnsplashWallpaper>((e) => UnsplashWallpaper.fromJson(e))
        .toList();
  }

  Future<void> getSearchWallpaper(String searchKeyword, int page) async {
    searchWalls = await searchWallpaper(http.Client(), searchKeyword, page);
    _searchWallpaper.addAll(searchWalls);

    notifyListeners();
  }

  void clearSearchWallpaper() {
    searchWalls.clear();
    _searchWallpaper.clear();

    notifyListeners();
  }

  Future<void> getWallpaper(int page, String order) async {
    List<UnsplashWallpaper> getWalls = [];
    getWalls = await fetchWallpaper(http.Client(), page, order);
    print('fetch walls');
    order == 'popular'
        ? _popularWallpaper.addAll(getWalls)
        : _wallpapers.addAll(getWalls);
    notifyListeners();
  }

  UnsplashWallpaper findWallpaperById(String id, String order) {
    UnsplashWallpaper wall;
    if (order == 'latest') {
      wall = _wallpapers.firstWhere((wallId) => wallId.id == id);
    } else if (order == 'popular') {
      wall = _popularWallpaper.firstWhere((wallId) => wallId.id == id);
    } else if (order == 'relevant') {
      wall = _searchWallpaper.firstWhere((wallId) => wallId.id == id);
    } else {
      wall = _listOfUserWalls.firstWhere((element) => element.id == id);
    }
    return wall;
  }

  Future<String> downloadWallpaper(String url) async {
    final response = await http.get(url + '?cliend_id=$apiKey');
    final parsed = json.decode(response.body) as Map<String, dynamic>;
    return parsed['url'];
  }

  Future<void> listOfUserPhotos(String username) async {
    List<UnsplashWallpaper> userWalls = [];
    final url =
        'https://api.unsplash.com/users/$username/photos/?page=1&per_page=30&client_id=$apiKey';
    final response = await http.get(url);
    userWalls = parsePhotos(response.body);
    _listOfUserWalls.addAll(userWalls);
    notifyListeners();
  }
}
