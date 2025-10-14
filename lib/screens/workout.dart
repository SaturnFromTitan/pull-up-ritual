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
  bool isWorkoutFinished();

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
    if (isWorkoutFinished()) {
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
                    children: [
                      Text("do ${getTargetReps()} reps"),
                      getInputs(workoutState, appState),
                    ],
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

class WorkoutLaddersScreen extends BaseWorkoutScreen {
  const WorkoutLaddersScreen({super.key});

  @override
  State<WorkoutLaddersScreen> createState() => _WorkoutLaddersState();
}

class _WorkoutLaddersState extends BaseWorkoutState<WorkoutLaddersScreen> {
  final numberOfLadders = 5;
  int targetReps = 1;
  int completedLadders = 0;
  bool showCustomInputForm = false;

  @override
  int get restDurationSeconds => 30;

  @override
  int getTargetReps() => targetReps;

  @override
  bool isWorkoutFinished() => completedLadders == numberOfLadders;

  @override
  Widget getInputs(WorkoutState workoutState, AppState appState) {
    var defaultButtons = [
      ElevatedButton(
        onPressed: () {
          targetReps++;
          finishSet(
            completedReps: targetReps,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, continue this ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          targetReps = 1;
          completedLadders++;
          finishSet(
            completedReps: targetReps,
            workoutState: workoutState,
            appState: appState,
          );
        },
        child: Text('Done, start new ladder'),
      ),
      ElevatedButton(
        onPressed: () {
          setState(() {
            showCustomInputForm = !showCustomInputForm;
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
                showCustomInputForm = !showCustomInputForm;
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

              showCustomInputForm = false;
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
        children: showCustomInputForm ? fewerInputs : defaultButtons,
      ),
    );
  }
}
