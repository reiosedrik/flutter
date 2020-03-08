import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutapp/components/bottom_bar.dart';
import 'package:workoutapp/components/rep_circle.dart';
import 'package:workoutapp/models/exercise_model.dart';
import 'package:workoutapp/services/workouts_service.dart';
import 'package:workoutapp/style/styles.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarState extends State<Calendar> {
  CalendarController calendarController = CalendarController();
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // List<Event> pastWorkouts;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
        body: Container(
          // height: 800,
          color: Colors.black.withOpacity(0.9),
          child: SafeArea(
            child: Wrap(children: [calendarContainer(), overview(context)]),
          ),
        ),
        bottomNavigationBar: BottomBar.getInstance(context));
  }

  @override
  void dispose() {
    calendarController.dispose();
    super.dispose();
  }

  Container overview(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.vertical(
            top: Radius.circular(Styles.topRadiusMain)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                // mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  dailyOverviewTitle(),
                  dailyOverviewSubtitle(),
                ],
              )),
          dailyOverviewContent()
        ],
      ),
    );
  }

  Container dailyOverviewContent() {
    List<dynamic> dailyResult = WorkoutsService.workouts[selectedDate];
    print(selectedDate);

    return Container(
      margin: EdgeInsets.only(top: 30, left: 20),
      child: dailyResult != null ? withResults(dailyResult) : noResults(),
    );
  }

  Container withResults(List<dynamic> dailyResult) {
    var children = dailyResult
        .map<Widget>((workout) => Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: workout.session
                  .map<Widget>((exercise) => Container(
                      margin: EdgeInsets.only(bottom: 10, right: 20),
                      child: overviewContentBody(exercise)
                          ))
                  .toList(),
            )))
        .toList();

    return Container(
      child: Column(
        children: children,
      ),
    );
  }

  Row overviewContentBody(ExerciseModel exercise) {
    List<Widget> content = new List<Widget>();
    List<Widget> reps = new List<Widget>();

    content.add(Text(
      exercise.name,
      style: Styles.titleDarkSmall(),
    ));

    exercise.sets.forEach((s) => {
          reps.add(RepCircle.get(s.repCount))
        });

    content.add(Container(
      child: Row(
      children: reps,
    ),
    ));

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: content,
    );
  }

  Container noResults() {
    return Container(
      child: Text(
        "You didn't work out that day.",
        style: Styles.titleDarkSmall(),
      ),
    );
  }

  Container dailyOverviewTitle() {
    var date = selectedDate ?? DateTime.now();
    return Container(
      child: Text(DateFormat('EEEE').format(date), style: Styles.titleDark()),
    );
  }

  Container dailyOverviewSubtitle() {
    var date = selectedDate ?? DateTime.now();
    return Container(
      margin: EdgeInsets.only(left: 10, top: 7),
      child: Text(
        DateFormat.yMMMMd("en_US").format(date),
        style: Styles.titleDarkSmall(),
      ),
    );
  }

  Container calendarContainer() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: TableCalendar(
        events: WorkoutsService.workouts,

        startingDayOfWeek: StartingDayOfWeek.monday,
        onDaySelected: (DateTime date, List<dynamic> data) {
          setState(() {
            selectedDate = DateTime(date.year, date.month, date.day);
          });
        },
        calendarStyle: calendarStyle(),
        headerStyle: headerStyle(),
        daysOfWeekStyle: daysOfWeekStyle(),
        calendarController: calendarController,

        builders: CalendarBuilders(
          markersBuilder: (context, date, events, holidays) {
            final children = <Widget>[];
            if (events.isNotEmpty) {
              children.add(Positioned(
                bottom: 10,
                child: pastWorkoutMarker(),
              ),);
            }
            print(events);

            return children;
          }
        ),
      ),
    );
  }

  Widget pastWorkoutMarker() {
    return Container(
      decoration:
          BoxDecoration(color: Styles.subtitleColor, shape: BoxShape.circle),
      width: 7,
      height: 7,
    );
  }

  CalendarStyle calendarStyle() {
    return CalendarStyle(
        markersColor: Styles.subtitleColor,
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Styles.subtitleColor),
        selectedColor: Styles.subtitleColor,
        outsideWeekendStyle:
            TextStyle(color: Styles.subtitleColor.withOpacity(0.4)),
        outsideHolidayStyle:
            TextStyle(color: Styles.subtitleColor.withOpacity(0.4)),
        todayColor: Styles.subtitleColor.withOpacity(0.4));
  }

  HeaderStyle headerStyle() {
    return HeaderStyle(
      formatButtonVisible: false,
      titleTextStyle: TextStyle(color: Colors.white),
      centerHeaderTitle: true,
      rightChevronIcon: Icon(
        Icons.chevron_right,
        color: Colors.white,
      ),
      leftChevronIcon: Icon(
        Icons.chevron_left,
        color: Colors.white,
      ),
    );
  }

  DaysOfWeekStyle daysOfWeekStyle() {
    return DaysOfWeekStyle(weekendStyle: TextStyle(color: Styles.accentColor));
  }
}

class Calendar extends StatefulWidget {
  @override
  CalendarState createState() => new CalendarState();
}
