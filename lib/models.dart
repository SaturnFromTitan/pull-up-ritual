import 'package:uuid/uuid.dart';

enum WorkoutType { maxSets, submaxVolume, ladders }

class Set {
  final int groupNumber; // used for ladders or pyramid workouts
  final int targetReps;
  final int completedReps;

  Set({
    required this.groupNumber,
    required this.targetReps,
    required this.completedReps,
  });
}

class Workout {
  final Uuid id;
  final WorkoutType workoutType;
  final DateTime start;
  DateTime? end;
  List<Set> sets = <Set>[];

  Workout({required this.id, required this.workoutType, required this.start});
}
