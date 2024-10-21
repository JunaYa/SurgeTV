import 'package:flutter/material.dart';
import 'package:surgetv/components/ElevationCard.dart';
import 'package:surgetv/components/WalletInfoBoard.dart';
import 'package:surgetv/pages/login.dart';
import 'package:surgetv/pages/setting.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    Color surfaceTint = Theme.of(context).colorScheme.primary;
    TextStyle cardTextStyle = Theme.of(context).textTheme.bodyLarge!;
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
            info: const ElevationInfo(1, 1, 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // 播放历史
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.history,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '播放历史',
                            style: cardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
                const DividerWidget(),
                // 检测新版本
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.cloud_download_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '检测版本',
                            style: cardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevationCard(
            surfaceTintColor: surfaceTint,
            shadowColor: Colors.transparent,
            info: const ElevationInfo(1, 1, 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // 兑换码
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.currency_exchange_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '兑换码',
                            style: cardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
                const DividerWidget(),
                // 意见反馈
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.chat_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '意见反馈',
                            style: cardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
                const DividerWidget(),
                // 设置
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    // MaterialPageRoute(
                    //     builder: (context) => SettingPage(
                    //           useLightMode: true,
                    //           useMaterial3: true,
                    //           colorSelected: ColorSeed.blue,
                    //           imageSelected: ColorImageProvider.none, handleBrightnessChange: (bool useLightMode) {  },
                    //         )),
                    // );
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Icons.settings_outlined,
                              size: 24,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              '设置',
                              style: cardTextStyle,
                            ),
                          ],
                        ),
                      ),
                      // arrow right icon
                      const Icon(
                        Icons.arrow_right_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const DividerWidget(),
                // 关于
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.tips_and_updates_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            '关于',
                            style: cardTextStyle,
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    const Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
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
    return const Divider(key: Key('divider'));
  }
}
