import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/views/playlist_view.dart';
import 'package:audios_player/widgets/audio_player.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var playListEx = Playlist(
    audios: [
      Audio(
        "assets/sounds/1.mp3",
        metas: Metas(title: 'Song 1',artist: 'Artist1'),
      ),
      Audio(
        "assets/sounds/2.mp3",
        metas: Metas(title: 'Song 2',artist: 'Artist1'),
      ),
      Audio(
        "assets/sounds/3.mp3",
        metas: Metas(title: 'Song 3',artist: 'Artist1'),
      ),
      Audio(
        "assets/sounds/4.mp3",
        metas: Metas(title: 'Song 4',artist: 'Artist1'),
      ),
      Audio(
        "assets/sounds/5.mp3",
        metas: Metas(title: 'Song 5',artist: 'Artist1'),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PlaylistView(playlist: playListEx,)));
              },
              icon: Icon(Icons.playlist_add_check_circle_sharp),
          ),
        ],
      ),
      body: AudioPlayer(
        playlist: playListEx,
      ),
    );
  }
}
