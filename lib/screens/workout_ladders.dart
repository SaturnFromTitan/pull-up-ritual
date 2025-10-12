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

class WorkoutLaddersScreen extends StatefulWidget {
  const WorkoutLaddersScreen({super.key});

  @override
  State<WorkoutLaddersScreen> createState() => _WorkoutLaddersScreenState();
}

class _WorkoutLaddersScreenState extends State<WorkoutLaddersScreen> {
  final _formKey = GlobalKey<FormState>();
  final numberOfLadders = 5;
  final restDurationSeconds = 30;
  int targetReps = 1;
  int completedLadders = 0;

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
                            setState(() {}); // TODO: is this necessary?

                            targetReps++;
                            workoutState.rest(restDurationSeconds);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider.value(
                                  value: workoutState,
                                  child: RestScreen(),
                                ),
                              ),
                            );
                          },
                          child: Text('Done, continue ladder'),
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

                            completedLadders++;
                            targetReps = 1;

                            if (completedLadders == numberOfLadders) {
                              // TODO: this should happen in one method call of the domain model,
                              //  instead of orchestrating it in the in the view
                              workoutState.workout.finish();
                              appState.completedWorkouts.add(
                                workoutState.workout,
                              );
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
                          child: Text('Done, new ladder'),
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
