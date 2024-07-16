import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AudioPlayer extends StatefulWidget {
  final Playlist playlist;
  const AudioPlayer({
    required this.playlist,
    super.key,
  });

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int currentValue = 0;
  double volumeValue = 1.0;
  double speedValue = 1.0;
  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() async {
    assetsAudioPlayer.playSpeed.listen((event) => speedValue = event);
    assetsAudioPlayer.volume.listen((event) => volumeValue = event);
    assetsAudioPlayer.currentPosition
        .listen((event) => currentValue = event.inSeconds);
    await assetsAudioPlayer.open(
      // volume: volumeValue,
      // playSpeed: speedValue,
      autoStart: false,
      loopMode: LoopMode.playlist,
      widget.playlist,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 600,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: StreamBuilder(
                  stream: assetsAudioPlayer.realtimePlayingInfos,
                  builder: (context, snapShots) {
                    if (snapShots.connectionState == ConnectionState.waiting) {
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
                            fontWeight: FontWeight.w800,
                            title: assetsAudioPlayer.getCurrentAudioTitle == ''
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
                                  onPressed: snapShots.data?.current?.index == 0
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
                                            (assetsAudioPlayer.playlist?.audios
                                                        .length ??
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
                          Column(
                            children: [
                              const CustomText(
                                title: 'Volume',
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SegmentedButton(
                                      onSelectionChanged: (values) {
                                        volumeValue = values.first.toDouble();
                                        assetsAudioPlayer
                                            .setVolume(volumeValue);
                                        setState(() {});
                                      },
                                      segments: const [
                                        ButtonSegment(
                                          icon: Icon(Icons.volume_up),
                                          value: 1,
                                        ),
                                        ButtonSegment(
                                          icon: Icon(Icons.volume_down),
                                          value: 0.5,
                                        ),
                                        ButtonSegment(
                                          icon: Icon(Icons.volume_mute),
                                          value: 0,
                                        ),
                                      ],
                                      selected: {
                                        volumeValue,
                                      }),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const CustomText(
                                title: 'Speed',
                                fontWeight: FontWeight.w400,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SegmentedButton(
                                      onSelectionChanged: (values) {
                                        speedValue = values.first.toDouble();
                                        assetsAudioPlayer
                                            .setPlaySpeed(speedValue);
                                        setState(() {});
                                      },
                                      segments: const [
                                        ButtonSegment(
                                          icon: Text('1x'),
                                          value: 1,
                                        ),
                                        ButtonSegment(
                                          icon: Text('2x'),
                                          value: 8,
                                        ),
                                        ButtonSegment(
                                          icon: Text('3x'),
                                          value: 10,
                                        ),
                                        ButtonSegment(
                                          icon: Text('4x'),
                                          value: 16,
                                        ),
                                      ],
                                      selected: {
                                        speedValue,
                                      }),
                                ],
                              ),
                            ],
                          ),
                          Slider(
                            value: currentValue.toDouble(),
                            min: 0,
                            max:
                                snapShots.data?.duration.inSeconds.toDouble() ??
                                    0.0,
                            onChanged: (value) {
                              setState(() {
                                currentValue = value.toInt();
                              });
                            },
                            onChangeEnd: (value) {
                              assetsAudioPlayer
                                  .seek(Duration(seconds: value.toInt()));
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          CustomText(
                            fontWeight: FontWeight.w400,
                            title:
                                '${convertSeconds(currentValue)} / ${convertSeconds(snapShots.data?.duration.inSeconds ?? 0)}',
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
    );
  }

  PlayerBuilder builderIsPlaying() {
    return assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
      return FloatingActionButton.large(
        onPressed: () {
          isPlaying ? assetsAudioPlayer.pause() : assetsAudioPlayer.play();
          setState(() {});
        },
        shape: const CircleBorder(),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
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
