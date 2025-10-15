import 'package:flutter/material.dart';

class SetCards extends StatelessWidget {
  final List<int> values;
  const SetCards({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      children: [for (var value in values) Chip(label: Text(value.toString()))],
    );
  }
}
