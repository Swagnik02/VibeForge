import 'package:vibeforge/common/utils.dart';

class VibeArtist {
  final String? name;
  final String? url;
  final String? img;
  final List<String>? genres;
  // final List<Song>? songs;

  VibeArtist({this.img, this.genres, /*this.songs*/ this.name, this.url});
}

class VibeTag {
  final String? name;
  final int? mood;
  final int? genre;

  VibeTag({
    this.name,
    this.mood,
    this.genre,
  });
}

class VibeSong {
  final String? name;
  final String? genre;
  final List<VibeArtist>? artists;
  final String? url;
  final String? imageUrl;
  final String? songUrl;
  final List<VibeTag>? tags;

  VibeSong({
    this.name,
    this.genre,
    this.artists,
    this.url,
    this.imageUrl,
    this.songUrl,
    this.tags,
  });
}

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
