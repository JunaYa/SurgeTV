import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(i18n.playHistory),
        ),
        body: ListView(
          children: [
            Text('empty'),
          ],
        ));
  }
}
