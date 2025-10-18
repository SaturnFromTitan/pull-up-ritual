import 'package:pull_up_ritual/features/workout/data/models.dart' show Workout;

String twoDigits(int n) {
  return n.toString().padLeft(2, '0');
}

String formatMinutesSeconds(int totalSeconds) {
  final minutes = twoDigits(totalSeconds ~/ 60);
  final seconds = twoDigits(totalSeconds % 60);
  return "$minutes:$seconds";
}

List<String> getSetCardValues(Workout workout) {
  Map<int, int> repsPerGroup = {};

  for (var set_ in workout.sets) {
    var group = set_.group;
    var reps = set_.completedReps;
    repsPerGroup[group] = (repsPerGroup[group] ?? 0) + reps;
  }
  return repsPerGroup.values.map((int e) => e.toString()).toList();
}

String datetimeToString(DateTime dt) {
  var year = dt.year.toString().padLeft(4, '0');
  var month = dt.month.toString().padLeft(2, '0');
  var day = dt.day.toString().padLeft(2, '0');
  var hour = dt.hour.toString().padLeft(2, '0');
  var minute = dt.minute.toString().padLeft(2, '0');
  return "$year-$month-$day $hour:$minute";
}
