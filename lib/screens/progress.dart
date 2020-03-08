import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutapp/components/bottom_bar.dart';
import 'package:workoutapp/services/workouts_service.dart';
import 'package:workoutapp/style/styles.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ProgressState extends State<Progress> {
  String selectedProgressType;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          // color: Colors.white,
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Progress", style: Styles.titleDark()),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                // mainAxisAlignment: MainAxisAlignment.start,
                child:
                  selectionContainer()
              ),
              Container(
                child: chart()
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomBar.getInstance(context));
  }

  Container chart() {
    return Container();
  }

  Container selectionContainer() {
    return Container(
      child: SearchableDropdown.single(
        items: WorkoutsService.workoutTypes.map((x) => new DropdownMenuItem(
          child: Container(
            child: Text(x),
          ),
        )).toList(),
        value: selectedProgressType,
        hint: "Select category to see progress",
        searchHint: "Select category to see progress",
        onChanged: (value) {
          setState(() {
            selectedProgressType = value;
          });
        },
        isExpanded: true,
      ),
    );
  }
}

class Progress extends StatefulWidget {
  @override
  ProgressState createState() => new ProgressState();
}
