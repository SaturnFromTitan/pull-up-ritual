import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart' show Workout, WorkoutType;

void main() {
  runApp(MyApp());
}

const title = 'Pull-Up Ritual';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: WorkoutForm(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var completedWorkouts = <Workout>[];
  WorkoutType? activeWorkoutType;

  void setActiveWorkoutType(WorkoutType workoutType) {
    activeWorkoutType = workoutType;
    notifyListeners();
  }
}

class WorkoutForm extends StatefulWidget {
  @override
  State<WorkoutForm> createState() => _WorkoutFormState();
}

class _WorkoutFormState extends State<WorkoutForm> {
  WorkoutType? _selected;

  void _handleSubmit() {
    if (_selected == null) {
      const snackbar = SnackBar(content: Text("Please select a workout type!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    print('Submitted $_selected');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(title, style: theme.textTheme.displayMedium),
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
