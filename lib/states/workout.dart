import 'dart:async';

import 'package:flutter/material.dart';

import '../models.dart' show Workout, WorkoutType, WorkoutSet;
import 'app.dart' show AppState;

class WorkoutState extends ChangeNotifier {
  // private state
  Workout _workout;
  int _restRemainingSeconds = 0;
  Timer? _restTimer;

  // initialisation
  WorkoutState({required WorkoutType workoutType})
    : _workout = Workout(workoutType: workoutType);

  // getters
  Workout get workout => _workout;
  int get restTimeRemaining => _restRemainingSeconds;

  // lifecyle management
  void addSet(WorkoutSet set) {
    _workout.sets.add(set);
  }

  void rest(final int durationSeconds) {
    _restRemainingSeconds = durationSeconds;

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _restRemainingSeconds--;
      notifyListeners();

      if (_restRemainingSeconds <= 0) {
        resume();
      }
    });
  }

  void resume() {
    _restTimer?.cancel();
    _restRemainingSeconds = 0;
    notifyListeners();
  }

  bool isResting() {
    return _restTimer?.isActive == true;
  }

  void finish(AppState appState) {
    _workout.finish();
    appState.completedWorkouts.add(_workout);
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }
}
