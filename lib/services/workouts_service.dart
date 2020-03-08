import 'package:workoutapp/models/exercise_model.dart';
import 'package:workoutapp/services/exercise_service.dart';

class WorkoutsService {
  static Map<DateTime, List> workouts = {
    DateTime(2020, 3, 3): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 7): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 1): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 8): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 9): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 15): [Workout(ExerciseService.getDaysSession())],
    DateTime(2020, 3, 20): [Workout(ExerciseService.getDaysSession())],
  };

  static List<String> workoutTypes = [
    "Bench Press", "Deadlift", "Pullup", "Pushup", "Shoulder Press", "Biceps Curl"
  ];
}

class Workout {
  List<ExerciseModel> session;

  Workout(this.session);
}

