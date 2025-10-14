import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/screens/home.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/app.dart' show AppState;
import '../states/workout.dart' show WorkoutState;
import '../models.dart' show WorkoutSet;
import 'rest.dart' show RestScreen;
import 'success.dart' show SuccessScreen;

abstract class BaseWorkoutScreen extends StatefulWidget {
  const BaseWorkoutScreen({super.key});

  @override
  State<BaseWorkoutScreen> createState();
}

abstract class BaseWorkoutState<T extends BaseWorkoutScreen> extends State<T> {
  // TODO: move formkey & controller to concrete classes?
  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  int get restDurationSeconds;

  int? getTargetReps();
  bool isWorkoutFinished(WorkoutState workoutState);

  void navigateToSuccess(WorkoutState workoutState) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SuccessScreen(workout: workoutState.workout),
      ),
    );
  }

  void navigateToRest(WorkoutState workoutState) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: workoutState,
          child: RestScreen(),
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  void finishSet({
    required int completedReps,
    required WorkoutState workoutState,
    required AppState appState,
  }) {
    // add set
    final set = WorkoutSet(
      targetReps: getTargetReps(),
      completedReps: completedReps,
    );
    workoutState.addSet(set);

    // reset inputs
    final form = _formKey.currentState!;
    form.reset();

    // navigate
    if (isWorkoutFinished(workoutState)) {
      workoutState.finish(appState);
      navigateToSuccess(workoutState);
    } else {
      workoutState.rest(restDurationSeconds);
      navigateToRest(workoutState);
    }
  }

  Widget getInputs(WorkoutState workoutState, AppState appState);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var workoutState = context.watch<WorkoutState>();
    int? targetReps = getTargetReps();
    Widget inputs = getInputs(workoutState, appState);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(workoutState.workout.workoutType.name),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    children: targetReps == null
                        ? [inputs]
                        : [Text("do $targetReps reps"), inputs],
                  ),
                ),
              ),
              ElevatedButton(onPressed: navigateToHome, child: Text("Cancel")),
            ],
          ),
        ),
      ),
    );
  }
}

// max sets
// #################################################
class WorkoutMaxSetsScreen extends BaseWorkoutScreen {
  const WorkoutMaxSetsScreen({super.key});

  @override
  State<WorkoutMaxSetsScreen> createState() => _WorkoutMaxSetsScreenState();
}

class _WorkoutMaxSetsScreenState
    extends BaseWorkoutState<WorkoutMaxSetsScreen> {
  final numberOfSets = 3;

  @override
  int get restDurationSeconds => 5 * 60;

  @override
  int? getTargetReps() => null;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) {
    return workoutState.workout.sets.length == numberOfSets;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text("Do as many reps as possible! 🔥"),
          TextFormField(
            controller: controller,
            maxLength: 2,
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
            ],
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'How many reps did you do?';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              var value = controller.text;
              if (value.isEmpty) {
                return;
              }
              final completedReps = int.parse(value);

              finishSet(
                completedReps: completedReps,
                workoutState: workoutState,
                appState: appState,
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

// submax volume
// #################################################
class WorkoutSubmaxVolumeScreen extends BaseWorkoutScreen {
  final int targetReps;
  const WorkoutSubmaxVolumeScreen({super.key, required this.targetReps});

  @override
  State<WorkoutSubmaxVolumeScreen> createState() =>
      _WorkoutSubmaxVolumeScreenState();
}

class _WorkoutSubmaxVolumeScreenState
    extends BaseWorkoutState<WorkoutSubmaxVolumeScreen> {
  final _numberOfSets = 10;
  bool _showCustomInputForm = false;

  @override
  int get restDurationSeconds => 60;

  @override
  int getTargetReps() => widget.targetReps;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) {
    return workoutState.workout.sets.length == _numberOfSets;
  }

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    int targetReps = getTargetReps();
    var defaultButtons = [
      ElevatedButton(
        onPressed: () {
          finishSet(
            completedReps: targetReps,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done'),
      ),
      ElevatedButton(
        onPressed: () {
          finishSet(
            completedReps: targetReps - 1,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('I did ${targetReps - 1}'),
      ),
      ElevatedButton(
        onPressed: () {
          finishSet(
            completedReps: targetReps - 2,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('I did ${targetReps - 2}'),
      ),
      ElevatedButton(
        onPressed: () {
          setState(() {
            _showCustomInputForm = !_showCustomInputForm;
          });
        },
        child: Text('I did fewer'),
      ),
    ];
    var fewerInputs = [
      TextFormField(
        controller: controller,
        maxLength: 2,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
        ],
        keyboardType: TextInputType.number,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showCustomInputForm = !_showCustomInputForm;
              });
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              var value = controller.text;
              if (value.isEmpty) {
                return;
              }
              final completedReps = int.parse(value);

              _showCustomInputForm = false;
              finishSet(
                completedReps: completedReps,
                workoutState: workoutState,
                appState: appState,
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    ];

    return Form(
      key: _formKey,
      child: Column(
        children: _showCustomInputForm ? fewerInputs : defaultButtons,
      ),
    );
  }
}

// ladders
// #################################################
class WorkoutLaddersScreen extends BaseWorkoutScreen {
  const WorkoutLaddersScreen({super.key});

  @override
  State<WorkoutLaddersScreen> createState() => _WorkoutLaddersState();
}

class _WorkoutLaddersState extends BaseWorkoutState<WorkoutLaddersScreen> {
  final _numberOfLadders = 5;
  int _targetReps = 1;
  int _completedLadders = 0;
  bool _showCustomInputForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getTargetReps() => _targetReps;

  @override
  bool isWorkoutFinished(WorkoutState workoutState) =>
      _completedLadders == _numberOfLadders;

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var defaultButtons = [
      ElevatedButton(
        onPressed: () {
          _targetReps++;
          finishSet(
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, continue this ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          _targetReps = 1;
          _completedLadders++;
          finishSet(
            completedReps: getTargetReps(),
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, start new ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          setState(() {
            _showCustomInputForm = !_showCustomInputForm;
          });
        },
        child: Text('I did fewer'),
      ),
    ];
    var fewerInputs = [
      TextFormField(
        controller: controller,
        maxLength: 2,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true),
        ],
        keyboardType: TextInputType.number,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showCustomInputForm = !_showCustomInputForm;
              });
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              var value = controller.text;
              if (value.isEmpty) {
                return;
              }
              final completedReps = int.parse(value);

              _showCustomInputForm = false;
              finishSet(
                completedReps: completedReps,
                workoutState: workoutState,
                appState: appState,
              );
            },
            child: Text('Submit'),
          ),
        ],
      ),
    ];

    return Form(
      key: _formKey,
      child: Column(
        children: _showCustomInputForm ? fewerInputs : defaultButtons,
      ),
    );
  }
}
