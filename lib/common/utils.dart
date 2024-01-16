class GlobalUtils {}

class TestProfile {
  static String userName = 'Swagnik';
  static String email = 'swagnik1234@gmail.com';
  static String profilePic = LocalAssets.avatar;
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
      '${LocalAssetDirectories.localAssetsImagesDir}avatar.jpg';
  static String ncsLogo =
      '${LocalAssetDirectories.localAssetsImagesDir}ncs_logo.png';
  static String loadingAnim =
      '${LocalAssetDirectories.localAssetsImagesDir}splash_astraunaut.json';
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
