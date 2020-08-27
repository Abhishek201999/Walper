import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class DisplaySheet extends StatefulWidget {
  final String id;
  final String downloadUrl;
  final String description;
  final String firstName;
  final String lastName;
  final String profile;

  DisplaySheet(this.id, this.downloadUrl, this.description, this.firstName,
      this.lastName, this.profile);

  @override
  _DisplaySheetState createState() => _DisplaySheetState();
}

class _DisplaySheetState extends State<DisplaySheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 23,
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.profile),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.firstName,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Text(
                'unspash.com',
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon((Icons.favorite_border)),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon((Icons.file_download)),
                onPressed: () => _save(),
              ),
              IconButton(
                icon: Icon((Icons.wallpaper)),
                onPressed: setWallpaperDialog,
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _save() async {
    var response = await Dio().get(widget.downloadUrl,
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 60,
      name: widget.description != null ? widget.description : widget.id,
    );
    print(result);
    Fluttertoast.showToast(
      msg: "Wallpaper Downloaded",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  void setWallpaperDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Set a wallpaper',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(1, context, widget.downloadUrl),
              ),
              ListTile(
                title: Text(
                  'Lock Screen',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(2, context, widget.downloadUrl),
              ),
              ListTile(
                title: Text(
                  'Both',
                  style: TextStyle(color: Colors.black),
                ),
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                onTap: () => _setWallpaper(3, context, widget.downloadUrl),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _setWallpaper(
    int wallpaperType, BuildContext context, String downloadUrl) async {
  var file = await DefaultCacheManager().getSingleFile(downloadUrl);
  print(file.path);
  try {
    final String result =
        await WallpaperManager.setWallpaperFromFile(file.path, wallpaperType);
    print(result);
  } on PlatformException catch (e) {
    print("failed to set wallpaper:'${e.message}'.");
  }
  Fluttertoast.showToast(
    msg: "Wallpaper set successfully",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: Colors.black,
    fontSize: 16.0,
  );
  Navigator.pop(context);
}
