import 'package:flutter/material.dart';

import 'models.dart' show Workout;

class AppState extends ChangeNotifier {
  var completedWorkouts = <Workout>[];
}
