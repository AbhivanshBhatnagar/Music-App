import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:music_app_task/constants/designConstants.dart';
import 'package:music_app_task/models/song_model.dart';
import 'package:music_app_task/screens/detailsScreen.dart';

class SongTile extends StatefulWidget {
  SongTile({
    super.key,
    required this.userId,
    required this.songs,
    required this.design,
    required bool liked,
    required this.index,
  }) : _liked = liked;
  final String userId;
  final List<Song> songs;
  final DesignConstants design;
  bool _liked;
  final int index;

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.ref("likedSongs");

  @override
  Widget build(BuildContext context) {
    bool liked = widget._liked;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                song: widget.songs[widget.index],
                tag: widget.index,
              );
            },
          ));
        },
        title: Text(
          widget.songs[widget.index].title,
          style: widget.design.listScreenTitleStyle,
        ),
        subtitle: Text(
          widget.songs[widget.index].artist,
          style: widget.design.listScreenArtistStyle,
        ),
        leading: Hero(
            tag: widget.index,
            child: Image.asset(widget.songs[widget.index].image)),
        trailing: IconButton(
          onPressed: () {
            Map<int, bool> Songs = {};
            Songs.addEntries(widget.songs.asMap().entries.map((e) {
              return MapEntry(e.key, widget._liked);
            }));
            Songs.addEntries({widget.index: !widget._liked}.entries);
            // likedSongs[widget.index] = widget._liked;
            log(Songs.toString());
            databaseReference.child(widget.userId).set({'liked': Songs});

            widget._liked = !widget._liked;
            setState(() {
              liked = widget._liked;
            });
            log(widget.userId);
            log(widget._liked.toString());
            log(widget.index.toString());
          },
          icon: widget._liked
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}
// onPressed: () {
//               log(userId);
//               databaseReference.child(userId).set({
//                 'liked': {index: _liked},
//               });
//               _liked = !_liked;
//             },
//             icon: _liked
//                 ? const Icon(Icons.favorite)
//                 : const Icon(Icons.favorite_border)