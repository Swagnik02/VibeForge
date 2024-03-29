import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';

class AllSongsDatabaseService {
  static Database? _database;
  static final AllSongsDatabaseService instance = AllSongsDatabaseService._();

  AllSongsDatabaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    log('Database initialised');
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'songs.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
            CREATE TABLE IF NOT EXISTS ${SongsDb.allSongsTable} (
                ${SongsDb.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SongsDb.columnName} TEXT,
                ${SongsDb.columnGenre} TEXT,
                ${SongsDb.columnArtists} TEXT,
                ${SongsDb.columnUrl} TEXT,
                ${SongsDb.columnImageUrl} TEXT,
                ${SongsDb.columnSongUrl} TEXT,
                ${SongsDb.columnTags} TEXT
              )
          ''',
        );

        // Create the new table for favorites with the same schema as the Songs table
        await db.execute(
          '''
              CREATE TABLE IF NOT EXISTS ${SongsDb.favSongsTable} (
                ${SongsDb.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
                ${SongsDb.columnName} TEXT,
                ${SongsDb.columnGenre} TEXT,
                ${SongsDb.columnArtists} TEXT,
                ${SongsDb.columnUrl} TEXT,
                ${SongsDb.columnImageUrl} TEXT,
                ${SongsDb.columnSongUrl} TEXT,
                ${SongsDb.columnTags} TEXT,
                ${SongsDb.columnMusicSource} TEXT
              )
          ''',
        );
      },
    );
  }

  // all songs Datbase methods

  Future<void> insertSong(VibeSong song) async {
    final db = await database;
    await db.insert(
      SongsDb.allSongsTable,
      song.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VibeSong>> getSongs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(SongsDb.allSongsTable);
    return List.generate(maps.length, (i) {
      return VibeSong.fromMap(maps[i]);
    });
  }

  Future<void> deleteSong(int id) async {
    final db = await database;
    await db.delete(
      SongsDb.allSongsTable,
      where: '${SongsDb.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
    _database = null;
    log('Database Closed');
  }

  Future<void> logAllSongs() async {
    final db = await database;
    final List<Map<String, dynamic>> songs =
        await db.query(SongsDb.allSongsTable);
    for (var song in songs) {
      log('Song: $song');
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(SongsDb.allSongsTable);
    await db.delete(SongsDb.favSongsTable);
    log('Database cleared');
  }

  Future<List<VibeSong>> populateList() async {
    final db = await database;
    final List<Map<String, dynamic>> songs =
        await db.query(SongsDb.allSongsTable);
    List<VibeSong> vibeSongs = [];
    for (var song in songs) {
      List<VibeArtist> artistsList = []; // Initialize an empty list for artists
      List<VibeTag> tagsList = [VibeTag(name: "Unknown")];
      // Decode the artists' data from string format
      if (song['artists'] != null) {
        List<dynamic> artistsData = json.decode(song['artists']);
        for (var artistData in artistsData) {
          artistsList.add(
            VibeArtist(name: artistData['name']),
          );
        }
      }

      // Create VibeSong object with all retrieved data
      VibeSong vibeSong = VibeSong(
        artists: artistsList,
        genre: song['genre'],
        imageUrl: song['imageUrl'],
        name: song['name'],
        songUrl: song['songUrl'],
        tags: tagsList,
        url: song['url'],
      );
      vibeSongs.add(vibeSong);
    }
    return vibeSongs;
  }

  // Favourites Database Methods
  Future<void> addToFav(String musicSource, VibeSong song) async {
    final db = await database;
    await db.insert(
      SongsDb.favSongsTable,
      {
        ...song.toMap(),
        SongsDb.columnMusicSource: musicSource,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    log('Added ${song.name.toString()} to Favourites');
  }

  Future<void> removeFromFav(String musicSource, String songName) async {
    final db = await database;
    await db.delete(
      SongsDb.favSongsTable,
      where: '${SongsDb.columnName} = ? AND ${SongsDb.columnMusicSource} = ?',
      whereArgs: [songName, musicSource],
    );
    log('Removed $songName from Favourites');
  }

  Future<void> readFavouriteList() async {
    final db = await database;
    final List<Map<String, dynamic>> favoriteSongs =
        await db.query(SongsDb.favSongsTable);
    for (var song in favoriteSongs) {
      log('Favorite Song: $song');
    }
  }

  Future<List<VibeSong>> populateFavLists(String musicSource) async {
    final db = await database;
    final List<Map<String, dynamic>> songs =
        await db.query(SongsDb.favSongsTable);
    List<VibeSong> vibeSongs = [];

    List<VibeTag> tagsList = [VibeTag(name: "Unknown")];
    for (var song in songs) {
      String mSource = song['musicSource'];

      if (mSource == musicSource) {
        List<VibeArtist> artistsList = [];
        // if (mSource == MusicSource.localDirectory) {
        if (song['artists'] != null) {
          List<dynamic> artistsData = json.decode(song['artists']);
          for (var artistData in artistsData) {
            artistsList.add(
              VibeArtist(name: artistData['name']),
            );
          }
        }
        // }

        // Create VibeSong object with all retrieved data
        VibeSong vibeSong = VibeSong(
          artists: artistsList,
          genre: song['genre'],
          imageUrl: song['imageUrl'],
          name: song['name'],
          songUrl: song['songUrl'],
          tags: tagsList,
          url: song['url'],
        );
        vibeSongs.add(vibeSong);
      }
    }
    return vibeSongs;
  }

  Future<bool> checkIsAddedToFav(String songName) async {
    final db = await database;
    final List<Map<String, dynamic>> songs =
        await db.query(SongsDb.favSongsTable);

    for (var song in songs) {
      if (songName == song['name']) {
        return true;
      }
    }
    return false;
  }
}
