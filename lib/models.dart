import 'package:uuid/uuid.dart';

enum WorkoutType {
  maxSets("Max Sets"),
  submaxVolume("Submax Volume"),
  ladders("Ladders");

  final String name;
  const WorkoutType(this.name);
}

class WorkoutSet {
  final int? targetReps;
  final int completedReps;

  WorkoutSet({this.targetReps, required this.completedReps});
}

class Workout {
  final Uuid uuid;
  final WorkoutType workoutType;
  final DateTime start;
  DateTime? end;
  List<WorkoutSet> sets = <WorkoutSet>[];

  Workout({Uuid? id, required this.workoutType, DateTime? start})
    : uuid = id ?? Uuid(),
      start = start ?? DateTime.now().toUtc();

  void finish() {
    end ??= DateTime.now().toUtc();
    // TODO: update AppState?
  }
}
