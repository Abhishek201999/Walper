import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../screens/wallpaper_full_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class WallpaperItem extends StatefulWidget {
  final UnsplashWallpaper wallpaper;
  final String order;
  WallpaperItem({this.order, this.wallpaper});

  @override
  _WallpaperItemState createState() => _WallpaperItemState();
}

class _WallpaperItemState extends State<WallpaperItem> {
  List<String> favoriteId = [];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(FullScreenWallpaper.routeName,
                arguments: [widget.wallpaper.id, widget.order]);
          },
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.wallpaper.regularWallpaper,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
