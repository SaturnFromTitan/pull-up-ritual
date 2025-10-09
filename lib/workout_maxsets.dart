import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/home.dart';
import 'package:pull_up_ritual/state_workout.dart';

import 'state_app.dart' show AppState;
import 'state_workout.dart' show WorkoutState;
import 'models.dart' show WorkoutSet;
import 'screen_rest.dart' show RestScreen;

class WorkoutMaxSetsScreen extends StatefulWidget {
  @override
  State<WorkoutMaxSetsScreen> createState() => _WorkoutMaxSetsScreenState();
}

class _WorkoutMaxSetsScreenState extends State<WorkoutMaxSetsScreen> {
  final _formKey = GlobalKey<FormState>();
  final numberOfSets = 3;
  final restDurationSeconds = 3;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var workoutState = context.watch<WorkoutState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text("Do as many reps as possible! 🔥"),
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
                              // TODO: should redirect to success page
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => HomeForm()),
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
                  ).push(MaterialPageRoute(builder: (_) => HomeForm()));
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
