import 'package:flutter/material.dart';
import 'package:workoutapp/components/exercise_preview.dart';
import 'package:workoutapp/helper/navigation_helper.dart';
import 'package:workoutapp/style/styles.dart';
import 'package:workoutapp/screens/active_session.dart';

class SessionPreview {
  ExercisePreview exercisePreview = new ExercisePreview();

  Container getInstance(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
        borderRadius: new BorderRadius.vertical(
            top: Radius.circular(Styles.topRadiusMain)),
      ),
    );
  }

  Row sessionPreviewHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Today's Session",
              style: Styles.titleDark(),
            )),
            Container(
              margin: EdgeInsets.only(right: 60),
              child: IconButton(
                padding: EdgeInsets.only(top: 13),
                icon: Icon(Icons.create),
                color: Styles.darkNeutral,
                onPressed: () {

                },
              ),
            ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 15,
              ),
              child: Icon(
                Icons.access_time,
                size: 22.0,
                color: Styles.subtitleColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 5, right: 10),
              child: Text("1 h 20 min", style: Styles.subTitle()),
            )
          ],
        )
      ],
    );
  }

  Container startWorkoutButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, right: 10.0),
      alignment: Alignment.bottomRight,
      child: RaisedButton(
          padding: EdgeInsets.all(15.0),
          color: Styles.darkTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100.0),
          ),
          child: Text("Start Workout", style: Styles.buttonTextLight()),
          onPressed: () {
            Navigator.pushNamed(context, Pages.activeSession);
            
          }),
    );
  }
}
