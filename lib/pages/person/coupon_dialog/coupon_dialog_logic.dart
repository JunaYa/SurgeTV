import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'coupon_dialog_state.dart';
import 'coupon_dialog_view.dart';

class CouponDialogLogic extends GetxController {
  CouponDialogState state = CouponDialogState();

  final controller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }

  static Future<void> show({
    required BuildContext context,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CouponDialog(),
    );
  }

  // 验证输入的序列号格式
  bool validateCode(String code) {
    // 这里添加你的验证逻辑，例如：
    // - 长度限制
    // - 字符要求
    // - 格式检查
    if (code.isEmpty) {
      state.errorText = '请输入优惠券序列号';
      return false;
    }
    if (code.length < 6) {
      state.errorText = '序列号长度不能小于6位';
      return false;
    }
    state.errorText = null;
    return true;
  }

  Future<void> onSubmit(String code) async {
    // 模拟网络请求
    await Future.delayed(const Duration(seconds: 1));
    if (code == 'TEST123') {
      throw '该优惠券已被使用';
    }
    // 处理兑换逻辑
    debugPrint('兑换成功：$code');
  }

  // 处理提交
  Future<void> handleSubmit() async {
    final code = controller.text.trim();

    if (!validateCode(code)) return;

    state.isSubmitting = true;

    try {
      await onSubmit(code);
      // 关闭对话框
      Get.back();
    } catch (e) {
      state.errorText = e.toString();
      state.isSubmitting = false;
    }
  }
}
