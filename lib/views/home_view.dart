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
        metas: Metas(
          title: 'Music 1',
          artist: 'Artist 1',
          image: const MetasImage(
              path:
                  'https://miro.medium.com/v2/da:true/resize:fit:297/0*iX-M9wUvLgeQCsft',
              type: ImageType.network),
        ),
      ),
      Audio(
        "assets/sounds/2.mp3",
        metas: Metas(
          title: 'Music 2',
          artist: 'Artist 2',
          image: const MetasImage(
              path:
                  'https://cdn.pixabay.com/photo/2023/12/16/11/57/ai-generated-8452307_640.png',
              type: ImageType.network),
        ),
      ),
      Audio(
        "assets/sounds/3.mp3",
        metas: Metas(
          title: 'Music 3',
          artist: 'Artist 3',
          image: const MetasImage(
              path:
                  'https://th.bing.com/th/id/OIP.mdCu4HNCjrUy_L6ncV2RSQHaHa?rs=1&pid=ImgDetMain',
              type: ImageType.network),
        ),
      ),
      Audio(
        "assets/sounds/4.mp3",
        metas: Metas(
          title: 'Music 4',
          artist: 'Artist 4',
          image: const MetasImage(
              path:
                  'https://i1.sndcdn.com/avatars-cqXwXIxFY3lMVAYA-6JBPKw-t500x500.jpg',
              type: ImageType.network),
        ),
      ),
      Audio(
        "assets/sounds/5.mp3",
        metas: Metas(
          title: 'Music 5',
          artist: 'Artist 5',
          image: const MetasImage(
              path:
                  'https://yt3.ggpht.com/a/AATXAJwUMA9ikCxNMBZhei9jS5lfnNOZCK49CUn2YWFgeQ=s900-c-k-c0xffffffff-no-rj-mo',
              type: ImageType.network),
        ),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Music',
          style: TextStyle(color: Colors.red[100], fontWeight: FontWeight.w800),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlaylistView(
                          playlist: playListEx,
                        )));
              },
              icon: Icon(
                Icons.playlist_add_check_circle_sharp,
                color: Colors.blue[100],
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: AudioPlayer(
        playlist: playListEx,
      ),
    );
  }
}
