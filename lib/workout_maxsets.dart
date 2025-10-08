import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_state.dart' show AppState;
import 'models.dart' show WorkoutSet, Workout, WorkoutType;

class WorkoutMaxSetsScreen extends StatefulWidget {
  final WorkoutType workoutType;

  const WorkoutMaxSetsScreen({super.key, required this.workoutType});

  @override
  State<WorkoutMaxSetsScreen> createState() => _WorkoutMaxSetsScreenState();
}

class _WorkoutMaxSetsScreenState extends State<WorkoutMaxSetsScreen> {
  final _formKey = GlobalKey<FormState>();
  final numberOfSets = 3;
  var workout = Workout(workoutType: WorkoutType.maxSets);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

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
                            workout.sets.add(set);
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
                            setState(() {});

                            if (workout.sets.length == numberOfSets) {
                              // update app state
                              appState.completedWorkouts.add(workout);
                              // should redirect to success page
                              Navigator.of(context).pop();
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
                  Navigator.of(context).pop();
                },
                child: Text("Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
