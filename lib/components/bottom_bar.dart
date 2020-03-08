import 'package:flutter/material.dart';
import 'package:workoutapp/helper/navigation_helper.dart';
import 'package:workoutapp/style/styles.dart';

class BottomBar extends BottomAppBar {

  static String active = Pages.home;

  static BottomAppBar getInstance(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            bottomNavButton(context, Icons.home, "Home", Pages.home),
            bottomNavButton(context, Icons.date_range, "Calendar", Pages.calendar),
            bottomNavButton(context, Icons.assessment, "Progress", Pages.progress),
            bottomNavButton(context, Icons.account_circle, "Profile", Pages.profile),
          ],
        ),
      );
  }

  static GestureDetector bottomNavButton(BuildContext context, IconData icon, String text, String page) {
    var padding = 2.0;
    var isCurrentPage = active == page; // TODO make it actually work

    return GestureDetector(
      onTap: () {
        active = page;
        Navigator.pop(context);
        Navigator.pushNamed(context, page);
      },
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: padding),
          child: Icon(icon, size: 28.0, color: isCurrentPage ? Styles.subtitleColor: Styles.darkTextColor,),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.normal,
              color: isCurrentPage ? Styles.subtitleColor : Styles.darkTextColor
            ),
          ),
        ),
      ],
    ),
    );
  }
}