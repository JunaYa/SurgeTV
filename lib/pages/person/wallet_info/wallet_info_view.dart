/// WalletInfoBoard is a StatelessWidget that displays the user's wallet information.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:surgetv/components/GradientButton.dart';
import 'package:surgetv/router/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'wallet_info_logic.dart';

class WalletInfoBoard extends StatelessWidget {
  const WalletInfoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<WalletInfoLogic>();
    final state = Bind.find<WalletInfoLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    Color surfaceTint = Theme.of(context).colorScheme.primary;
    TextStyle cardTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return ElevationCard(
      elevation: 1,
      padding: const EdgeInsets.all(16),
      surfaceTintColor: surfaceTint,
      shadowColor: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_balance_wallet),
                    const SizedBox(width: 8),
                    Text(i18n.my_wallet, style: cardTextStyle),
                  ],
                ),
                SizedBox(
                  height: 32,
                  child: GradientButton(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 1),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 244, 220, 86),
                        Color.fromARGB(255, 233, 188, 40),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.shopPage);
                    },
                    child: Text(i18n.recharge, style: cardTextStyle),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(i18n.balance, style: cardTextStyle),
                const Spacer(flex: 1),
                Text('0${i18n.coin}', style: cardTextStyle),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(i18n.member_validity, style: cardTextStyle),
                const Spacer(flex: 1),
                Text('0', style: cardTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
