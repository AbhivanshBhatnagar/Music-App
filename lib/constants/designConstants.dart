import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app_task/screens/detailsScreen.dart';

class DesignConstants {
  Color gradientColor1 = Color(0xFF5B066D);
  Color gradientColor2 = Color(0xff69042c);
  InputDecoration emailDecor = InputDecoration(
    prefixIcon: const Icon(
      Icons.person,
    ),
    hintText: 'Email',
    hintStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    ),
  );
  InputDecoration passwordDecor = InputDecoration(
    prefixIcon: const Icon(Icons.lock),
    hintText: 'Password',
    hintStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
    filled: true,
    fillColor: Colors.grey[300],
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24),
    ),
  );
  TextStyle listScreenTitleStyle =
      GoogleFonts.poppins(fontSize: 20, color: Colors.white70);
  TextStyle listScreenArtistStyle =
      GoogleFonts.poppins(fontSize: 15, color: Colors.white60);
  TextStyle listScreenAppBarStyle =
      GoogleFonts.poppins(fontSize: 25, color: Colors.white70);
  TextStyle detailsScreenAppBarStyle =
      GoogleFonts.poppins(color: Colors.white70);
  TextStyle detailsScreenTitleStyle =
      GoogleFonts.poppins(fontSize: 25, color: Colors.white70);
  TextStyle detailsScreenArtistStyle =
      GoogleFonts.poppins(fontSize: 20, color: Colors.white70);
  TextStyle detailsScreenPositionStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white70);
  TextStyle detailsScreenDurationStyle =
      GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white70);
}
