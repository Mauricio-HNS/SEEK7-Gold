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
        brightness: Brightness.light,
        scaffoldBackgroundColor: Seek7Colors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Seek7Colors.navy,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Seek7Colors.surface,
          foregroundColor: Seek7Colors.navy,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Seek7Colors.surface,
          indicatorColor: Seek7Colors.blueLight,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.w700, fontSize: 11),
          ),
        ),
        useMaterial3: true,
      ),
      initialRoute: Seek7Routes.splash,
      routes: Seek7Routes.all,
    );
  }
}
