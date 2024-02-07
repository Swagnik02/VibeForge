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

  VibeSong song = VibeSong(
    name: metadata.title ?? '',
    songUrl: filePath,
    imageUrl: imageBytes != null
        ? 'data:$mimeType;base64,${base64Encode(imageBytes)}'
        : '',
  );

  return song;
}
