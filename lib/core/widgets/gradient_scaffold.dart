import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const GradientScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.background),
      child: Scaffold(
        body: SafeArea(child: body),
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
