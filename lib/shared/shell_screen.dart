import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/core/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/features/history/presentation/screens/history_screen.dart'
    show HistoryScreen;
import 'package:pull_up_ritual/features/workout/presentation/screens/selection_screen.dart';
import 'package:pull_up_ritual/shared/providers/app_provider.dart';
import 'package:pull_up_ritual/shared/widgets/gradient_navigation_bar.dart';

class Shell extends StatelessWidget {
  static final String route = "/shell";
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return ScreenScaffold(
      bottomNavigationBar: GradientNavigationBar(
        selectedIndex: appProvider.tabIndex,
        onDestinationSelected: appProvider.setTabIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      child: IndexedStack(
        index: appProvider.tabIndex,
        children: [WorkoutSelectionScreen(), HistoryScreen()],
      ),
    );
  }
}
