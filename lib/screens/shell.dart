import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/screens/history.dart' show HistoryScreen;
import 'package:pull_up_ritual/screens/selection.dart';
import 'package:pull_up_ritual/states/tab.dart';

class Shell extends StatelessWidget {
  const Shell({super.key});

  @override
  Widget build(BuildContext context) {
    final tab = context.watch<TabState>();

    return Scaffold(
      body: IndexedStack(
        index: tab.index,
        children: [WorkoutSelectionScreen(), HistoryScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: tab.setIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Selection',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
