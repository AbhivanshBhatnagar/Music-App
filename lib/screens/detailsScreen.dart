import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_task/models/song_model.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({required Song song, required this.tag}) {
    selectedSong = song;
  }
  late final Song selectedSong;
  late final int tag;
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
    player.play(UrlSource(urlPlay));

    // final audio = AudioCache(prefix: 'assets/');
    // final url = await audio.load("song.mp3");
    // player.play(AssetSource('songs/song1.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Music Player',
          style: GoogleFonts.poppins(color: Colors.white70),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.selectedSong.image),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: widget.tag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.selectedSong.image,
                      height: 250,
                      width: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.selectedSong.title,
                          style: GoogleFonts.poppins(
                              fontSize: 25, color: Colors.white70),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.selectedSong.artist,
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Slider(
                  activeColor: Colors.grey[700],
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: ((value) async {
                    final position = Duration(seconds: value.toInt());
                    await player.seek(position);
                    await player.resume();
                  })),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Duration(seconds: position.inSeconds)
                            .toString()
                            .split('.')
                            .first
                            .substring(3)
                            .padLeft(5, "0"),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white70)),
                    Text(
                        Duration(
                                seconds:
                                    duration.inSeconds - position.inSeconds)
                            .toString()
                            .split('.')
                            .first
                            .substring(3)
                            .padLeft(5, "0"),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, color: Colors.white70))
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.white70,
                radius: 35,
                child: IconButton(
                    color: Colors.grey[700],
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
        ),
      ),
    );
  }
}
