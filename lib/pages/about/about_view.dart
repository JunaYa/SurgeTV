// about page
import 'package:flutter/material.dart';
import 'package:surgetv/components/DividerWidget.dart';
import 'package:get/get.dart';
import 'package:surgetv/router/app_routes.dart';
import 'about_logic.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Bind.find<AboutLogic>();
    final state = Bind.find<AboutLogic>().state;
    final i18n = AppLocalizations.of(context)!;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
            title: Text('${i18n.about} ${state.packageInfo.value.appName}')),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: <Widget>[
            FieldItemWidget(
              title: i18n.versionInfo,
              subTitle: 'V${state.packageInfo.value.version}',
              showArrow: false,
            ),
            const DividerWidget(),
            // 隐私协议
            FieldItemWidget(
              title: i18n.privacyAgreement,
              showArrow: true,
              onPressed: () {
                Get.toNamed(
                  AppRoutes.webpagePage,
                  arguments: {'url': 'privacy_agreement.html', 'title': '隐私协议'},
                );
              },
            ),
            const DividerWidget(),
            // 用户协议
            FieldItemWidget(
              title: i18n.userAgreement,
              showArrow: true,
              onPressed: () {
                Get.toNamed(
                  AppRoutes.webpagePage,
                  arguments: {'url': 'user_agreement.html', 'title': '用户协议'},
                );
              },
            ),
          ],
        ),
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
