import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/widgets/audio_player.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AudioPlayer(
        playlist: Playlist(
          audios: [
            Audio(
              "assets/sounds/1.mp3",
              metas: Metas(title: 'Song 1'),
            ),
            Audio(
              "assets/sounds/2.mp3",
              metas: Metas(title: 'Song 2'),
            ),
            Audio(
              "assets/sounds/3.mp3",
              metas: Metas(title: 'Song 3'),
            ),
            Audio(
              "assets/sounds/4.mp3",
              metas: Metas(title: 'Song 4'),
            ),
            Audio(
              "assets/sounds/5.mp3",
              metas: Metas(title: 'Song 5'),
            ),
          ],
        ),
      ),
    );
  }
}
