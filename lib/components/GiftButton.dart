import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GiftButton extends StatelessWidget {
  const GiftButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lotties/gift.json",
      height: 48,
      width: 348,
    );
  }
}
