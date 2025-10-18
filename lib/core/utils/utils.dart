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
  var values = <String>[];
  var lastGroup = -1;
  var currentValue = "";
  for (var set in workout.sets) {
    if (set.group != lastGroup && lastGroup != -1) {
      values.add(currentValue);
      currentValue = "";
    }

    if (set.group == lastGroup) {
      currentValue += "+${set.completedReps}";
    } else if (currentValue == "") {
      currentValue = "${set.completedReps}";
    }

    lastGroup = set.group;
  }
  if (currentValue != "") {
    values.add(currentValue);
  }
  return values;
}

String datetimeToString(DateTime dt) {
  var year = dt.year.toString().padLeft(4, '0');
  var month = dt.month.toString().padLeft(2, '0');
  var day = dt.day.toString().padLeft(2, '0');
  var hour = dt.hour.toString().padLeft(2, '0');
  var minute = dt.minute.toString().padLeft(2, '0');
  return "$year-$month-$day $hour:$minute";
}
