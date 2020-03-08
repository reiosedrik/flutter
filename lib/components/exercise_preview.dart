import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workoutapp/components/rep_circle.dart';
import 'package:workoutapp/models/exercise_model.dart';
import 'package:workoutapp/models/rep_model.dart';
import 'package:workoutapp/services/exercise_service.dart';
import 'package:workoutapp/style/styles.dart';
import 'package:workoutapp/helper/scroll_helper.dart';
import 'dart:core';

class ExercisePreview {
  Container single(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.35,
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: ScrollHelper.noGlowScroll(SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 25, right: 100),
              child: Text(
                "Today's focus is muscle building and developing strength.",
                style: Styles.subTitleMedium(),
              ),
            ),
            Container(
                // padding: EdgeInsets.only(left: 5),
                // decoration: BoxDecoration(
                //   border: Border(left: BorderSide(width: 2, color: Styles.accentColor))
                // ),
                child: Column(children: exercisePreviews(context)))
          ],
        ))));
  }

  List<Widget> exercisePreviews(BuildContext context) {
    List<Widget> previews = new List<Widget>();
    var session = ExerciseService.getDaysSession();
    for (var i = 0; i < session.length; i++) {
      var weightIncreased = session[i].weightIncrease != 0;

      previews.add(Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            weightIncrease(weightIncreased, session[i]),
            repsCircles(session[i])
            // Text(
            //   session[i].sets.length.toString() + " sets",
            //   style:
            //       Styles.subTitleMedium().copyWith(fontWeight: FontWeight.bold),
            // )
          ],
        ),
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(bottom: 15),
      ));
    }

    return previews;
  }

  Container repsCircles(ExerciseModel exercise) {
    return Container(
      child: Row(
        children: exercise.sets.map((x) => RepCircle.get(x.repCount)).toList()
      ),
    );
  }

  Row weightIncrease(bool weightIncreased, ExerciseModel exercise) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(exercise.name, style: Styles.titleDarkSmall()),
                if (weightIncreased) 
                  Container(
                    margin: EdgeInsets.only(left: 8, right: 3),
                    child: Icon(
                      Icons.arrow_upward,
                      color: Styles.subtitleColor,
                      size: 18,
                    ),
                  ),
                  if (weightIncreased) Text(exercise.weightIncrease.toString() + " kg", style: Styles.subTitle(),),
              ],
            );
  }

  headerRow(BuildContext context, String text) {
    return Row(
      children: <Widget>[Text(text, style: Styles.titleDarkSmall())],
    );
  }

  ScrollConfiguration descriptionRow(
      List<RepModel> items, BuildContext context) {
    List<Container> itemContainers = items.map((item) {
      return Container(
          // color: Styles.subtitleColor,
          margin: EdgeInsets.only(right: 5.0),
          padding: EdgeInsets.all(2),
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  item.repCount.toString(),
                  style: Styles.subTitleMediumDark(),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 2),
                  child: IconTheme(
                    data: IconThemeData(color: Styles.darkTextColor, size: 18),
                    child: Icon(
                      Icons.clear,
                    ),
                  )),
              Container(
                child: Text(
                  item.displayWeight,
                  style: Styles.subTitleMediumDark(),
                ),
              )
            ],
          )
          // Chip(
          //   label: Text(
          //     "${item.repCount.toString()}x${item.weight}",
          //     style: Styles.textSmallLight(),
          //   ),
          //   padding: EdgeInsets.all(0.0),
          //   backgroundColor: Styles.subtitleColor,
          // )
          );
    }).toList();

    List<Widget> children = new List();
    itemContainers.forEach((item) => children.add(item));

    return ScrollHelper.noGlowScroll(SingleChildScrollView(
      child: Row(
        children: children,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
      scrollDirection: Axis.horizontal,
    ));
  }
}
