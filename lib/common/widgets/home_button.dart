import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_up_ritual/common/shell_screen.dart';
import 'package:pull_up_ritual/common/providers/app_provider.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/widgets/gradient_button.dart';

class HomeButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const HomeButton({super.key, required this.text, this.icon = Icons.home});

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      onPressed: () {
        context.read<AppProvider>().resetTab();

        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(Shell.route, (route) => false);
      },
      text: text,
      icon: Icon(icon),
      gradient: AppGradients.light,
    );
  }
}
