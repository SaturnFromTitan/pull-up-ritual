import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/states/workout.dart';

import '../states/models.dart' show WorkoutType;
import '../states/workout.dart' show WorkoutState;
import 'workout_max_sets.dart' show WorkoutMaxSetsScreen;
import 'workout_ladders.dart' show WorkoutLaddersScreen;
import 'workout_submax_volume.dart' show WorkoutSubmaxVolumeScreen;
import 'widgets/custom_reps_form.dart' show CustomRepsForm;

const appTitle = 'Pull-Up Ritual';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WorkoutType? _selected;

  void _handleSubmit() async {
    if (_selected == null) {
      const snackbar = SnackBar(content: Text("Please select a workout type!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    int? result;
    if (_selected == WorkoutType.submaxVolume) {
      result = await showDialog<int>(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter Your Target Reps',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  CustomRepsForm(
                    onValidSubmit: (int reps) => Navigator.pop(context, reps),
                    onCancel: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          );
        },
      );
      if (!mounted || result == null) return;
    }

    StatefulWidget workoutScreen;
    switch (_selected!) {
      case WorkoutType.maxSets:
        workoutScreen = WorkoutMaxSetsScreen();
      case WorkoutType.submaxVolume:
        workoutScreen = WorkoutSubmaxVolumeScreen(targetReps: result!);
      case WorkoutType.ladders:
        workoutScreen = WorkoutLaddersScreen();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => WorkoutState(workoutType: _selected!),
          child: workoutScreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(appTitle, style: theme.textTheme.displayMedium),
            ),
            Text(
              'Double your max pull-ups!',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 40),
            Text('Choose your workout type:', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            RadioGroup<WorkoutType>(
              groupValue: _selected,
              onChanged: (WorkoutType? newType) {
                setState(() {
                  _selected = newType;
                });
              },
              child: Column(
                children: WorkoutType.values.map((type) {
                  return RadioListTile<WorkoutType>(
                    value: type,
                    title: Text(type.name),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSubmit,
              child: Text('Start Workout'),
            ),
          ],
        ),
      ),
    );
  }
}
