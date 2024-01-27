import 'package:vibeforge/screens/HomeScreen/home_screen.dart';
import 'package:vibeforge/splashScreen/splash_screen.dart';
import 'package:vibeforge/screens/playlist_screen.dart';
import 'package:vibeforge/screens/song_screen.dart';
import 'package:vibeforge/screens/Auth/auth_home.dart';
import 'package:vibeforge/screens/Auth/login_screen.dart';
import 'package:vibeforge/screens/BottomNav/NCSMusic/ncs_song_screen.dart';

import 'package:get/get.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/auth', page: () => const AuthHome()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/song', page: () => const SongScreen()),
    GetPage(name: '/NCSsong', page: () => const NCSSongScreen()),
    GetPage(name: '/playlist', page: () => const PlaylistScreen()),
  ];
}
