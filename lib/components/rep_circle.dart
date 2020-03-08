import 'package:flutter/material.dart';
import 'package:workoutapp/style/styles.dart';

class RepCircle {
  static Container get(int nr) {
    return Container(
              margin: EdgeInsets.only(left: 8),
              padding: EdgeInsets.only(left: 5.5, top: 0.5),
              height: 21,
              width: 21,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Styles.subtitleColor)),
              child: Text(
                nr.toString(),
                style: Styles.textSmallDark()
                    .copyWith(fontWeight: FontWeight.bold),
              ));
  }
}