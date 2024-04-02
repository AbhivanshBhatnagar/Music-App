import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_task/constants/songsList.dart';
import 'package:music_app_task/models/song_model.dart';
import 'package:music_app_task/screens/detailsScreen.dart';
import 'package:music_app_task/services/authHelper.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<Song> songs = SongsList().songs;
  AuthenticationHelper auth = AuthenticationHelper();
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
            style: GoogleFonts.poppins(fontSize: 25, color: Colors.white70),
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
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.fill),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return DetailsScreen(
                            song: songs[index],
                            tag: index,
                          );
                        },
                      ));
                    },
                    title: Text(
                      songs[index].title,
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: Colors.white70),
                    ),
                    subtitle: Text(
                      songs[index].artist,
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white60),
                    ),
                    leading: Hero(
                        tag: index, child: Image.asset(songs[index].image)),
                    trailing: IconButton(
                        onPressed: () {
                          _liked = !_liked;
                          setState(() {});
                        },
                        icon: _liked
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border)),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
