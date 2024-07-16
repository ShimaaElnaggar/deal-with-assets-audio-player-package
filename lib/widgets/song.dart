
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';


class Song extends StatefulWidget {
  final Audio audio;
  const Song({required this.audio,super.key});

  @override
  State<Song> createState() => _SongState();
}

class _SongState extends State<Song> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
   assetsAudioPlayer.open(
     autoStart: false,
     widget.audio,
   );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: StreamBuilder(
        stream: assetsAudioPlayer.realtimePlayingInfos,
        builder: ( context,snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshots.data == null){
            return const SizedBox.shrink();
          }
          return Text(convertSeconds(snapshots.data?.duration.inSeconds??0));
        },
      ),
      leading: CircleAvatar(
        child: Text(
          "${widget.audio.metas.artist?.split(' ').first[0].toUpperCase()}${widget.audio.metas.artist?.split(' ').last[0].toUpperCase()}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      title: Text(widget.audio.metas.title ?? 'No Title'),
      subtitle: Text(widget.audio.metas.artist ?? 'No Artist'),
    );
  }
  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsTimer = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsTimer.padLeft(2, '0')}';
  }
}
