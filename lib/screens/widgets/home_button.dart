import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_up_ritual/screens/shell.dart' show Shell;
import 'package:pull_up_ritual/states/tab.dart' show TabState;

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const HomeButton({super.key, required this.text, this.icon = Icons.home});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<TabState>().reset();

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Shell.route, (route) => false);
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
