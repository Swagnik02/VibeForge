// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart' as rxdart;

// class VibeSongScreenController extends GetxController {
//   AudioPlayer audioPlayer = AudioPlayer();
//   @override
//   void onInit() {
//     super.onInit();

//     audioPlayer.setAudioSource(
//       ConcatenatingAudioSource(
//         children: [
//           AudioSource.uri(
//             Uri.parse(song.songUrl ?? ''),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }




  
//   Stream<SeekBarData> get _seekBarDataStream =>
//       rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
//           audioPlayer.positionStream, audioPlayer.durationStream, (
//         Duration position,
//         Duration? duration,
//       ) {
//         return SeekBarData(
//           position: position,
//           duration: duration ?? Duration.zero,
//         );
//       });

// }
