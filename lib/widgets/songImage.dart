import 'package:flutter/material.dart';
import 'package:music_app_task/screens/detailsScreen.dart';

class SongImage extends StatelessWidget {
  const SongImage({
    super.key,
    required this.widget,
  });

  final DetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        widget.selectedSong.image,
        height: 250,
        width: 250,
        fit: BoxFit.contain,
      ),
    );
  }
}
