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
  static String coverTheWantedGladYouCame =
      '${LocalAssetDirectories.localAssetsCoversDir}${LocalAssetsMusic.theWantedGladYouCame}.jpg';
  static String coverOwlCityGold =
      '${LocalAssetDirectories.localAssetsCoversDir}${LocalAssetsMusic.owlCityGold}.jpg';
  static String coverAkonFreedom =
      '${LocalAssetDirectories.localAssetsCoversDir}${LocalAssetsMusic.akonFreedom}.png';

  // songs urls
  static String songTheWantedGladYouCame =
      '${LocalAssetDirectories.localAssetsMusicrsDir}${LocalAssetsMusic.theWantedGladYouCame}.mp3';
  static String songOwlCityGold =
      '${LocalAssetDirectories.localAssetsMusicrsDir}${LocalAssetsMusic.owlCityGold}.mp3';
  static String songAkonFreedom =
      '${LocalAssetDirectories.localAssetsMusicrsDir}${LocalAssetsMusic.akonFreedom}.mp3';

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
  static String akonFreedom = 'akon_freedom';
  static String owlCityGold = 'owl_city_gold';
  static String theWantedGladYouCame = 'the_wanted_glad_you_came';
}

class LocalAssetDirectories {
  static String localAssetsImagesDir = 'assets/images/';
  static String localAssetsCoversDir = 'assets/covers/';
  static String localAssetsMusicrsDir = 'assets/music/';
}

class ColorConstants {
  static Color themeColour = const Color(0xFF14052b);

  static Color themeColourShade1 = const Color(0x94421F7E);
  static Color themeColourShade2 = const Color(0xBD14052B);
  static Color themeColourShade3 = const Color(0x6314052B);
}
