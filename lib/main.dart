import 'package:flutter/material.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/pages/index.dart';
import 'package:surgetv/stage/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeManager(),
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  ColorImageProvider imageSelected = ColorImageProvider.leaves;
  ColorScheme? imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod colorSelectionMethod = ColorSelectionMethod.colorSeed;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SurgeTV',
        theme: themeManager.lightTheme,
        darkTheme: themeManager.darkTheme,
        themeMode: themeManager.themeMode,
        home: const IndexPage(),
      ),
    );
  }
}
