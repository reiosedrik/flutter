import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutapp/components/bottom_bar.dart';
import 'package:workoutapp/components/session_preview.dart';
import 'package:workoutapp/helper/decoration_helper.dart';
import 'package:workoutapp/style/styles.dart';

class HomeState extends State<Home> {
  // final double bottomButtonSize = 26.0;
  SessionPreview sessionPreview = new SessionPreview();

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
            child: Wrap(children: [
              topRow(context),
              search(context),
              sessionPreview.getInstance(context)
            ]),
          ),
        ),
        bottomNavigationBar: BottomBar.getInstance(context));
  }
}

Container topRow(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.2,
    margin: EdgeInsets.only(bottom: 30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 30, left: 20),
                width: 300,
                child: Text("Welcome back, Reio :)",
                    //  It's 2 days since your last workout. Ready to break some sweat?",
                    style: Styles.titleLight()))
          ],
        ),
        // Column(
        //   children: <Widget>[
        //     fab(context),
        //   ],
        // ),
      ],
    ),
  );
}

Container statusContainer() {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: DecorationHelper.borderRadiusButton(),
            color: Colors.black
          ),
          child: Column(
          children: <Widget>[
            Container(
              child: Text("FOCUS", style: Styles.subTitle().copyWith(color: Styles.darkNeutral),),
            ),
            Container(
              child: Text("Building Muscle", style: Styles.subTitleLarge())
            )
          ],
        ),
        )
      ],
    )
  );
}

Container search(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
    width: MediaQuery.of(context).size.width * 0.90,

    // color: Colors.black,
    decoration: BoxDecoration(
        borderRadius: DecorationHelper.borderRadiusButton(),
        color: Colors.black),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 300,
          padding: EdgeInsets.only(left: 15),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search exercises...",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Styles.darkNeutral),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 15),
          child: Icon(Icons.search, size: 30, color: Styles.darkNeutral,),
        )
      ],
    ),
  );
}

Container fab(BuildContext context) {
  return Container(
      // height: 18,
      // margin: EdgeInsets.only(top: 205, right: 10),
      // padding: EdgeInsets.only(bottom: 20),
      child: Column(
    children: <Widget>[
      IconButton(
        icon: Icon(
          Icons.menu,
          size: 32.0,
        ),
        color: Theme.of(context).accentColor,
        onPressed: () {},
      )
    ],
  ));
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}
