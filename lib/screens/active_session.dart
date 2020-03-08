import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutapp/components/raised_icon_button.dart';
import 'package:workoutapp/helper/decoration_helper.dart';
import 'package:workoutapp/helper/enums.dart';
import 'package:workoutapp/helper/navigation_helper.dart';
import 'package:workoutapp/helper/scroll_helper.dart';
import 'package:workoutapp/models/exercise_model.dart';
import 'package:workoutapp/services/exercise_service.dart';
import 'package:workoutapp/services/settings_service.dart';
import 'package:workoutapp/style/styles.dart';
import 'dart:core';
import 'package:quiver/async.dart';

class ActiveSessionState extends State<ActiveSession> {
  int currentExerciseId = -1;
  int currentSet = 0;
  int activeRep = -1;
  bool showRestTimer = false;

  int _timerCurrent = 0;
  int _timerStart = 0;
  bool finished = false;

  bool showTimer = true;
  ActiveExerciseView activeExerciseView = ActiveExerciseView.singleSet;

  List<ExerciseModel> activeSessionData = new List<ExerciseModel>();
  ExerciseModel currentExercise;
  List<int> completedExerciseIds = new List<int>();

  @override
  Widget build(BuildContext context) {
    if (currentExerciseId == -1) {
      activeSessionData = ExerciseService.getDaysSession();
      currentExercise = activeSessionData[0];
      currentExerciseId = currentExercise.exerciseId;
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    if (activeRep == -1) setActiveRepCount();

    return Scaffold(
      body: Container(
        height: 830,
        color: Colors.black,
        child: SafeArea(
          child: Wrap(
            children: <Widget>[
              // top section
              upcomingSection(),
              sessionInfoSection(),
              activeSection()
            ],
          ),
        ),
      ),
    );
  }

  Container upcomingSection() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(left: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "EXERCISES",
                    style: Styles.subTitle(),
                  ),
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ScrollHelper.noGlowScroll(SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: allExercises(),
                ),
              )))
          // nextExerciseContainer(context),
          // nextSetContainer(context)
        ],
      ),
    );
  }

  List<Container> allExercises() {
    var result = new List<Container>();
    activeSessionData.forEach((item) => {
          result.add(Container(
            height: 33,
            // width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: DecorationHelper.borderRadiusButton(),
                color: Styles.darkTextColor),
            margin: EdgeInsets.only(bottom: 4),
            // padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    item.name,
                    style: Styles.textMediumLight(),
                  ),
                ),
                exercisesOptions(item)
              ],
            ),
          ))
        });
    return result;
  }

  Container exercisesOptions(ExerciseModel item) {
    var child = null;

    if (currentExerciseId == item.exerciseId) {
      child = Container(
        margin: EdgeInsets.only(right: 16),
        child: Text("Active",
            style:
                Styles.buttonTextLight().copyWith(color: Styles.subtitleColor)),
      );
    } else if (completedExerciseIds.contains(item.exerciseId)) {
      child = Container(
        margin: EdgeInsets.only(right: 16),
        child: Text("Completed",
            style:
                Styles.buttonTextLight().copyWith(color: Styles.subtitleColor)),
      );
    } else {
      child = FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: DecorationHelper.borderRadiusButton()),
          color: Styles.darkNeutral,
          onPressed: () {},
          child: Text("Switch to this", style: Styles.buttonTextLight()));
    }

    return Container(child: child);
  }

  Container sessionInfoSection() {
    return Container(
      margin: EdgeInsets.only(left: 25, bottom: 20),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              "SHOW REST TIMER",
              style: Styles.subTitle(),
            ),
          ),
          Container(
            child: Switch(
              inactiveTrackColor: Styles.darkNeutral,
              value: showTimer,
              onChanged: (isOn) {
                setState(() {
                  showTimer = isOn;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Container activeSection() {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.vertical(
              top: Radius.circular(Styles.topRadiusMain)),
        ),
        width: MediaQuery.of(context).size.width,
        height: 9999,
        child:
            showRestTimer ? restTimer() : getActiveExerciseContainer(context));
  }

  void startTimer() {
    int timerAmount = activeSessionData
        .firstWhere((x) => x.exerciseId == currentExerciseId)
        .restTimesInSeconds[currentSet];
    _timerStart = timerAmount;
    _timerCurrent = timerAmount;
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _timerStart),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _timerCurrent = _timerStart - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      showRestTimer = false;
      // updateNextInfoSecion();
      sub.cancel();
    });
  }

  Container restTimer() {
    int minutes = _timerCurrent ~/ 60;
    String seconds = (_timerCurrent % 60).toString().padLeft(2, '0');

    return new Container(
        margin: EdgeInsets.only(top: 140),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Rest",
                  style: Styles.subTitleLarge(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new RepaintBoundary(
                    child: Text(
                  "$minutes:$seconds",
                  style: Styles.titleDarkLarge(),
                ))
              ],
            ),
          ],
        ));
  }

  Column getActiveExerciseContainer(BuildContext context) {
    return activeExerciseView == ActiveExerciseView.singleSet
        ? activeExerciseContainerSingleSet(context)
        : activeExerciseContainerAllSets(context);
  }

  Column activeExerciseContainerSingleSet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        headerInfo(),
        exerciseHeader(),
        weightContainer(),
        repsContainer(),
        enterRepsContainer(context)
      ],
    );
  }

  Column activeExerciseContainerAllSets(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        headerInfo(),
        exerciseHeader(),
        Container(
          margin: EdgeInsets.only(left: 70, right: 81),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("Reps"),
              ),
              Container(
                child: Text("Weight"),
              )
            ],
          ),
        ),
        activeExerciseSets(),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[saveExerciseButton()],
          ),
        )
      ],
    );
  }

  Container skipExerciseContainer() {
    return Container(
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: DecorationHelper.borderRadiusButton()),
        color: Colors.white,
        onPressed: () {
          setState(() {
            activeExerciseView =
                activeExerciseView == ActiveExerciseView.singleSet
                    ? ActiveExerciseView.allSets
                    : ActiveExerciseView.singleSet;
          });
        },
        icon: Icon(
          Icons.cancel,
          color: Styles.accentColor,
        ),
        label: Text("Skip exercise", style: Styles.buttonTextDark()),
      ),
    );
  }

  Container activeExerciseSets() {
    List<Container> sets = new List<Container>();
    if (currentExercise != null) {
    currentExercise.sets.forEach((set) => {
          sets.add(Container(
              margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Row(
                        children: <Widget>[
                          RaisedIconButton.onlyIcon(Icons.remove, () {
                            setState(() {
                              set.repCount--;
                            });
                          }, size: 40.0),
                          Container(
                            alignment: Alignment.center,
                            width: 30,
                            margin: EdgeInsets.only(right: 10, left: 10),
                            child: Text(set.repCount.toString(),
                                style: Styles.titleDarkSmall()),
                          ),
                          RaisedIconButton.onlyIcon(Icons.add, () {
                            setState(() {
                              set.repCount++;
                            });
                          }, size: 40.0),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          RaisedIconButton.onlyIcon(Icons.remove, () {
                            setState(() {
                              set.removeWeight(
                                  SettingsService.smallestWeightUnit());
                            });
                          }, size: 40.0),
                          Container(
                              alignment: Alignment.center,
                              width: 70,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                set.displayWeight + " kg",
                                style: Styles.titleDarkSmall(),
                              )),
                          RaisedIconButton.onlyIcon(Icons.add, () {
                            setState(() {
                              set.addWeight(
                                  SettingsService.smallestWeightUnit());
                            });
                          }, size: 40.0),
                        ],
                      ),
                    )
                  ])))
        });
    }

    return Container(child: Column(children: sets));
  }

  // Container nextExerciseContainer(BuildContext context) {
  //   String nextExerciseText = "";
  //   String exerciseName = "";
  //   String setsText = "";

  //   if (currentExercise + 1 < ExerciseService.getDaysSession().length) {
  //     nextExerciseText = "NEXT EXERCISE";
  //     exerciseName = ExerciseService.getDaysSession()[currentExercise + 1].name;
  //     setsText = ExerciseService.getDaysSession()[currentExercise + 1]
  //             .sets
  //             .length
  //             .toString() +
  //         " SETS";
  //   }

  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.only(left: 20, top: 40),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           // margin: EdgeInsets.only(top: 40, left: 20),
  //           child: Text(
  //             nextExerciseText,
  //             style: Styles.subTitle(),
  //           ),
  //         ),
  //         Container(
  //           // margin: EdgeInsets.only(left: 20),
  //           child: Text(
  //             exerciseName,
  //             style: Styles.titleLight(),
  //           ),
  //         ),
  //         Container(
  //           // margin: EdgeInsets.only(left: 20),
  //           child: Text(
  //             setsText,
  //             style: Styles.subTitle(),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Container nextSetContainer(BuildContext context) {
  //   if (currentExercise >= ExerciseService.getDaysSession().length ||
  //       currentSet + 1 >=
  //           ExerciseService.getDaysSession()[currentExercise].sets.length) {
  //     return noSetsLeftForExerciseContainer();
  //   }

  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.only(left: 20, top: 120),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           child: Text(
  //             "NEXT SET",
  //             style: Styles.subTitle(),
  //           ),
  //         ),
  //         Row(
  //           children: <Widget>[
  //             Container(
  //               child: Text(
  //                 ExerciseService.getDaysSession()[currentExercise]
  //                     .sets[currentSet + 1]
  //                     .repCount
  //                     .toString(),
  //                 style: Styles.titleLight(),
  //               ),
  //             ),
  //             Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 6),
  //                 child: IconTheme(
  //                   data: IconThemeData(color: Colors.white),
  //                   child: Icon(
  //                     Icons.clear,
  //                   ),
  //                 )),
  //             Container(
  //               child: Text(
  //                 ExerciseService.getDaysSession()[currentExercise]
  //                         .sets[currentSet + 1]
  //                         .weight
  //                         .toString() +
  //                     " kg",
  //                 style: Styles.titleLight(),
  //               ),
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Container noSetsLeftForExerciseContainer() {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20, top: 120),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  "",
                  style: Styles.subTitle(),
                ),
              ),
              Container(
                child: Text(
                  "Last Set",
                  style: Styles.titleLight(),
                ),
              )
            ]));
  }

  Row headerInfo() {
    int remaining = activeSessionData
            .firstWhere((x) => x.exerciseId == currentExerciseId)
            .sets
            .length -
        currentSet;
    String remainingText =
        remaining == 1 ? " SET REMAINING" : " SETS REMAINING";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        skipExerciseContainer(),
        Container(
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: DecorationHelper.borderRadiusButton()),
            color: Colors.white,
            onPressed: () {
              setState(() {
                activeExerciseView =
                    activeExerciseView == ActiveExerciseView.singleSet
                        ? ActiveExerciseView.allSets
                        : ActiveExerciseView.singleSet;
              });
            },
            child: Text(
                activeExerciseView == ActiveExerciseView.singleSet
                    ? "Show all sets"
                    : "Show current set",
                style: Styles.buttonTextDark()),
          ),
        )
      ],
    );
  }

  Row exerciseHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  activeSessionData
                      .firstWhere((x) => x.exerciseId == currentExerciseId)
                      .name,
                  style: Styles.titleDark(),
                )
              ],
            ))
      ],
    );
  }

  Container weightContainer() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedIconButton.onlyIcon(Icons.remove, () {}),
              Container(
                margin: EdgeInsets.only(bottom: 5, left: 20, right: 20),
                child: Text(
                  activeSessionData
                          .firstWhere((x) => x.exerciseId == currentExerciseId)
                          .sets[currentSet]
                          .weight
                          .toString() +
                      " kg",
                  style: Styles.subTitleLarge(),
                ),
              ),
              RaisedIconButton.onlyIcon(Icons.add, () {}),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: IconTheme(
              data: IconThemeData(color: Styles.darkTextColor),
              child: Icon(
                Icons.clear,
              ),
            ))
      ],
    ));
  }

  Container repsContainer() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: availableReps(),
        ));
  }

  Row enterRepsContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(right: 40, top: 50),
            child: saveRepsButton())
      ],
    );
  }

  // void updateNextInfoSecion() {
  //   this.currentSet++;
  //   if (this.currentSet >=
  //       ExerciseService.getDaysSession().firstWhere((x) => x.exerciseId == currentExerciseId).sets.length) {
  //     this.currentExercise++;
  //     this.currentSet = 0;
  //   }
  //   activeRep = ExerciseService.getDaysSession()[currentExercise]
  //       .sets[currentSet]
  //       .repCount;
  // }

  List<Widget> availableReps() {
    var result = new List<Widget>();

    // TODO: negative values
    for (var rep = activeRep - 2; rep <= activeRep + 2; rep++) {
      bool repIsActive = rep == activeRep;
      TextStyle textStyle = repIsActive
          ? Styles.buttonTextLightLarge()
          : Styles.buttonTextLight();
      double size = repNrSize(rep, activeRep);
      Color background = repIsActive
          ? Styles.darkTextColor
          : Styles.darkTextColor.withOpacity(0.6);

      result.add(Container(
          height: size,
          width: size,
          padding: EdgeInsets.all(2.0),
          child: FloatingActionButton(
            heroTag: "rep" + rep.toString(),
            backgroundColor: background,
            child: Text(rep.toString(), style: textStyle),
            onPressed: () {
              setState(() {
                setActiveRepCount(x: rep);
              });
            },
          )));
    }
    return result;
  }

  double repNrSize(int value, int active) {
    if (value == activeRep) {
      return 80.0;
    } else {
      return 80.0 - ((active - value) * 20).abs();
    }
  }

  void setActiveRepCount({int x = -1}) {
    activeRep = x == -1
        ? activeSessionData
            .firstWhere((x) => x.exerciseId == currentExerciseId)
            .sets[currentSet]
            .repCount
        : x;
  }

  Container nextUpHeader() {
    return Container(
        child: Text(
      "Next up",
      style: Styles.titleDarkSmall(),
    ));
  }

  RaisedButton saveRepsButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(100.0),
      ),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
      color: Styles.darkTextColor,
      onPressed: () {
        setState(() {
          // activeSessionData.add();
          // if (this.currentExerciseId == -1) {
          //   currentSet = 0;
          //   Navigator.pop(context, true);
          // } else {
          //   this.showRestTimer = true;
          //   startTimer();
          // }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Save reps", style: Styles.buttonTextLight()),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.done,
            color: Colors.white,
          )
        ],
      ),
    );
  }

  RaisedButton saveExerciseButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(100.0),
      ),
      padding: EdgeInsets.only(top: 15, bottom: 15, right: 25, left: 25),
      color: Styles.darkTextColor,
      onPressed: () {
        setState(() {
          completedExerciseIds.add(currentExerciseId);
          currentExercise = activeSessionData.firstWhere(
              (x) => !completedExerciseIds.contains(x.exerciseId),
              orElse: () => null);
          if (currentExercise == null) {
            currentSet = 0;
            ExerciseService.saveSession(activeSessionData);
            Navigator.pop(context, true);
          } else {
            currentExerciseId = currentExercise.exerciseId;
          }
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Save exercise", style: Styles.buttonTextLight()),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.done,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class ActiveSession extends StatefulWidget {
  @override
  ActiveSessionState createState() => new ActiveSessionState();
}
