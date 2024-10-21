/// WalletInfoBoard is a StatelessWidget that displays the user's wallet information.
library;

import 'package:flutter/material.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:surgetv/components/GradientButton.dart';
import 'package:surgetv/pages/shop.dart';

class WalletInfoBoard extends StatelessWidget {
  const WalletInfoBoard({super.key});

  @override
  Widget build(BuildContext context) {
    Color surfaceTint = Theme.of(context).colorScheme.primary;
    TextStyle cardTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return ElevationCard(
      info: const ElevationInfo(3, 1.0, 1),
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
                    Text('我的钱包', style: cardTextStyle),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopPage()),
                      );
                    },
                    child: Text('充值', style: cardTextStyle),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text('余额', style: cardTextStyle),
                const Spacer(flex: 1),
                Text('0T币', style: cardTextStyle),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('会员有效期', style: cardTextStyle),
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
