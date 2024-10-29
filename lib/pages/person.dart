import 'package:flutter/material.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:surgetv/components/WalletInfoBoard.dart';
import 'package:surgetv/components/coupon_dialog.dart';
import 'package:surgetv/components/version_checker.dart';
import 'package:surgetv/pages/about.dart';
import 'package:surgetv/pages/feedback.dart';
import 'package:surgetv/pages/gift.dart';
import 'package:surgetv/pages/login.dart';
import 'package:surgetv/pages/setting.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Future<void> _redeemCoupon(String code) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    if (code == 'TEST123') {
      throw '该优惠券已被使用';
    }
    // 处理兑换逻辑
    debugPrint('兑换成功：$code');
  }

  @override
  Widget build(BuildContext context) {
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
                  'SurgeTV',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: 16),
                Text(
                  '登录/注册',
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
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
                  title: '播放历史',
                  onPressed: () {},
                ),
                const DividerWidget(),
                // 检测新版本
                FieldItemWidget(
                  icon: const Icon(Icons.cloud_download_outlined),
                  title: '检测版本',
                  onPressed: () {
                    AppVersionChecker.checkForUpdate(context);
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
                  title: '兑换码',
                  onPressed: () {
                    CouponDialog.show(
                      context: context,
                      onSubmit: _redeemCoupon,
                      description: '输入您收到的优惠券序列号，兑换专属优惠。\n每个序列号仅能使用一次。',
                    );
                  },
                ),
                const DividerWidget(),
                // 意见反馈
                FieldItemWidget(
                  icon: const Icon(Icons.chat_outlined),
                  title: '意见反馈',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedbackPage()),
                    );
                  },
                ),
                const DividerWidget(),
                // 设置
                FieldItemWidget(
                  icon: const Icon(Icons.settings_outlined),
                  title: '设置',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()),
                    );
                  },
                ),
                const DividerWidget(),
                // 关于
                FieldItemWidget(
                  icon: const Icon(Icons.tips_and_updates_outlined),
                  title: '关于',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
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
