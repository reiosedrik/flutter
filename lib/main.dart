
import 'package:flutter/material.dart';
import 'package:workoutapp/screens/active_session.dart';
import 'package:workoutapp/screens/calendar.dart';
import 'package:workoutapp/screens/create_profile.dart';
import 'package:workoutapp/screens/home.dart';
import 'package:workoutapp/screens/profile.dart';
import 'package:workoutapp/screens/progress.dart';
import 'package:workoutapp/services/profile_service.dart';
import 'package:workoutapp/style/styles.dart';


void main() {
  ProfileService profileService = new ProfileService();
  var profileCreated = profileService.isProfileCreated();

  runApp(new MaterialApp(
    home: CreateProfile(),
    theme: Styles.primaryTheme(),
    routes: <String, WidgetBuilder> {
      // '/': (context) => Home(),
      '/home': (context) => Home(),
      '/calendar': (context) => Calendar(),
      '/progress': (context) => Progress(),
      '/profile': (context) => Profile(),
      '/activeSession': (context) => ActiveSession()
    },
  ));
}
