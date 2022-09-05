import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../playlist.dart';

class MusicPlayer extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

int currentSong = 0;
Playlist playlist = Playlist();

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String src = playlist.getSrc(currentSong);
  String? title = playlist.getTitle(currentSong);
  String? artist = playlist.getArtist(currentSong);
  String? albumn = playlist.getAlbumn(currentSong);

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  play() {
    audioCache.play(src);
  }

  pause() {
    audioPlayer.pause();
  }

  next() {
    src = playlist.getSrc(currentSong);
    title = playlist.getTitle(currentSong);
    artist = playlist.getArtist(currentSong);
    albumn = playlist.getAlbumn(currentSong);
    if (currentSong == playlist.getLength() - 1) {
      currentSong = 0;
    } else {
      currentSong++;
    }
    play();
  }

  previous() {
    src = playlist.getSrc(currentSong);
    title = playlist.getTitle(currentSong);
    artist = playlist.getArtist(currentSong);
    albumn = playlist.getAlbumn(currentSong);
    if (currentSong == 0) {
      currentSong = playlist.getLength() - 1;
    } else {
      currentSong--;
    }
    play();
  }

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache.load(src);
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'images/$albumn',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              artist!,
              style: const TextStyle(fontSize: 18),
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatTime(position)),
                  Text(formatTime(duration)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          previous();
                        });
                      },
                      icon: const Icon(Icons.skip_previous_rounded),
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: IconButton(
                      onPressed: () {
                        if (isPlaying) {
                          setState(() {
                            pause();
                          });
                        } else {
                          setState(() {
                            play();
                          });
                        }
                      },
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          next();
                        });
                      },
                      icon: const Icon(Icons.skip_next_rounded),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
