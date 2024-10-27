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

  bool get useLightMode => switch (themeMode) {
        ThemeMode.system =>
          View.of(context).platformDispatcher.platformBrightness ==
              Brightness.light,
        ThemeMode.light => true,
        ThemeMode.dark => false,
      };

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleMaterialVersionChange() {
    setState(() {
      useMaterial3 = !useMaterial3;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelectionMethod = ColorSelectionMethod.colorSeed;
      colorSelected = ColorSeed.values[value];
    });
  }

  void handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url))
        .then((newScheme) {
      setState(() {
        colorSelectionMethod = ColorSelectionMethod.image;
        imageSelected = ColorImageProvider.values[value];
        imageColorScheme = newScheme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SurgeTV',
        theme: themeManager.lightTheme,
          darkTheme: themeManager.darkTheme,
        themeMode: themeManager.themeMode,
        // theme: ThemeData(
        //   colorSchemeSeed:
        //       colorSelectionMethod == ColorSelectionMethod.colorSeed
        //           ? colorSelected.color
        //           : null,
        //   colorScheme: colorSelectionMethod == ColorSelectionMethod.image
        //       ? imageColorScheme
        //       : null,
        //   useMaterial3: useMaterial3,
        //   brightness: Brightness.light,
        // ),
        // darkTheme: ThemeData(
        //   colorSchemeSeed:
        //       colorSelectionMethod == ColorSelectionMethod.colorSeed
        //           ? colorSelected.color
        //           : imageColorScheme!.primary,
        //   useMaterial3: useMaterial3,
        //   brightness: Brightness.dark,
        // ),
        home: const IndexPage(),
      ),
    );
  }
}
