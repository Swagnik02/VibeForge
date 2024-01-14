import 'package:vibeforge/common/utils.dart';

class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'Gold',
      description: 'Owl City',
      url: LocalAssets.songOwlCityGold,
      coverUrl: LocalAssets.coverOwlCityGold,
    ),
    Song(
      title: 'Freedom',
      description: 'Akon',
      url: LocalAssets.songAkonFreedom,
      coverUrl: LocalAssets.coverAkonFreedom,
    ),
    Song(
      title: 'Glad You Came',
      description: 'The Weekend',
      url: LocalAssets.songTheWantedGladYouCame,
      coverUrl: LocalAssets.coverTheWantedGladYouCame,
    ),
  ];
}
