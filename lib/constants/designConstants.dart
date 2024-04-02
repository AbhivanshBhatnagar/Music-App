import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignConstants {
  Color gradientColor1 = Color(0xff5b066d);
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
}
