import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music_app_task/constants/designConstants.dart';
import 'package:music_app_task/constants/songsList.dart';
import 'package:music_app_task/models/song_model.dart';
import 'package:music_app_task/services/authHelper.dart';
import 'package:music_app_task/widgets/songTile.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.result});
  final String result;
  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Song> songs = SongsList().songs;
  AuthenticationHelper auth = AuthenticationHelper();
  DesignConstants design = DesignConstants();
  bool _liked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Playlist',
            style: design.listScreenAppBarStyle,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.popAndPushNamed(context, '/');
                },
                icon: Icon(Icons.logout_outlined))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return SongTile(
                  userId: widget.result,
                  songs: songs,
                  design: design,
                  liked: _liked,
                  index: index,
                );
              },
            ),
          ),
        ));
  }
}
