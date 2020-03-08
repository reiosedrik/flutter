import 'package:flutter/material.dart';
import 'package:workoutapp/style/styles.dart';

class RaisedIconButton {
  static Container onlyIcon(IconData icon, Function onPressed, {size: 50.0}) {
    return Container(
                width: size,
                height: size,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0)),
                  color: Colors.white,
                  child: Icon(
                    icon,
                    color: Styles.darkTextColor,
                    size: 30,
                  ),
                  onPressed: onPressed,
                ),
              );
  }
}