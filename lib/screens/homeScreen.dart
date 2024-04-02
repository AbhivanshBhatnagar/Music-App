import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index].title),
            subtitle: Text(songs[index].artist),
            leading: CircleAvatar(
              maxRadius: 30,
              backgroundImage: AssetImage(songs[index].image),
            ),
            trailing: IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DetailsScreen(song: songs[index]);
                },
              ));
            },
          );
        },
      ),
    );
  }
}
