import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/widgets/song.dart';
import 'package:flutter/material.dart';

class PlaylistView extends StatefulWidget {
  final Playlist playlist;
  const PlaylistView({required this.playlist, super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayList'),
      ),
      body: ListView(
        children: [
          for (var song in widget.playlist.audios)
           Song(audio: song),
        ],
      ),
    );
  }
}
