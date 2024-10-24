// about page
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:surgetv/components/DividerWidget.dart';
import 'package:surgetv/pages/webpage.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于 ${_packageInfo.appName}'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: <Widget>[
          FieldItemWidget(
            title: '版本信息',
            subTitle: 'V${_packageInfo.version}',
            showArrow: false,
          ),
          const DividerWidget(),
          // 隐私协议
          FieldItemWidget(
            title: '隐私协议',
            showArrow: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebViewApp(
                    url: 'privacy_agreement.html',
                    title: '隐私协议',
                  ),
                ),
              );
            },
          ),
          const DividerWidget(),
          // 用户协议
          FieldItemWidget(
            title: '用户协议',
            showArrow: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebViewApp(
                    url: 'user_agreement.html',
                    title: '用户协议',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class FieldItemWidget extends StatelessWidget {
  const FieldItemWidget({
    super.key,
    required this.title,
    this.showArrow = true,
    this.subTitle,
    this.onPressed,
  });

  final bool? showArrow;
  final String title;
  final String? subTitle;
  final void Function()? onPressed;

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
            Expanded(flex: 1, child: Text(title, style: cardTextStyle)),
            if (showArrow ?? true)
              const Icon(
                Icons.arrow_right_outlined,
                size: 24,
                color: Colors.black,
              ),
            if (subTitle != null) Text(subTitle!, style: cardTextStyle),
          ],
        ),
      ),
    );
  }
}
