import 'package:flutter/material.dart';
import 'package:surgetv/components/CheckInBoard.dart';
import 'package:surgetv/components/ElevationCard.dart';

class GiftPage extends StatelessWidget {
  const GiftPage({super.key});

  @override
  Widget build(BuildContext context) {
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
    return ElevationCard(
      elevation: 1,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: const Column(
        children: [
          Title(name: '更多福利'),
          MoreWelfareList(),
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
    return Column(
      children: [
        WelfareItem(
          coinCount: 5,
          currentCount: 0,
          totalCount: 1,
          description: '用户首次登录可获得登录奖励',
          buttonText: '登录',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 1,
          description: '观看1个视频广告即可获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: '今日累计观看10分钟即可获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: '允许通知',
          buttonText: '准许',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: '关注 SurgeTV 并打招呼就能获得奖励',
          buttonText: '关注',
          onPressed: () {},
        ),
        const DividerWidget(),
        // 绑定邮箱
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: '绑定邮箱获得奖励',
          buttonText: '绑定',
          onPressed: () {},
        ),
        const DividerWidget(),
        // 分享给脸书
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: '分享给脸书',
          buttonText: '分享',
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
    return ElevationCard(
      elevation: 1,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.zero,
      child: const Column(
        children: [
          Title(name: '其它福利'),
          OtherWelfareList(),
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
    return Column(
      children: [
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点击最近新闻上的两则广告',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点击两张图片快速获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '浏览新闻并点击两张图片',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点击网页上的2则广告',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点按新闻快讯上的2个广告',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '停留15秒并点击2张图片',
          buttonText: '观看',
          onPressed: () {},
        ),
        const DividerWidget(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '1分钟内点击两个广告',
          buttonText: '观看',
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
