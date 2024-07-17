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
        title: Center(
          child: Text(
            'PlayList',
            style: TextStyle(color: Colors.red[100],fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              const Color(0xffE3ebf6),
              Colors.red.shade100,
              const Color(0xffd3d9e1),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            for (var song in widget.playlist.audios) Song(audio: song),
          ],
        ),
      ),
    );
  }
}
