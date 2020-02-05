import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello/components/exercise_preview.dart';
import 'package:hello/components/text_helper.dart';
import 'package:hello/style/styles.dart';

class SessionPreview {
  ExercisePreview exercisePreview = new ExercisePreview();

  Container getInstance(BuildContext context) {
    return Container(
      height: 560,
      width: MediaQuery.of(context).size.width,
      // margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          sessionPreviewHeader(context),
          exercisePreview.single(context),
          startWorkoutButton(context),
        ],
      ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  Container sessionPreviewHeader(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10),
        child: Text(
          "Today's Session (1 h 20 min)",
          style: Theme.of(context).textTheme.title,
        ));
  }

  Container startWorkoutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0),
      alignment: Alignment.bottomRight,
      child: FlatButton(
        padding: EdgeInsets.all(15.0),
        color: Styles.accentColor,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(25.0),
          ),
          child: Text("Begin Workout",
              style: Theme.of(context).textTheme.display2),
          onPressed: () {}),
    );
  }
}
