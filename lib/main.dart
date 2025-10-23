import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/common/shell_screen.dart';

import 'common/providers/app_provider.dart' show AppProvider;
import 'common/constants/app_constants.dart' show AppConstants;
import 'common/themes/app_theme.dart' show appTheme;

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
        theme: appTheme,
        initialRoute: Shell.route,
        routes: {Shell.route: (context) => Shell()},
      ),
    );
  }
}
