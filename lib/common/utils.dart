import 'package:flutter/material.dart';

class GlobalUtils {
  static bool isloggedIn = false;
}

class TestProfile {
  static String userName = 'Swagnik';
  static String fullName = 'Swagnik Saha';
  static String email = 'swagnik1234@gmail.com';
  static String mobile = '7318843109';
  static String profilePic = LocalAssets.avatar;
  static String password = 'password02';
}

class LocalAssets {
  // cover images

  // // songs urls

  // others
  static String appLogo =
      '${LocalAssetDirectories.localAssetsImagesDir}app_logo.png';
  static String avatar =
      '${LocalAssetDirectories.localAssetsImagesDir}avatar.png';
  static String ncsLogo =
      '${LocalAssetDirectories.localAssetsImagesDir}ncs_logo.png';
  static String loadingAnim =
      '${LocalAssetDirectories.localAssetsImagesDir}splash_astraunaut.json';
  static String waveAnim =
      '${LocalAssetDirectories.localAssetsImagesDir}wave_horizontal.json';
  static String ncsVisualizerYellow =
      '${LocalAssetDirectories.localAssetsImagesDir}ncsVisualizer.gif';
}

class LocalAssetsMusic {
  // static String akonFreedom = 'akon_freedom';
  // static String owlCityGold = 'owl_city_gold';
  // static String theWantedGladYouCame = 'the_wanted_glad_you_came';
}

class LocalAssetDirectories {
  static String localAssetsImagesDir = 'assets/images/';
  static String localAssetsCoversDir = 'assets/covers/';
  static String localAssetsMusicrDir = 'assets/music/';
}

class ColorConstants {
  static Color themeColour = const Color(0xFF14052b);

  static Color themeColourShade1 = const Color(0x94421F7E);
  static Color themeColourShade2 = const Color(0xBD14052B);
  static Color themeColourShade3 = const Color(0x6314052B);
}

class FilePath {
  static String ncsDownloads = '/storage/emulated/0/VibeForge/NCSdownloads';
}

class MusicSource {
  static const String localAssets = 'localAssets';
  static const String localDirectory = 'localDirectory';
  static const String apiNCS = 'apiNCS';
  static const String downloadedNCS = 'downloadedNCS';
}

class UsedStrings {
  static const String appName = 'Vibe Forge';
}

class SongsDb {
  static const String favSongsTable = 'favouriteSongs';
  static const String allSongsTable = 'songs';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnGenre = 'genre';
  static const String columnArtists = 'artists';
  static const String columnUrl = 'url';
  static const String columnImageUrl = 'imageUrl';
  static const String columnSongUrl = 'songUrl';
  static const String columnTags = 'tags';
}
