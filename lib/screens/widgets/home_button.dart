import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const HomeButton({super.key, required this.text, this.icon = Icons.home});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).popUntil((r) => r.isFirst);
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
