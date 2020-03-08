import 'package:workoutapp/models/rep_model.dart';

class ExerciseModel {
  String name;
  List<RepModel> sets;
  List<int> restTimesInSeconds;
  int weightIncrease;
  int exerciseId;

  ExerciseModel(this.name, this.sets, this.restTimesInSeconds, this.exerciseId, {this.weightIncrease: 0});
}