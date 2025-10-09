import 'dart:async';

import 'package:flutter/material.dart';

import 'models.dart' show Workout, WorkoutType, WorkoutSet;

class WorkoutSessionState extends ChangeNotifier {
  // private state
  Workout _currentWorkout;
  int _restRemainingSeconds = 0;
  Timer? _restTimer;

  // initialisation
  WorkoutSessionState({required WorkoutType workoutType})
    : _currentWorkout = Workout(workoutType: workoutType);

  // getters
  Workout? get currentWorkout => _currentWorkout;
  int get restTimeRemaining => _restRemainingSeconds;

  // lifecyle management
  void addSet(WorkoutSet set) {
    _currentWorkout.sets.add(set);
  }

  bool isResting() {
    return _restTimer?.isActive == true;
  }

  void startRest(final int durationSeconds) {
    _restRemainingSeconds = durationSeconds;

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _restRemainingSeconds--;
      notifyListeners();

      if (_restRemainingSeconds <= 0) {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void resume() {
    _restTimer?.cancel();
    _restRemainingSeconds = 0;
    notifyListeners();
  }

  void finish() {
    _currentWorkout.finish();
    // TODO: update app state's completedWorkouts
    notifyListeners();
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    super.dispose();
  }
}
