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
        // footer: ListTile(
        //   trailing: IconButton(
        //     padding: EdgeInsets.only(left: 35),
        //     icon: widget.wallpaper.isFavorite
        //         ? Icon(
        //             Icons.favorite,
        //             color: Colors.red,
        //           )
        //         : Icon(
        //             Icons.favorite_border,
        //           ),
        //     onPressed: () async {
        //       widget.wallpaper.setFavorite();
        //       if (widget.wallpaper.isFavorite == true) {
        //         favoriteId.add(widget.wallpaper.id);
        //         await _save();
        //         print(widget.wallpaper.isFavorite);
        //       }
        //       if (widget.wallpaper.isFavorite == false) {
        //         await _remove(widget.wallpaper.id);
        //         print(widget.wallpaper.isFavorite);
        //       }
        //       setState(() {});
        //     },
        //     color: Colors.white,
        //   ),
        // ),
      ),
    );
  }
}
