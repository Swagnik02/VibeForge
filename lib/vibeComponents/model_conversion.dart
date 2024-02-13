import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:metadata_god/metadata_god.dart';
import 'package:ncs_io/ncs_io.dart' as NCSDev;
import 'package:vibeforge/models/song_model.dart';

VibeSong convertToVibeSong(NCSDev.Song? ncsSong) {
  return VibeSong(
    name: ncsSong?.name ?? "Unknown",
    genre: ncsSong?.genre ?? "Unknown",
    artists: ncsSong?.artists
        ?.map((artist) => VibeArtist(
              name: artist.name ?? "Unknown",
              url: artist.url,
              img: artist.img,
              genres: artist.genres,
            ))
        .toList(),
    url: ncsSong?.url,
    imageUrl: ncsSong?.imageUrl,
    songUrl: ncsSong?.songUrl,
    tags: ncsSong?.tags
        ?.map((tag) => VibeTag(
              name: tag.name ?? "Unknown",
              mood: tag.mood,
              genre: tag.genre,
            ))
        .toList(),
  );
}

Future<VibeSong> createVibeSongFromMetadata(String filePath) async {
  Metadata metadata = await MetadataGod.readMetadata(file: filePath);

  log(metadata.title ?? '');

  Uint8List? imageBytes;
  String? mimeType;

  if (metadata.picture != null) {
    imageBytes = metadata.picture!.data;
    mimeType = metadata.picture!.mimeType;
  }

  // Extract artists' names from the metadata and split them based on presence of , or /
  List<String> artistNames = [];
  if (metadata.artist != null) {
    if (metadata.artist!.contains(',')) {
      artistNames.addAll(metadata.artist!.split(','));
    } else if (metadata.artist!.contains('/')) {
      artistNames.addAll(metadata.artist!.split('/'));
    } else {
      artistNames.add(metadata.artist!);
    }
  }

  // Trim and remove empty artist names
  artistNames = artistNames
      .map((artistName) => artistName.trim())
      .where((artistName) => artistName.isNotEmpty)
      .toList();

  // Create VibeArtist objects for each artist name
  List<VibeArtist> artists = artistNames
      .map((artistName) => VibeArtist(
            name: artistName,
          ))
      .toList();

  // Create the VibeSong object including the extracted artist information
  VibeSong song = VibeSong(
    name: metadata.title ?? '',
    songUrl: filePath,
    imageUrl: imageBytes != null
        ? 'data:$mimeType;base64,${base64Encode(imageBytes)}'
        : '',
    artists: artists,
  );

  return song;
}
