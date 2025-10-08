import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart' show AppState;
import 'home.dart' show HomeForm;

void main() {
  runApp(App());
}

const title = 'Pull-Up Ritual';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        ),
        home: HomeForm(title: title),
      ),
    );
  }
}
