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
      onCreate: (db, version) {
        return db.execute(
          '''
            CREATE TABLE IF NOT EXISTS ${SongsDb.tableName} (
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
      },
    );
  }

  Future<void> insertSong(VibeSong song) async {
    final db = await database;
    await db.insert(
      SongsDb.tableName,
      song.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<VibeSong>> getSongs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(SongsDb.tableName);
    return List.generate(maps.length, (i) {
      return VibeSong.fromMap(maps[i]);
    });
  }

  Future<void> deleteSong(int id) async {
    final db = await database;
    await db.delete(
      SongsDb.tableName,
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
    final List<Map<String, dynamic>> songs = await db.query(SongsDb.tableName);
    for (var song in songs) {
      log('Song: $song');
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(SongsDb.tableName);
    log('Database cleared');
  }

  Future<List<VibeSong>> populateList() async {
    final db = await database;
    final List<Map<String, dynamic>> songs = await db.query(SongsDb.tableName);
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
}




// [log] Song: {id: 17, name: ALL ABOUT YOU, genre: null, artists: [{"name":"Enrique Iglesias","url":null,"img":null,"genres":null}], 
// url: null, imageUrl: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEBLAEsAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFB, songUrl: /storage/emulated/0/Download/Ss/[SPOTIFY-DOWNLOADER.COM] ALL ABOUT YOU.mp3, tags: null}
