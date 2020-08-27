import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/wallpaper_item.dart';
import '../provider/wallpaper_provider.dart';

class WallpaperLatest extends StatefulWidget {
  static const routeName = 'latest';

  @override
  _WallpaperLatestState createState() => _WallpaperLatestState();
}

class _WallpaperLatestState extends State<WallpaperLatest> {
  ScrollController _sc = ScrollController();
  var _initState = true;
  bool isLoading = false;
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final wallpaperData = Provider.of<WallpaperProvider>(context);
    final wallpaper = wallpaperData.wallpapers;
    return Scaffold(
      body: wallpaper.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => WallpaperItem(
                      wallpaper: wallpaper[index],
                      order: 'latest',
                    ),
                    childCount: wallpaper.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              ],
              controller: _sc,
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (_initState == true) {
      Provider.of<WallpaperProvider>(context, listen: false)
          .getWallpaper(page, 'latest');
      print(_initState);
      setState(() {
        _initState = false;
      });
      print(_initState);
    }
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        Provider.of<WallpaperProvider>(context, listen: false)
            .getWallpaper(page, 'latest');
        setState(() {
          page++;
          isLoading = false;
        });
        print(_sc.position.maxScrollExtent);
        print(page);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
}
