import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../provider/wallpaper_provider.dart';
import '../widgets/displaysheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../screens/user_credit_screen.dart';

class FullScreenWallpaper extends StatefulWidget {
  static const routeName = 'fullWallpaper';

  @override
  _FullScreenWallpaperState createState() => _FullScreenWallpaperState();
}

class _FullScreenWallpaperState extends State<FullScreenWallpaper> {
  String home = "Home Screen";
  Stream<String> progressString;
  String res;
  bool downloading = false;
  var testWall;
  @override
  Widget build(BuildContext context) {
    final wallId = ModalRoute.of(context).settings.arguments as List<String>;
    final id = wallId[0];
    final order = wallId[1];
    final wallpaperData = Provider.of<WallpaperProvider>(context, listen: false)
        .findWallpaperById(id, order);
    testWall = wallpaperData.fullWallpaper;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () async {
              await Provider.of<WallpaperProvider>(context, listen: false)
                  .listOfUserPhotos(wallpaperData.creatorUsername);
              Navigator.of(context).pushNamed(UserCreditScreen.routeName,
                  arguments: wallpaperData);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Padding(
                      child: CircularProgressIndicator(),
                      padding: EdgeInsets.all(8),
                    ),
                    imageUrl: wallpaperData.fullWallpaper,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: DisplaySheet(
        wallpaperData.id,
        wallpaperData.fullWallpaper,
        wallpaperData.altDescription,
        wallpaperData.firstName,
        wallpaperData.lastName,
        wallpaperData.creatorProfileImage,
      ),
    );
  }
}
