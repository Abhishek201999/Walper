import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/wallpaper_item.dart';
import '../provider/wallpaper_provider.dart';

class SearchWallpaper extends StatefulWidget {
  static const routeName = 'search';
  @override
  _SearchWallpaperState createState() => _SearchWallpaperState();
}

class _SearchWallpaperState extends State<SearchWallpaper> {
  String key;
  ScrollController _sc = ScrollController();
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final searchWallData = Provider.of<WallpaperProvider>(context);
    final searchWall = searchWallData.searchWall;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          onSubmitted: (value) => onSubmit(value),
        ),
      ),
      body: key == null
          ? Center(
              child: Text('Search'),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, index) => WallpaperItem(
                      wallpaper: searchWall[index],
                      order: 'relevant',
                    ),
                    childCount: searchWall.length,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
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

  void onSubmit(String k) {
    if (key != k) {
      Provider.of<WallpaperProvider>(context, listen: false)
          .clearSearchWallpaper();
      setState(() {});
    }
    key = k;
    Provider.of<WallpaperProvider>(context, listen: false)
        .getSearchWallpaper(k, page);
    print(k);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        Provider.of<WallpaperProvider>(context, listen: false)
            .getSearchWallpaper(key, page);
        print(_sc.position.maxScrollExtent);
        setState(() {
          page++;
        });
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
}
