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
  final controller = TextEditingController();
  final numberOfSets = 10;
  final restDurationSeconds = 60;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var workoutState = context.watch<WorkoutState>();
    var targetReps = widget.targetReps;

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("do $targetReps reps"),
                        SizedBox(
                          width: 40,
                          child: TextFormField(
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
                                targetReps: targetReps,
                                completedReps: int.parse(value!),
                              );
                              workoutState.addSet(set);
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final form = _formKey.currentState!;
                            if (!form.validate()) {
                              return;
                            }

                            form.save();
                            form.reset();

                            if (workoutState.workout.sets.length ==
                                numberOfSets) {
                              workoutState.finish(appState);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SuccessScreen(
                                    workout: workoutState.workout,
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
