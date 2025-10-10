import 'dart:async';

import 'package:flutter/material.dart';

import 'models.dart' show Workout, WorkoutType, WorkoutSet;

class WorkoutState extends ChangeNotifier {
  // private state
  Workout _currentWorkout;
  int _restRemainingSeconds = 0;
  Timer? _restTimer;

  // initialisation
  WorkoutState({required WorkoutType workoutType})
    : _currentWorkout = Workout(workoutType: workoutType);

  // getters
  Workout get currentWorkout => _currentWorkout;
  int get restTimeRemaining => _restRemainingSeconds;

  // lifecyle management
  void addSet(WorkoutSet set) {
    _currentWorkout.sets.add(set);
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

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }
}
