import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:surgetv/pages/person/coupon_dialog/coupon_dialog_logic.dart';
import 'package:surgetv/pages/person/version_check/version_check_logic.dart';
import 'package:surgetv/pages/gift/gift_view.dart';
import 'package:surgetv/pages/person/wallet_info/wallet_info_view.dart';
import 'package:surgetv/router/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    Color surfaceTint = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        // left / right padding 16
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 20),
          // header login layout
          GestureDetector(
            child: Row(
              children: <Widget>[
                Text(
                  i18n.appName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 16),
                Text(
                  i18n.login,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                // arrow right icon
                const Icon(
                  Icons.arrow_right_outlined,
                  size: 24,
                  color: Colors.black,
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(AppRoutes.loginPage);
            },
          ),
          const SizedBox(height: 20),
          const WalletInfoBoard(),
          const SizedBox(height: 20),
          // layout
          ElevationCard(
            surfaceTintColor: surfaceTint,
            shadowColor: Colors.transparent,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // 播放历史
                FieldItemWidget(
                  icon: const Icon(Icons.history),
                  title: i18n.playHistory,
                  onPressed: () {},
                ),
                const DividerWidget(),
                // 检测新版本
                FieldItemWidget(
                  icon: const Icon(Icons.cloud_download_outlined),
                  title: i18n.checkVersion,
                  onPressed: () {
                    VersionCheckLogic.checkForUpdate(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevationCard(
            surfaceTintColor: surfaceTint,
            shadowColor: Colors.transparent,
            elevation: 1,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // 兑换码
                FieldItemWidget(
                  icon: const Icon(Icons.currency_exchange_outlined),
                  title: i18n.coupon,
                  onPressed: () {
                    CouponDialogLogic.show(context: context);
                  },
                ),
                const DividerWidget(),
                // 意见反馈
                FieldItemWidget(
                  icon: const Icon(Icons.chat_outlined),
                  title: i18n.feedback,
                  onPressed: () {
                    Get.toNamed(AppRoutes.feedbackPage);
                  },
                ),
                const DividerWidget(),
                // 设置
                FieldItemWidget(
                  icon: const Icon(Icons.settings_outlined),
                  title: i18n.setting,
                  onPressed: () {
                    Get.toNamed(AppRoutes.settingPage);
                  },
                ),
                const DividerWidget(),
                // 关于
                FieldItemWidget(
                  icon: const Icon(Icons.tips_and_updates_outlined),
                  title: i18n.about,
                  onPressed: () {
                    Get.toNamed(AppRoutes.aboutPage);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FieldItemWidget extends StatelessWidget {
  const FieldItemWidget(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.title});

  final void Function() onPressed;
  final Widget icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    TextStyle cardTextStyle = Theme.of(context).textTheme.bodyLarge!;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  icon,
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: cardTextStyle,
                  ),
                ],
              ),
            ),
            // const Spacer(),
            // arrow right icon
            const Icon(
              Icons.arrow_right_outlined,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
