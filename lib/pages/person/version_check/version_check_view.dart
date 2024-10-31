// version_checker.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'version_check_logic.dart';

class VersionCheck extends StatelessWidget {
  const VersionCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<VersionCheckLogic>();
    final state = Bind.find<VersionCheckLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    return Obx(
      () => AlertDialog(
        title: Text(i18n.versionCheckTitle),
        content: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '${i18n.versionCheckCurrentVersion}: ${state.currentVersion.value}'),
              Text(
                  '${i18n.versionCheckStoreVersion}: ${state.storeVersion.value}'),
              const SizedBox(height: 8),
              Text(i18n.versionCheckUpdateContent),
              Text(
                state.releaseNotes.value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(i18n.versionCheckLaterUpdate),
          ),
          FilledButton(
            onPressed: () {
              logic.updateVersion();
            },
            child: Text(i18n.versionCheckUpdateNow),
          ),
        ],
      ),
    );
  }
}
