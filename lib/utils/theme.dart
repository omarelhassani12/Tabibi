import 'package:flutter/material.dart';

Color mainColor = const Color(0xFF87CEFA);

//const Color mainColor = Color(0xff87cefa);
const Color darkGreyClr = Color(0xFF121212);
const Color secondClr = Color(0xFFFFD1D2);
const Color greenClr = Color(0xFF98FF98);
const Color kCOlor1 = Color(0xff685959);
const Color kCOlor2 = Color(0xffADA79B);
const Color kCOlor3 = Color(0xffA5947F);
const Color kCOlor4 = Color(0xff738B71);
const Color kCOlor5 = Color(0xff6D454D);
const Color darkSettings = Color(0xff6132e4);
const Color accountSettings = Color(0xff73bc65);
const Color logOutSettings = Color(0xff5f95ef);
const Color notiSettings = Color(0xffdf5862);
const Color languageSettings = Color(0xffCB256C);

class ThemesApp {
  static final light = ThemeData(
    primaryColor: mainColor,
    //backgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    primaryColor: darkGreyClr,
    //backgroundColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
