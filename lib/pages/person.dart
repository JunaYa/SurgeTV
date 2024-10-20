import 'package:flutter/material.dart';
import 'package:surgetv/components/WalletInfoBoard.dart';
import 'package:surgetv/config/constants.dart';
import 'package:surgetv/pages/login.dart';
import 'package:surgetv/pages/setting.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key, required this.title});

  final String title;

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        // left / right padding 16
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: [
          const SizedBox(height: 20),
          // header login layout
          GestureDetector(
            child: const Row(
              children: <Widget>[
                Text(
                  'SurgeTV',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(padding: EdgeInsetsDirectional.only(end: 16.0)),
                Text(
                  '登录/注册',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // arrow right icon
                Icon(
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                // 播放历史
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.history,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.0)),
                          Text(
                            '播放历史',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
                DividerWidget(),
                // 检测新版本
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.cloud_download_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.0)),
                          Text(
                            '检测新版本',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    Icon(
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
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // 兑换码
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.currency_exchange_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.0)),
                          Text(
                            '兑换码',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    Icon(
                      Icons.arrow_right_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ],
                ),
                const DividerWidget(),
                // 意见反馈
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.chat_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.0)),
                          Text(
                            '意见反馈',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    Icon(
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
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.settings_outlined,
                              size: 24,
                              color: Colors.black,
                            ),
                            Padding(
                                padding: EdgeInsetsDirectional.only(end: 16.0)),
                            Text(
                              '设置',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // arrow right icon
                      Icon(
                        Icons.arrow_right_outlined,
                        size: 24,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                const DividerWidget(),
                // 关于
                const Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.tips_and_updates_outlined,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                              padding: EdgeInsetsDirectional.only(end: 16.0)),
                          Text(
                            '关于',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // arrow right icon
                    Icon(
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
    return Container(
      height: 0.5,
      margin: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
