import 'package:flutter/material.dart';
import 'wallpaper_latest.dart';
import '../screens/wallpaper_popular.dart';
import '../screens/search_wallpaper.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  // List<Map<String, Object>> _pages;

  int _selectedPageIndex = 0;
  List<Widget> pages = [
    WallpaperLatest(),
    WallpaperPopular(),
  ];

  // @override
  // void initState() {
  //   _pages = [
  //     {
  //       'page': WallpaperLatest(),
  //     },
  //     {
  //       'page': WallpaperPopular(),
  //     },
  //   ];
  //   super.initState();
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Walper',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed(SearchWallpaper.routeName);
            },
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedPageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_quilt),
            title: Text('Latest'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            title: Text('Popular'),
          ),
        ],
      ),
    );
  }
}
