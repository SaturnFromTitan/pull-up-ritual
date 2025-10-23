import 'package:flutter/material.dart';
import 'package:pull_up_ritual/features/workout/models.dart' show Workout;

class AppProvider extends ChangeNotifier {
  var completedWorkouts = <Workout>[];
  int _tabIndex = 0;

  int get tabIndex => _tabIndex;

  void setTabIndex(int value) {
    if (value == _tabIndex) return;
    _tabIndex = value;
    notifyListeners();
  }

  void resetTab() {
    setTabIndex(0);
  }
}
