import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audios_player/widgets/custom_segment_button.dart';
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
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
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
                          const SizedBox(
                            height: 10,
                          ),
                          buildImageCard(),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            assetsAudioPlayer.getCurrentAudioTitle == ''
                                ? 'Please Play Your Songs'
                                : assetsAudioPlayer.getCurrentAudioTitle,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                        : Colors.red[200],
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
                                        : Colors.red[200],
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          buildSlider(snapShots),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Volume',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  CustomSegmentButton(
                                    onSelectionChanged: volumeOnChanced,
                                    selected: {volumeValue},
                                    segments: const [
                                      ButtonSegment(
                                        icon: Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                        ),
                                        value: 1,
                                      ),
                                      ButtonSegment(
                                        icon: Icon(
                                          Icons.volume_down,
                                          color: Colors.white,
                                        ),
                                        value: 0.5,
                                      ),
                                      ButtonSegment(
                                        icon: Icon(
                                          Icons.volume_mute,
                                          color: Colors.white,
                                        ),
                                        value: 0,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Speed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: CustomSegmentButton(
                                      onSelectionChanged: speedOnChange,
                                      selected: {
                                        speedValue,
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
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${convertSeconds(currentValue)} / ${convertSeconds(snapShots.data?.duration.inSeconds ?? 0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void speedOnChange(values) {
    speedValue = values.first.toDouble();
    assetsAudioPlayer.setPlaySpeed(speedValue);
    setState(() {});
  }

  void volumeOnChanced(values) {
    volumeValue = values.first.toDouble();
    assetsAudioPlayer.setVolume(volumeValue);
    setState(() {});
  }

  Slider buildSlider(AsyncSnapshot<RealtimePlayingInfos> snapShots) {
    return Slider(
      thumbColor: Colors.red[100],
      activeColor: const Color(0xffE3ebf6),
      value: currentValue.toDouble(),
      min: 0,
      max: snapShots.data?.duration.inSeconds.toDouble() ?? 0.0,
      onChanged: (value) {
        setState(() {
          currentValue = value.toInt();
        });
      },
      onChangeEnd: (value) {
        assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
      },
    );
  }

  Card buildImageCard() {
    return Card(
      shape: Border.all(color: Colors.red.shade100),
      child: Image.network(
        assetsAudioPlayer.getCurrentAudioImage?.path ??
            'https://yt3.ggpht.com/a/AATXAJwUMA9ikCxNMBZhei9jS5lfnNOZCK49CUn2YWFgeQ=s900-c-k-c0xffffffff-no-rj-mo',
        width: 180,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }

  PlayerBuilder builderIsPlaying() {
    return assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
      return FloatingActionButton(
        backgroundColor: isPlaying ? const Color(0xffE3ebf6) : Colors.red[100],
        onPressed: () {
          isPlaying ? assetsAudioPlayer.pause() : assetsAudioPlayer.play();
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

  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsTimer = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsTimer.padLeft(2, '0')}';
  }
}
