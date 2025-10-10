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

class WorkoutSubmaxVolumeScreen extends StatefulWidget {
  final int targetReps;
  const WorkoutSubmaxVolumeScreen({super.key, required this.targetReps});

  @override
  State<WorkoutSubmaxVolumeScreen> createState() =>
      _WorkoutSubmaxVolumeScreenState();
}

class _WorkoutSubmaxVolumeScreenState extends State<WorkoutSubmaxVolumeScreen> {
  final _formKey = GlobalKey<FormState>();
  final numberOfSets = 10;
  final restDurationSeconds = 60;

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
              Text(workoutState.currentWorkout.workoutType.name),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("do ${widget.targetReps} reps"),
                        TextFormField(
                          maxLength: 2,
                          inputFormatters: [
                            FilteringTextInputFormatter(
                              RegExp(r'[0-9]'),
                              allow: true,
                            ),
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'How many reps did you do?';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            final set = WorkoutSet(
                              completedReps: int.parse(value!),
                            );
                            workoutState.addSet(set);
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final form = _formKey.currentState!;
                            if (!form.validate()) {
                              return;
                            }

                            form.save();
                            form.reset();
                            setState(() {}); // TODO: is this necessary?

                            if (workoutState.currentWorkout.sets.length ==
                                numberOfSets) {
                              // TODO: this should happen in one method call of the domain model,
                              //  instead of orchestrating it in the in the view
                              workoutState.currentWorkout.finish();
                              appState.completedWorkouts.add(
                                workoutState.currentWorkout,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SuccessScreen(
                                    workout: workoutState.currentWorkout,
                                  ),
                                ),
                              );
                            } else {
                              workoutState.rest(restDurationSeconds);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChangeNotifierProvider.value(
                                    value: workoutState,
                                    child: RestScreen(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Cancel"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
