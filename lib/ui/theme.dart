import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bgColor = Color.fromRGBO(78, 125, 150, 1);
const Color pageColor = Color.fromRGBO(159, 201, 221, 1);
const Color listBgColor = Color.fromRGBO(227, 237, 242, 1);
const Color buttonColor = Color.fromRGBO(255, 132, 75, 1);
const Color textColor = Color.fromRGBO(10, 13, 37, 1);

class Themes {
  static final light = ThemeData(
      primaryColor: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(color: Colors.blue));
  static final dark = ThemeData(
      primaryColor: Colors.grey,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(color: Colors.grey));
}

class Styles {
  static const textStyle_1 =
      TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w500);
  static const textStyle_2 =
      TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.w500);
  static const textStyle_3 =
      TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500);
}

TextStyle get textStyle1 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        color: textColor, fontSize: 20, fontWeight: FontWeight.w600),
  );
}

TextStyle get textStyle2 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        color: textColor, fontSize: 18, fontWeight: FontWeight.w500),
  );
}

TextStyle get textStyle3 {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
  );
}
