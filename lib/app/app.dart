import 'package:flutter/material.dart';

import '../core/theme/seek7_theme.dart';
import 'routes.dart';

class Seek7App extends StatelessWidget {
  const Seek7App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SEEK7',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Seek7Colors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Seek7Colors.gold,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: Seek7Routes.splash,
      routes: Seek7Routes.all,
    );
  }
}
