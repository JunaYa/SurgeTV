// version_checker.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppVersionChecker {
  // App Store ID，需要替换成你的应用 ID
  static const String appStoreId = 'YOUR_APP_STORE_ID';

  // 检查更新
  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      // 获取 App Store 版本信息
      final response = await http.get(
        Uri.parse('http://itunes.apple.com/lookup?id=$appStoreId'),
      );

      if (response.statusCode != 200) {
        throw 'Failed to check for update';
      }

      final Map<String, dynamic> json = jsonDecode(response.body);
      if (json['resultCount'] == 0) {
        throw 'App not found on App Store';
      }

      final String storeVersion = json['results'][0]['version'];
      final String releaseNotes = json['results'][0]['releaseNotes'] ?? '无更新说明';

      // 比较版本号
      if (_shouldUpdate(currentVersion, storeVersion)) {
        _showUpdateDialog(context, storeVersion, currentVersion, releaseNotes);
      }
    } catch (e) {
      debugPrint('Version check failed: $e');
      // TODO need wip
      _showUpdateDialog(
          context, "storeVersion", "currentVersion", "releaseNotes");
    }
  }

  // 版本号比较逻辑
  static bool _shouldUpdate(String currentVersion, String storeVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> store = storeVersion.split('.').map(int.parse).toList();

    // 确保两个列表长度相同
    while (current.length < store.length) current.add(0);
    while (store.length < current.length) store.add(0);

    // 比较每个版本号部分
    for (int i = 0; i < current.length; i++) {
      if (store[i] > current[i]) return true;
      if (store[i] < current[i]) return false;
    }

    return false;
  }

  // 显示更新对话框
  static void _showUpdateDialog(
    BuildContext context,
    String storeVersion,
    String currentVersion,
    String releaseNotes,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('发现新版本'),
        content: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('当前版本: $currentVersion'),
              Text('最新版本: $storeVersion'),
              const SizedBox(height: 8),
              const Text('更新内容：'),
              Text(
                releaseNotes,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('稍后更新'),
          ),
          FilledButton(
            onPressed: () async {
              final url = Uri.parse(
                'https://apps.apple.com/app/id$appStoreId',
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text('立即更新'),
          ),
        ],
      ),
    );
  }
}
