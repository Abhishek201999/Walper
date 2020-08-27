import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walper/provider/wallpaper_provider.dart';
import 'package:walper/screens/wallpaper_latest.dart';
import './screens/wallpaper_full_screen.dart';
import './screens/tab_screen.dart';
import './screens/wallpaper_popular.dart';
import './screens/search_wallpaper.dart';
import './screens/user_credit_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => WallpaperProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Walper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.dark,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.black.withOpacity(0.2),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(),
          WallpaperLatest.routeName: (ctx) => WallpaperLatest(),
          WallpaperPopular.routeName: (ctx) => WallpaperPopular(),
          SearchWallpaper.routeName: (ctx) => SearchWallpaper(),
          FullScreenWallpaper.routeName: (ctx) => FullScreenWallpaper(),
          UserCreditScreen.routeName: (ctx) => UserCreditScreen(),
        },
      ),
    );
  }
}
