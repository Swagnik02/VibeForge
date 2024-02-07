import 'package:vibeforge/common/utils.dart';

class VibeArtist {
  final String? name;
  final String? url;
  final String? img;
  final List<String>? genres;

  VibeArtist({this.img, this.genres, this.name, this.url});
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

  static List<VibeSong> songs = [
    VibeSong(
      name: 'Gold',
      artists: [
        VibeArtist(
          name: 'Owl City',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Pop', 'Electronic'],
        ),
      ],
      songUrl: LocalAssets.songOwlCityGold,
      imageUrl: LocalAssets.coverOwlCityGold,
    ),
    VibeSong(
      name: 'Freedom',
      artists: [
        VibeArtist(
          name: 'Akon',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['R&B', 'Hip Hop'],
        ),
      ],
      songUrl: LocalAssets.songAkonFreedom,
      imageUrl: LocalAssets.coverAkonFreedom,
    ),
    VibeSong(
      name: 'Glad You Came',
      artists: [
        VibeArtist(
          name: 'The Wanted',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Pop', 'Rock'],
        ),
      ],
      songUrl: LocalAssets.songTheWantedGladYouCame,
      imageUrl: LocalAssets.coverTheWantedGladYouCame,
    ),
  ];
}
