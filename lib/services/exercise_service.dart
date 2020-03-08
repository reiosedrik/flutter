import 'package:workoutapp/helper/data_helper.dart';
import 'package:workoutapp/models/exercise_model.dart';
import 'package:workoutapp/models/rep_model.dart';

class ExerciseService {

  static void saveSession(List<ExerciseModel> sessionData) {
    sessionData.forEach((x) => {
      print("Exercise - " + x.name),
      x.sets.forEach((y) => {
        print("weight: " + y.displayWeight),
        print("reps: " + y.repCount.toString())
      })
    });
  }

  static List<ExerciseModel> getDaysSession() {
    List<ExerciseModel> result = new List<ExerciseModel>();
    result.add(ExerciseModel(
      "Bench Press",
      <RepModel>[
        RepModel(6, 80),
        RepModel(6, 90),
        RepModel(6, 100),
        RepModel(6, 100),
        RepModel(6, 100),
      ],
      <int>[5, 5, 5, 5, 5],
      1,
      weightIncrease: 5
    ));

    result.add(ExerciseModel(
      "Overhead Shoulder Press",
      <RepModel>[
        RepModel(5, 40),
        RepModel(5, 50),
        RepModel(5, 60),
        RepModel(5, 60),
        RepModel(5, 60),
      ],
      <int>[2, 2, 3, 3, 3],
      2
    ));

    result.add(ExerciseModel(
      "Dumbbell Front Squats",
      <RepModel>[
        RepModel(8, 25),
        RepModel(8, 25),
        RepModel(8, 25),
        RepModel(8, 25),
      ],
      <int>[5, 5, 5, 5, 5],
      3
    ));

    result.add(ExerciseModel(
      "Deadlift",
      <RepModel>[
        RepModel(8, 100),
        RepModel(6, 120),
        RepModel(4, 140),
        RepModel(4, 160),
        RepModel(4, 160),
      ],
      <int>[5, 5, 5, 5, 5],
      4
    ));

    return result;
  }
}