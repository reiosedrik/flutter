import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // static Color darkTextColor = Color.fromRGBO(40, 70, 75, 1); //dark green
  static Color darkTextColor = Color.fromRGBO(20, 27, 31, 1); // close to black dark grey
  static Color darkNeutral = Color.fromRGBO(56, 57, 59, 1); //dark grey

  static Color lightTextColor = Colors.white;

  static Color accentColor = Color.fromRGBO(147, 22, 33, 1); //red
  // static Color accentColor = Color.fromRGBO(19, 7, 237, 1); // dark blue
  static Color lightAccentColor = Color.fromRGBO(151, 211, 222, 0.1); 

  static Color neutral = Color.fromRGBO(50, 103, 113, 1);

  // static Color subtitleColor = Color.fromRGBO(169, 197, 201, 1); //light bland grey
  static Color subtitleColor = Color.fromRGBO(28, 164, 255, 1); // blue

  static ThemeData primaryTheme() {
    return ThemeData(
      // backgroundColor: lightAccentColor,
      brightness: Brightness.light,
      primaryColor: darkTextColor,
      accentColor: accentColor,
      buttonColor: Colors.orange[700],
      textTheme: GoogleFonts.latoTextTheme(
        
      ),
    );
  }

  static TextStyle subTitle() {
    return TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: subtitleColor);
  }

  static TextStyle subTitleMedium() {
    return TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: subtitleColor);
  }

  static TextStyle subTitleMediumDark() {
    return TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: darkTextColor);
  }

  static TextStyle subTitleLarge() {
    return TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: subtitleColor);
  }

  static TextStyle subTitleLight() {
    return TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white);
  }

  static TextStyle titleDarkLarge() {
    return TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, color: darkTextColor);
  }

  static TextStyle titleLightLarge() {
    return TextStyle(
        fontSize: 72.0, fontWeight: FontWeight.bold, color: darkTextColor);
  }

  static TextStyle titleLight() {
    return TextStyle(
        fontSize: 26.0, fontWeight: FontWeight.normal, color: lightTextColor);
  }

  static TextStyle titleDark() {
    return TextStyle(
        fontSize: 26.0, fontWeight: FontWeight.bold, color: darkTextColor);
  }

  static TextStyle titleDarkSmall() {
    return TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.bold, color: darkTextColor);
  }

  static TextStyle buttonTextLight() {
    return TextStyle(
        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle buttonTextDark() {
    return TextStyle(
        fontSize: 16.0, color: darkTextColor, fontWeight: FontWeight.bold);
  }

  static TextStyle buttonTextLightLarge() {
    return TextStyle(
        fontSize: 26.0, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle textSmallDark() {
    return TextStyle(
        fontSize: 14.0, color: darkTextColor, fontWeight: FontWeight.normal);
  }

  static TextStyle textSmallLight() {
    return TextStyle(
        fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.normal);
  }

  static TextStyle textMediumLight() {
    return TextStyle(
        fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.normal);
  }

  // static TextStyle fontPrimary(TextStyle style) {
  //   return GoogleFonts.lato(textStyle: style);
  // }

  static double topRadiusMain = 24.0;
}
