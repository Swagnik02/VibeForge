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
