import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl_standalone.dart';
import 'package:surgetv/router/app_pages.dart';
import 'package:surgetv/router/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:surgetv/utils/utils.dart';

Future<void> initSystem() async {
  //获取系统语言
  await findSystemLocale();
  //初始化pref
  await Utils().prefUtil.initPref();
}

String getInitialRoute() {
  var initialRoute = AppRoutes.indexPage;
  return initialRoute;
}

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (details) {
      Utils().logUtil.printError('Flutter error',
          error: details.exception, stackTrace: details.stack);
      Utils().noticeUtil.showBug('Flutter error',
          error: details.exception, stackTrace: details.stack);
    };

    await initSystem();

    runApp(GetMaterialApp(
      initialRoute: getInitialRoute(),
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
                Utils().prefUtil.getValue<double>('fontScale')!),
          ),
          child: widget!,
        );
      },
      theme: await Utils().themeUtil.buildTheme(Brightness.light),
      darkTheme: await Utils().themeUtil.buildTheme(Brightness.dark),
      themeMode: ThemeMode.values[Utils().prefUtil.getValue<int>('themeMode')!],
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    ));
  }, (error, stack) {
    Utils()
        .logUtil
        .printError('Flutter error', error: error, stackTrace: stack);
    Utils()
        .noticeUtil
        .showBug('Flutter error', error: error, stackTrace: stack);
  });
}
