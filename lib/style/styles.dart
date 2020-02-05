import 'package:flutter/material.dart';

class Styles {
  static Color primaryTextColor = Colors.grey[900];
  static Color secondaryTextColor = Colors.white10;
  static Color actionColor = Colors.grey[900];
  static Color bgGradient1 = Color.fromRGBO(44, 140, 153, 1);
  static Color bgGradient2 = Color.fromRGBO(66, 217, 200, 1);

  static Color darkTextColor = Color.fromRGBO(40, 70, 75, 1);
  static Color accentColor = Color.fromRGBO(147, 22, 33, 1);
  static Color neutral = Color.fromRGBO(50, 103, 113, 1);
  
  
    static ThemeData primaryTheme() {
      return ThemeData(
        brightness: Brightness.light,
        // primaryColor: Colors.grey[900],
        primaryColor: darkTextColor,
        // accentColor: Colors.orange[900],
        accentColor: accentColor,
        buttonColor: Colors.orange[700],
        // scaffoldBackgroundColor: ,
  
        // fontFamily: 'Playfair',
  
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold, color: darkTextColor),
          title: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: darkTextColor),
          body1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: darkTextColor),
          display1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          display2: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
          display3: TextStyle(fontSize: 14.0, color: darkTextColor),
          display4: TextStyle(fontSize: 14.0, color: Colors.white),
  
          )
        );
    }
  }
  