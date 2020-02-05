import 'package:flutter/material.dart';

class BottomBar extends BottomAppBar {

  static BottomAppBar getInstance() {
    return BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            bottomNavButton(Icons.home, "Home"),
            bottomNavButton(Icons.date_range, "Calendar"),
            bottomNavButton(Icons.history, "History"),
            bottomNavButton(Icons.account_circle, "Profile"),
          ],
        ),
      );
  }

  static Column bottomNavButton(IconData icon, String text) {
    var padding = 12.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: padding),
          child: Icon(icon, size: 36.0),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.0,
            ),
          ),
        ),
      ],
    );
  }
}