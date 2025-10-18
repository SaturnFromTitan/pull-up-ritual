import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/shared/shell_screen.dart';

import 'shared/providers/app_provider.dart' show AppProvider;
import 'core/constants/app_constants.dart' show AppConstants;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        initialRoute: Shell.route,
        routes: {Shell.route: (context) => Shell()},
      ),
    );
  }
}
