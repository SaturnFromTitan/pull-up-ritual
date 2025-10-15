import 'package:flutter/material.dart';

class WorkoutProgressBar extends StatelessWidget {
  final double value;
  const WorkoutProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      borderRadius: BorderRadius.circular(8),
      minHeight: 10,
    );
  }
}
