import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/widgets/custom_text.dart';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() async {
    await assetsAudioPlayer.open(
      autoStart: false,
      loopMode: LoopMode.playlist,
      Playlist(
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
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.purple[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: StreamBuilder(
                    stream: assetsAudioPlayer.realtimePlayingInfos,
                    builder: (context, snapShots) {
                      if (snapShots.connectionState ==
                          ConnectionState.waiting) {
                        const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              title:   assetsAudioPlayer.getCurrentAudioTitle == ''
                                  ? 'Please Play Your Songs'
                                  : assetsAudioPlayer.getCurrentAudioTitle,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed:
                                        snapShots.data?.current?.index == 0
                                            ? null
                                            : () {
                                                assetsAudioPlayer.previous();
                                              },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      color: snapShots.data?.current?.index == 0
                                          ? Colors.grey
                                          : Colors.purple[100],
                                    )),
                                builderIsPlaying(),
                                IconButton(
                                    onPressed: snapShots.data?.current?.index ==
                                            (assetsAudioPlayer.playlist?.audios
                                                        .length ??
                                                    0) -
                                                1
                                        ? null
                                        : () {
                                            assetsAudioPlayer.next();
                                          },
                                    icon: Icon(
                                      Icons.skip_next,
                                      color: snapShots.data?.current?.index ==
                                              (assetsAudioPlayer.playlist
                                                          ?.audios.length ??
                                                      0) -
                                                  1
                                          ? Colors.grey
                                          : Colors.purple[200],
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Slider(
                              value: snapShots.data?.currentPosition.inSeconds
                                      .toDouble() ??
                                  0.0,
                              min: 0,
                              max: snapShots.data?.duration.inSeconds
                                      .toDouble() ??
                                  0.0,
                              onChanged: (value) {
                                assetsAudioPlayer
                                    .seek(Duration(seconds: value.toInt()));
                                // work on physical device but web does not.
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CustomText(
                                title:  '${convertSeconds(snapShots.data?.currentPosition.inSeconds ?? 0)} / ${convertSeconds(snapShots.data?.duration.inSeconds ?? 0)}',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PlayerBuilder builderIsPlaying() {
    return assetsAudioPlayer.builderIsPlaying(
                                  builder: (context, isPlaying) {
                                return FloatingActionButton.large(
                                  onPressed: () {
                                    isPlaying
                                        ? assetsAudioPlayer.pause()
                                        : assetsAudioPlayer.play();
                                    setState(() {});
                                  },
                                  shape: const CircleBorder(),
                                  child: Icon(
                                    isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                );
                              });
  }

  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsTimer = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsTimer.padLeft(2, '0')}';
  }
}


