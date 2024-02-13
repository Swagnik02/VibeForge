import 'dart:convert';

import 'package:vibeforge/common/utils.dart';

class VibeArtist {
  final String? name;
  final String? url;
  final String? img;
  final List<String>? genres;

  VibeArtist({this.img, this.genres, this.name, this.url});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
      'img': img,
      'genres': genres,
    };
  }

  factory VibeArtist.fromMap(Map<String, dynamic> map) {
    return VibeArtist(
      name: map['name'],
      url: map['url'],
      img: map['img'],
      genres: List<String>.from(map['genres'] ?? []),
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mood': mood,
      'genre': genre,
    };
  }

  factory VibeTag.fromMap(Map<String, dynamic> map) {
    return VibeTag(
      name: map['name'],
      mood: map['mood'],
      genre: map['genre'],
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'genre': genre,
      'artists': jsonEncode(artists?.map((artist) => artist.toMap()).toList()),
      'url': url,
      'imageUrl': imageUrl,
      'songUrl': songUrl,
      'tags': jsonEncode(tags?.map((tag) => tag.toMap()).toList()),
    };
  }

  factory VibeSong.fromMap(Map<String, dynamic> map) {
    var artistsList = map['artists'] != null
        ? List<VibeArtist>.from(
            map['artists'].map((artistMap) => VibeArtist.fromMap(artistMap)))
        : null;

    var tagsList = map['tags'] != null
        ? List<VibeTag>.from(
            map['tags'].map((tagMap) => VibeTag.fromMap(tagMap)))
        : null;

    return VibeSong(
      name: map['name'],
      genre: map['genre'],
      artists: artistsList,
      url: map['url'],
      imageUrl: map['imageUrl'],
      songUrl: map['songUrl'],
      tags: tagsList,
    );
  }

  static List<VibeSong> songs = [
    VibeSong(
      name: 'Forever and Always',
      artists: [
        VibeArtist(
          name: 'Abe',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Genre_here'],
        ),
      ],
      genre: 'Soft',
      songUrl: 'assets/music/Forever & Always.mp3',
      imageUrl: 'assets/covers/Forever & Always.jpg',
      tags: [
        VibeTag(name: 'Emotional', mood: 3),
      ],
    ),
    VibeSong(
      name: 'Hoye Jetey Paari',
      artists: [
        VibeArtist(
          name: 'Anupam Roy',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Indie', 'Rock'],
        ),
      ],
      genre: 'Indie, Rock',
      songUrl:
          '${LocalAssetDirectories.localAssetsMusicrDir}Hoye Jetey Paari.mp3',
      imageUrl:
          '${LocalAssetDirectories.localAssetsCoversDir}Hoye Jetey Paari.jpg',
      tags: [
        VibeTag(name: 'Nostalgia', mood: 5),
      ],
    ),
    VibeSong(
      name: '8 Letters',
      artists: [
        VibeArtist(
          name: 'Why Don\'t We',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Pop'],
        ),
      ],
      genre: 'Pop',
      songUrl: '${LocalAssetDirectories.localAssetsMusicrDir}8 Letters.mp3',
      imageUrl: '${LocalAssetDirectories.localAssetsCoversDir}8 Letters.jpg',
      tags: [
        VibeTag(name: 'Love', mood: 2),
      ],
    ),
    VibeSong(
      name: 'Hold Me While You Wait',
      artists: [
        VibeArtist(
          name: 'Lewis Capaldi',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Pop', 'Soul'],
        ),
      ],
      genre: 'Pop, Soul',
      songUrl:
          '${LocalAssetDirectories.localAssetsMusicrDir}Hold Me While You Wait.mp3',
      imageUrl:
          '${LocalAssetDirectories.localAssetsCoversDir}Hold Me While You Wait.jpg',
      tags: [
        VibeTag(name: 'Longing', mood: 4),
      ],
    ),
    VibeSong(
      name: 'Its You',
      artists: [
        VibeArtist(
          name: 'Ali Gatie',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['R&B', 'Soul'],
        ),
      ],
      genre: 'R&B, Soul',
      songUrl: '${LocalAssetDirectories.localAssetsMusicrDir}Its You.mp3',
      imageUrl: '${LocalAssetDirectories.localAssetsCoversDir}Its You.jpg',
      tags: [
        VibeTag(name: 'Romantic', mood: 2),
      ],
    ),
    VibeSong(
      name: 'Tomake Chai',
      artists: [
        VibeArtist(
          name: 'Arijit Singh',
          url: 'artist_url_here',
          img: 'artist_image_url_here',
          genres: ['Bollywood', 'Romance'],
        ),
      ],
      genre: 'Bollywood, Romance',
      songUrl: '${LocalAssetDirectories.localAssetsMusicrDir}Tomake Chai.mp3',
      imageUrl: '${LocalAssetDirectories.localAssetsCoversDir}Tomake Chai.jpg',
      tags: [
        VibeTag(name: 'Desire', mood: 2),
      ],
    ),
  ];
}
