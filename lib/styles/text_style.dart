import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  var name = TextStyle(
    fontWeight: FontWeight.bold
  );

  var primaryFontFamily = GoogleFonts.kanit().fontFamily;
  var secondaryFontFamily = GoogleFonts.signika().fontFamily;
  
  double defaultFontSize = 16.0;
  double primaryFontSize = 18.0;
  double secondaryFontSize = 20.0;
}