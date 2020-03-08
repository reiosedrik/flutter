import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutapp/components/bottom_bar.dart';

class ProfileState extends State<Profile> {
   @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      bottomNavigationBar: BottomBar.getInstance(context),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();

}