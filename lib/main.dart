import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state_app.dart' show AppState;
import 'home.dart' show HomeForm, appTitle;

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: HomeForm(),
      ),
    );
  }
}
