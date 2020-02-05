import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello/components/bottom_bar.dart';
import 'package:hello/components/session_preview.dart';
import 'package:hello/components/text_helper.dart';
import 'package:hello/style/styles.dart';

class HomeState extends State<Home> {
  // final double bottomButtonSize = 26.0;
  SessionPreview sessionPreview = new SessionPreview();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));

    return Scaffold(
      
      // backgroundColor: Colors.grey[900],
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Styles.bgGradient1, Styles.bgGradient2]
          )
        ),
        child: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [topRow(context), sessionPreview.getInstance(context)]),
      ),
      )
      // bottomNavigationBar: BottomBar.getInstance()
    );
  }
}

Container topRow(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 100),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10),
              width: 300,
              child: Text(
                "Welcome back, Joe. It's 2 days since your last workout. Ready to break some sweat?",
                style: Theme.of(context).textTheme.title
                ))
          ],
        ),
        Column(
          children: <Widget>[
            fab(context),
          ],
        ),
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
        icon: Icon(Icons.menu, size: 32.0,),
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
