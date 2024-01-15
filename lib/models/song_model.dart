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
    // Song(
    //   title: 'Dont Stay',
    //   description: 'Owl City',
    //   url:
    //       'https://ncsmusic.s3.eu-west-1.amazonaws.com/tracks/000/001/601/dont-stay-1704934851-zQtgjDlDI6.mp3',
    //   coverUrl:
    //       'https://ncsmusic.s3.eu-west-1.amazonaws.com/tracks/000/001/601/325x325/1704967625_DgryNWWoMq_final.jpg',
    // ),
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
