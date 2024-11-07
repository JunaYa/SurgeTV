import 'package:flutter/material.dart';
import 'package:surgetv/components/CheckInBoard.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          CheckInBoard(),
          SizedBox(height: 16),
          MoreGift(),
          SizedBox(height: 16),
          OtherWelfare(),
        ],
      ),
    );
  }
}

// 标题
class Title extends StatelessWidget {
  const Title({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Text(
        name,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

// 更多福利
class MoreGift extends StatelessWidget {
  const MoreGift({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return ElevationCard(
      elevation: 1,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Title(name: i18n.moreGift),
          const MoreWelfareList(),
        ],
      ),
    );
  }
}

// 更多福利列表
class MoreWelfareList extends StatelessWidget {
  const MoreWelfareList({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Column(
      children: [
        WelfareItem(
          coinCount: 5,
          currentCount: 0,
          totalCount: 1,
          description: i18n.loginFirst,
          buttonText: i18n.login,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 1,
          description: i18n.watchVideo,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: i18n.watchVideo10Minutes,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: i18n.allowNotification,
          buttonText: i18n.allow,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: i18n.followSurgeTV,
          buttonText: i18n.follow,
          onPressed: () {},
        ),
        const DividerWidget(),
        // 绑定邮箱
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: i18n.bindEmail,
          buttonText: i18n.bind,
          onPressed: () {},
        ),
        const DividerWidget(),
        // 分享给脸书
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: i18n.shareToFacebook,
          buttonText: i18n.share,
          onPressed: () {},
        ),
      ],
    );
  }
}

// 其他福利
class OtherWelfare extends StatelessWidget {
  const OtherWelfare({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return ElevationCard(
      elevation: 1,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Title(name: i18n.otherWelfare),
          const OtherWelfareList(),
        ],
      ),
    );
  }
}

// 其他福利列表
class OtherWelfareList extends StatelessWidget {
  const OtherWelfareList({super.key});

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;
    return Column(
      children: [
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.clickTwoAdsOnRecentNews,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.clickTwoImagesToGetReward,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.browseNewsAndClickTwoImages,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.clickTwoAdsOnWebPage,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.clickTwoAdsOnNewsFlash,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.stay15SecondsAndClickTwoImages,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: i18n.clickTwoAdsInOneMinute,
          buttonText: i18n.watch,
          onPressed: () {},
        ),
      ],
    );
  }
}

// 福利列表元素
class WelfareItem extends StatelessWidget {
  const WelfareItem(
      {super.key,
      required this.coinCount,
      required this.currentCount,
      required this.totalCount,
      required this.description,
      this.icon,
      required this.buttonText,
      required this.onPressed});

  final int coinCount;
  // 当前进度
  final int currentCount;
  // 总进度
  final int totalCount;
  // 描述
  final String description;
  // 图标【可选】
  final String? icon;
  // 按钮文字
  final String buttonText;
  // 按钮点击事件
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        );
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/icons/icon_coins.png',
                      width: 14,
                      height: 14,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('$coinCount币', style: textStyle),
                  const SizedBox(width: 8),
                  // totalCount > 0 展示否则隐藏
                  totalCount > 0
                      ? Text('($currentCount/$totalCount)', style: textStyle)
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(80, 30),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Divider(key: Key('divider')),
    );
  }
}
