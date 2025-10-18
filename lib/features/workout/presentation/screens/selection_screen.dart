import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/features/workout/data/models.dart'
    show WorkoutType;
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart'
    show WorkoutProvider;
import 'package:pull_up_ritual/features/workout/presentation/screens/max_sets_screen.dart'
    show MaxSetsScreen;
import 'package:pull_up_ritual/features/workout/presentation/screens/ladders_screen.dart'
    show LaddersScreen;
import 'package:pull_up_ritual/features/workout/presentation/screens/submax_volume_screen.dart'
    show SubmaxVolumeScreen;
import 'package:pull_up_ritual/features/workout/presentation/widgets/reps_form.dart'
    show RepsForm;
import 'package:pull_up_ritual/core/constants/app_constants.dart'
    show AppConstants;

class WorkoutSelectionScreen extends StatefulWidget {
  const WorkoutSelectionScreen({super.key});

  @override
  State<WorkoutSelectionScreen> createState() => _WorkoutSelectionScreenState();
}

class _WorkoutSelectionScreenState extends State<WorkoutSelectionScreen> {
  WorkoutType _selected = WorkoutType.maxSets;

  Future<int?> askForTargetReps() async {
    var res = await showDialog<int>(
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
                Text('Enter Your Target Reps', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                RepsForm(
                  onValidSubmit: (int reps) => Navigator.pop(context, reps),
                  onCancel: () => Navigator.pop(context),
                  minValue: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
    return res;
  }

  void _handleSubmit() async {
    StatefulWidget workoutScreen;
    switch (_selected) {
      case WorkoutType.maxSets:
        workoutScreen = MaxSetsScreen();
      case WorkoutType.submaxVolume:
        var targetReps = await askForTargetReps();
        if (!mounted || targetReps == null) return null;
        workoutScreen = SubmaxVolumeScreen(targetReps: targetReps);
      case WorkoutType.ladders:
        workoutScreen = LaddersScreen();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => WorkoutProvider(workoutType: _selected),
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
              child: Text(
                AppConstants.appTitle,
                style: theme.textTheme.displayMedium,
              ),
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
                if (newType == null) return;
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
