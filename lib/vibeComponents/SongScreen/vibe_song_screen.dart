import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:vibeforge/common/utils.dart';
import 'package:vibeforge/models/song_model.dart';
import 'package:vibeforge/vibeComponents/MusicPlayer/vibe_music_player.dart';
import 'package:vibeforge/widgets/widgets.dart';

class VibeSongScreen extends StatefulWidget {
  const VibeSongScreen({
    super.key,
    required this.song,
    required this.musicSource,
  });

  final VibeSong song;
  final String musicSource;

  @override
  State<VibeSongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<VibeSongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    List<AudioSource> audioInit = [];

    switch (widget.musicSource) {
      case MusicSource.localAssets:
        audioInit = [
          AudioSource.uri(
            Uri.parse('asset:///${widget.song.songUrl}'),
          ),
          AudioSource.uri(
            Uri.parse('asset:///${VibeSong.songs[1].url}'),
          ),
          AudioSource.uri(
            Uri.parse('asset:///${VibeSong.songs[2].url}'),
          ),
        ];
        break;
      default:
        audioInit = [
          AudioSource.uri(
            Uri.parse(widget.song.songUrl ?? ''),
          ),
        ];
        break;
    }

    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: audioInit,
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position: position,
          duration: duration ?? Duration.zero,
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // cover image
          _CoverImage(
            musicSource: widget.musicSource,
            image: widget.song.imageUrl ?? '',
          ),

          // fliter overlay
          _BackgroundFilter(
            musicSource: widget.musicSource,
          ),

          // music control bar
          VibeMusicPlayer(
            song: widget.song,
            seekBarDataStream: _seekBarDataStream,
            audioPlayer: audioPlayer,
            musicSource: widget.musicSource,
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  final String musicSource;

  const _BackgroundFilter({
    required this.musicSource,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> gradientColors;
    switch (musicSource) {
      case MusicSource.apiNCS || MusicSource.downloadedNCS:
        gradientColors = [
          Colors.grey.shade800,
          Colors.black,
        ];
        break;
      default:
        gradientColors = [
          Colors.deepPurple.shade500,
          Colors.black,
        ];
        break;
    }

    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(1.0),
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0.0),
          ],
          stops: const [
            0.0,
            0.4,
            0.6,
          ],
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  final String musicSource;
  final String image;

  const _CoverImage({
    required this.musicSource,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    Widget coverImage;

    switch (musicSource) {
      case MusicSource.apiNCS:
        coverImage = Image.network(
          image,
          fit: BoxFit.cover,
        );
        break;
      case MusicSource.localDirectory || MusicSource.downloadedNCS:
        coverImage = Image.memory(
          base64Decode(image.split(',').last),
          fit: BoxFit.cover,
        );
        break;
      case MusicSource.localAssets:
        coverImage = Image.asset(
          image,
          fit: BoxFit.cover,
        );
        break;
      default:
        coverImage = Image.asset(
          LocalAssets.appLogo,
          fit: BoxFit.cover,
        );
        break;
    }

    return coverImage;
  }
}
