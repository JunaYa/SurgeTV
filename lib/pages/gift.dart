import 'package:flutter/material.dart';
import 'package:surgetv/components/CheckInBoard.dart';

class GiftPage extends StatefulWidget {
  const GiftPage({super.key});

  @override
  State<GiftPage> createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
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
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 31, 31, 31),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Text(name,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}

// divider
_divider() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: const Divider(
      height: 0.5,
      color: Color.fromARGB(255, 99, 99, 99),
    ),
  );
}

// 更多福利
class MoreGift extends StatelessWidget {
  const MoreGift({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 20, 20, 20),
        borderRadius: BorderRadius.circular(10),
      ),
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
        _divider(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 1,
          description: '观看1个视频广告即可获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: '今日累计观看10分钟即可获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: '允许通知',
          buttonText: '准许',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 2,
          currentCount: 0,
          totalCount: 0,
          description: '关注 SurgeTV 并打招呼就能获得奖励',
          buttonText: '关注',
          onPressed: () {},
        ),
        _divider(),
        // 绑定邮箱
        WelfareItem(
          coinCount: 3,
          currentCount: 0,
          totalCount: 1,
          description: '绑定邮箱获得奖励',
          buttonText: '绑定',
          onPressed: () {},
        ),
        _divider(),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 20, 20, 20),
        borderRadius: BorderRadius.circular(10),
      ),
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
        _divider(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点击两张图片快速获得奖励',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '浏览新闻并点击两张图片',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点击网页上的2则广告',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '点按新闻快讯上的2个广告',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
        WelfareItem(
          coinCount: 1,
          currentCount: 0,
          totalCount: 5,
          description: '停留15秒并点击2张图片',
          buttonText: '观看',
          onPressed: () {},
        ),
        _divider(),
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
                  Text(
                    '$coinCount币',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  // totalCount > 0 展示否则隐藏
                  totalCount > 0
                      ? Text(
                          '($currentCount/$totalCount)',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(80, 30),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                side: BorderSide(
                  color: Colors.red,
                  width: 1,
                ),
              ),
            ),
            onPressed: onPressed,
            child: Text(buttonText, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
