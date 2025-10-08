import 'package:flutter/material.dart';

import 'models.dart' show WorkoutType;
import 'workout_maxsets.dart' show WorkoutMaxSetsScreen;

class HomeForm extends StatefulWidget {
  final String title;

  const HomeForm({super.key, required this.title});

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  WorkoutType? _selected;

  void _handleSubmit() {
    if (_selected == null) {
      const snackbar = SnackBar(content: Text("Please select a workout type!"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutMaxSetsScreen(workoutType: _selected!),
      ),
    );
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
              child: Text(widget.title, style: theme.textTheme.displayMedium),
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
