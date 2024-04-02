import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app_task/models/song_model.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({required Song song}) {
    selectedSong = song;
  }
  late Song selectedSong;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    setAudio(widget.selectedSong.url);
  }

  Future setAudio(String url) async {
    player.setReleaseMode(ReleaseMode.stop);
    String urlPlay = url;
    player.setSourceUrl(urlPlay);
    // final audio = AudioCache(prefix: 'assets/');
    // final url = await audio.load("song.mp3");
    // player.play(AssetSource('songs/song1.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              widget.selectedSong.image,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("SongName"),
          SizedBox(
            height: 20,
          ),
          Text("Artist"),
          Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: ((value) async {
                final position = Duration(seconds: value.toInt());
                await player.seek(position);
                await player.resume();
              })),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Duration(seconds: position.inSeconds)
                    .toString()
                    .split('.')
                    .first
                    .padLeft(8, "0")),
                Text(Duration(seconds: duration.inSeconds - position.inSeconds)
                    .toString()
                    .split('.')
                    .first
                    .padLeft(8, "0"))
              ],
            ),
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await player.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    await player.resume();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
          )
        ],
      ),
    );
  }
}
