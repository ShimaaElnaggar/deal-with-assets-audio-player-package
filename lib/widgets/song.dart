import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class Song extends StatefulWidget {
  final Audio audio;

  const Song({required this.audio, super.key});

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color(0xffE3ebf6),
        child: ListTile(
          trailing: builderIsPlaying(),
          leading: Card(
            shape: Border.all(color: Colors.red.shade100),
            borderOnForeground: true,
            child: Image.network(
              widget.audio.metas.image?.path ??
                  'https://yt3.ggpht.com/a/AATXAJwUMA9ikCxNMBZhei9jS5lfnNOZCK49CUn2YWFgeQ=s900-c-k-c0xffffffff-no-rj-mo',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            widget.audio.metas.title ?? 'No Title',
          ),
          subtitle: Row(
            children: [
              Text(
                widget.audio.metas.artist ?? 'No Artist',
                style: TextStyle(color: Colors.blue[200]),
              ),
              const Text('  |  '),
              const SizedBox(
                width: 5,
              ),
              getMuiscLength(),
            ],
          ),
        ),
      ),
    );
  }

  StreamBuilder<RealtimePlayingInfos> getMuiscLength() {
    return StreamBuilder(
      stream: assetsAudioPlayer.realtimePlayingInfos,
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshots.data == null) {
          return const SizedBox.shrink();
        }
        return Text(
          convertSeconds(snapshots.data?.duration.inSeconds ?? 0),
          style: TextStyle(color: Colors.blue[200]),
        );
      },
    );
  }

  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsTimer = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsTimer.padLeft(2, '0')}';
  }

  PlayerBuilder builderIsPlaying() {
    return assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
      return FloatingActionButton.small(
        backgroundColor: isPlaying ? const Color(0xffE3ebf6) : Colors.red[100],
        onPressed: () {
          if (isPlaying) {
            assetsAudioPlayer.pause();
          } else {
            assetsAudioPlayer.play();
          }
          setState(() {});
        },
        shape: const CircleBorder(),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 30,
          color: Colors.white,
        ),
      );
    });
  }
}
