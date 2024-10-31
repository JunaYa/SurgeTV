// Feedback page

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'feedback_logic.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<FeedbackLogic>();
    final state = Get.find<FeedbackLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(i18n.feedback)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevationCard(
                color: Theme.of(context).colorScheme.onPrimary,
                shadowColor: Colors.transparent,
                surfaceTintColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Column(
                  children: [
                    Text(i18n.feedback_email,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 8),
                    Text("support@surgetv.com",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 32),
                    Text("${i18n.feedback_id}: 1234455",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(i18n.copy_email),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "${i18n.feedback_note}",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
