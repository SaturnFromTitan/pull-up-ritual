import 'package:uuid/uuid.dart';

enum WorkoutType {
  maxSets("Max Sets"),
  submaxVolume("Submax Volume"),
  ladders("Ladders");

  final String name;
  const WorkoutType(this.name);
}

class Set {
  final int targetReps;
  final int completedReps;

  Set({
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
