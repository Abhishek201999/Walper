import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walper/models/wallpaper.dart';
import '../provider/wallpaper_provider.dart';
import '../widgets/wallpaper_item.dart';

class UserCreditScreen extends StatefulWidget {
  static const routeName = 'credit';

  @override
  _UserCreditScreenState createState() => _UserCreditScreenState();
}

class _UserCreditScreenState extends State<UserCreditScreen> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final userData =
        ModalRoute.of(context).settings.arguments as UnsplashWallpaper;

    final userWallData =
        Provider.of<WallpaperProvider>(context, listen: false).listOfUserWalls;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 34,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(userData.creatorProfileImage),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        userData.firstName,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      userData.lastName != null
                          ? Text(
                              userData.lastName,
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(' '),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    userData.bio,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => WallpaperItem(
                wallpaper: userWallData[index],
                order: '',
              ),
              childCount: userWallData.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
          ),
        ],
        controller: _scrollController,
      ),
    );
  }
}
