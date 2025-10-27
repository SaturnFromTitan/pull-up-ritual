import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_up_ritual/common/shell_screen.dart';
import 'package:pull_up_ritual/common/providers/app_provider.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const HomeButton({super.key, required this.text, this.icon = Icons.home});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<AppProvider>().resetTab();

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Shell.route, (route) => false);
      },
      icon: Icon(icon),
      label: Text(text),
    );
  }
}
